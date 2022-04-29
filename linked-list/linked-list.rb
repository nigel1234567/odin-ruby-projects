class LinkedList

  attr_reader :list

  def initialize
    @list = []
  end

  # Add new node containing value to end of list
  def append(value)
    new_node = Node.new(value)
    @list.push(new_node)
    if @list.length > 1
      @list[-2].update_next(new_node)
    end
  end

  # Add new node containing value to start of list
  def prepend(value)
    @list.length > 0 ? new_node = Node.new(value, @list[0]) : new_node = Node.new(value)
    list.unshift(new_node)
  end

  # Return total number of nodes in the list
  def size
    @list.length
  end

  # Return first node in list
  def head
    @list[0]
  end

  # Return last node in list
  def tail
    @list[-1]
  end

  # Return node at a given index
  def at(index)
    @list[index]
  end

  # Remove last element from the list
  def pop
    @list.pop
    @list[-1].update_next(nil)
  end

  # Returns true if the passed in value is in the list, otherwise return false
  def contains?(value)
    @list.each do |node|
      if node.value == value
        return true
      end
      return false
    end
  end

  # Returns index of the node containing value, or nil if not found
  def find(value)
    @list.each_with_index do |node, index|
      if node.value == value
        return index
      end
    end
    return nil
  end

  # Represent LinkedList objects as strings, so you can print them out to preview them in console. Format: (value) -> (value) -> (value) -> nil
  def to_s
    string = ""
    @list.each do |node|
      string = string + "#{node.value} -> "
    end
    string = string + "nil"
    string
  end

  # Insert new node with provided value at given index
  def insert_at(value, index)
    if @list.length >= index + 1
      new_node = Node.new(value, @list[index])
      if index - 1 >= 0
        @list[index-1].update_next(new_node)
      end
      @list.insert(index, new_node)
    else
      nil
    end
  end

  # Remove node at given index
  def remove_at(index)
    if @list.length >= index + 1
      @list.delete_at(index)
      @list[index-1].update_next(@list[index])
    end
  end
end

# Node class
class Node
  attr_reader :value, :next_node
  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end

  # Update next node
  def update_next(next_node)
    @next_node = next_node
  end
end
