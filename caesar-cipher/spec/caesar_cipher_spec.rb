#spec/caesar_cipher_spec.rb

require './lib/caesar-cipher'

describe "Caesar Cipher TDD" do
  describe "string test" do
    it "returns encoded string" do
      expect(caesar_cipher("what", 5)).to eq("bmfy")
    end

    it "returns encoded string with negative number input" do
      expect(caesar_cipher("what", -1)).to eq("vgzs")
    end

    it "returns empty string" do
      expect(caesar_cipher("", 5)).to eq("")
    end

  end
  
  describe "sentence test" do
    it "returns encoded sentence" do
      expect(caesar_cipher("what a string", 5)).to eq("bmfy f xywnsl")
    end

    it "works for capitalisation" do
      expect(caesar_cipher("WHAT a string", 5)).to eq("BMFY f xywnsl")
    end

    it "works with special symbols" do
      expect(caesar_cipher("What a string!", 5)).to eq("Bmfy f xywnsl!")
    end
  end 
end