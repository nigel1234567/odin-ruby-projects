require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'


def clean_zipcode(zipcode)

  # if the zip code is exactly five digits, assume that it is ok
  # if the zip code is more than five digits, truncate it to the first five digits
  # if the zip code is less than five digits, add zeros to the front until it becomes five digits

  # Handling missing zip codes
  # if zipcode.nil?
  #   zipcode = '00000'
  # elsif zipcode.length < 5
    zipcode = zipcode.to_s.rjust(5, '0')[0..4] # Pad the string with zeros and select only first 5 digits --> Making it succinct without need of the other lines of code
    # NOTE: nil.to_s -> ""
  # elsif zipcode.length > 5
  #   zipcode = zipcode[0..4]
  # else
  #   zipcode
  # end
end

def clean_phone_numbers(phone_number)
  phone_number.gsub!(/[^\d]/, '')
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11 && phone_number[0] == "1"
    phone_number[1..10]
  else
    "Wrong Number!!"
  end
end


def legislators_by_zipcode(zip)
  # From Google API Civic Info
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials

    legislator_name = legislators.map(&:name)

    legislators_string = legislator_name.join(", ")
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

# Thank you letter
def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output') # Make new directory named "output" unless it exists

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def count_frequency(array)
  array.max_by {|a| array.count(a)}
end

puts 'Event Manager Initialized!'

# Test
  # lines = File.readlines('event_attendees.csv')
  # row_index = 0
  # lines.each do |line|
  #   # Skip header row
  #   # next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
  #   row_index = row_index + 1
  #   next if row_index == 1
  #   # Split string to array
  #   columns = line.split(",")
  #   # We want to access our 'first_name' (3rd column or 3rd element at array's second index columns[2])
  #   name = columns[2]
  #   puts name
  # end

# Parse using CSV
contents = CSV.open(
  'event_attendees.csv', 
  headers: true,
  header_converters: :symbol # Convert headers to symbols
)
contents_size = CSV.read('event_attendees.csv').length
template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter
contents_size -= 1
hour_of_day = Array.new(contents_size)
day_of_week = Array.new(contents_size)
j = 0
cal = {0=>"sunday", 1=>"monday", 2=>"tuesday", 3=>"wednesday", 4=>"thursday", 5=>"friday", 6=>"saturday"}

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  phone_number = clean_phone_numbers(row[:homephone])
  reg_date = row[:regdate]
  i = ((row[0].to_f/contents_size)*100)
  puts "--------#{i.round(2)}%--------"

  reg_date_to_print = DateTime.strptime(reg_date,"%m/%d/%y %H:%M")
  hour_of_day[j] = reg_date_to_print.hour
  day_of_week[j] = reg_date_to_print.wday
  j+=1

  # personal_letter = template_letter.gsub('FIRST_NAME', name)
  # personal_letter.gsub!('LEGISLATORS', legislators)

  form_letter = erb_template.result(binding) # Binding returns a special object

  save_thank_you_letter(id, form_letter)
end

puts "Most Active Hour is: #{count_frequency(hour_of_day)}"
puts "Most Active Day is: #{cal[count_frequency(day_of_week)].capitalize}"