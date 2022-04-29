class Node
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :root, :data

  def initialize(array)
    array = array.sort.uniq
    @data = array
    start_idx = 0
    end_idx = array.length - 1
    @root = build_tree(array, start_idx, end_idx)
  end

  # Build balanced BST
  def build_tree(array, start_idx = 0, end_idx = array.length - 1)
    if start_idx > end_idx
      nil
    else
      mid_idx = (start_idx + end_idx) / 2
      root = Node.new(array[mid_idx])
      root.left = build_tree(array, start_idx, mid_idx - 1)
      root.right = build_tree(array, mid_idx + 1, end_idx)
      root
    end
  end

  # Insert
  def insert(value, node = @root)
    return nil if value == node.data
    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  # Delete
  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # If node has one or no child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # If node has two children
      leftmost_node = leftmost_leaf(node.right)
      node.data = leftmost_node.data
      node.right = delete(leftmost_node.data, node.right)
    end
    node
  end

  def leftmost_leaf(node)
    node = node.left until node.left.nil?
    node
  end

  # Find
  def find(value, node = @root)
    return node if node.nil? || node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  # Visualise BST
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # Level-order method
  def level_order(root = @root)
    queue = []
    if root.nil?
      return nil
    else
      queue.push(root)
      # If queue is not empty
      while queue.length > 0
        current = queue[0]
        puts current.data
        # If current node's left child is not nil, push into back of array
        if current.left != nil
          queue.push(current.left)
        end
        # If current node's right child is not nil, push into back of array
        if current.right != nil
          queue.push(current.right)
        end
        # Remove element at front of queue
        queue.shift
      end
    end
  end

  # Inorder
  def inorder(root = @root)
    if root == nil
      return
    end
    inorder(root.left)
    puts root.data
    inorder(root.right)
  end

  # Preorder
  def preorder(root = @root)
    if root == nil
      return
    end
    puts root.data
    preorder(root.left)
    preorder(root.right)
  end

  # Postorder
  def postorder(root = @root)
    if root == nil
      return
    end
    postorder(root.left)
    postorder(root.right)
    puts root.data
  end

  # Height (from node to leaf node)
  def height(node = @root)
    if node != nil
      a = self.height(node.left)
      b = self.height(node.right)
      # Return height of largest subtree
      if a > b
        return a + 1
      else
        return b + 1
      end
    else
      return 0
    end
  end

  # Depth (from root node to given node)
  def depth(node = @root, parent = @root, edges = 0)
    return 0 if node == parent
    return -1 if parent.nil?

    if node < parent.data
      edges += 1
      depth(node, parent.left, edges)
    elsif node > parent.data
      edges += 1
      depth(node, parent.right, edges)
    else
      edges
    end
  end

  # Check if tree is balanced: Difference between heights of left and right subtree of every node not more than 1
  def balanced?(node = root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)

    false
  end

  # Rebalance unbalanced tree
  def rebalance
    self.data = inorder_array
    self.root = build_tree(data)
  end

  # Inorder array
  def inorder_array(node = @root, array = [])
    unless node.nil?
      inorder_array(node.left, array)
      array << node.data
      inorder_array(node.right, array)
    end
    array
  end
end

# Driver script

# 1. Create a binary search tree from an array of random numbers
array = (Array.new(15) {rand(1..100)})
x = Tree.new(array)
x.pretty_print

# 2. Confirm tree is balanced
x.balanced?

# 3. Print out all elements in level, pre, post and in order
x.level_order
x.preorder
x.postorder
x.inorder

# 4. Unbalance tree by adding several numbers > 100
x.insert(250)
x.insert(500)
x.pretty_print

# 5. Confirm that tree is unbalanced
x.balanced?

# 6. Balance the tree
x.rebalance
x.pretty_print

# 7. Confirm that tree is balanced
x.balanced?

# 8. Print out all elements in level, pre, post and in order again
x.level_order
x.preorder
x.postorder
x.inorder