# using Ruby 2.5.3

class LinkedList
	# a singly linked list

	attr_reader :head, :tail, :count
	# initialize the linked list
	# accepts up to one value
	def initialize(value=nil)
		@count = 0
		@tail = nil

		if value != nil
			@head = LinkedListNode.new(value)
			@tail = @head
			increment_count
		else
			@head = nil
			puts "Creating an empty list"
		end
	end

	def iterate
		# iterates the entire list and
		# returns an array of the list data
		this_node = @head
		result = [this_node.data]
		result.push(this_node.data) while this_node = this_node.next_node
		return result
	end

	def search(search)
		this_node = @head

		return true if this_node.data == search
		return true if this_node.data == search while this_node = this_node.next_node

		return false
	end

	def add_head(value)
		if @head != nil
			new_node = LinkedListNode.new(value, @head)

			@head = new_node
		else
			@head = LinkedListNode.new(value)
		end

		increment_count
	end

	def add_tail(value)
		if @tail != nil
			new_node = LinkedListNode.new(value)

			@tail.next_node=(new_node)

			@tail = new_node
		else
			# if the tail is nil, add node as next value of head node
			@tail = LinkedListNode.new(value)
			@head.next_node=(@tail)
		end

		increment_count
	end

	private

	def increment_count
		@count += 1
	end
end

class LinkedListNode
	attr_accessor :next_node
	attr_reader :data
	
	# a node in the list
	def initialize(data=nil, next_node=nil)
		@data = data
		@next_node = next_node
	end
end

# Testing the class

# create list with data
linkedlist = LinkedList.new("1233")

# get head of list, output data
puts "Head data: #{linkedlist.head.data}"

# add new node to head
linkedlist.add_head(1234)

# get new head, output data
puts "New head data: #{linkedlist.head.data}"

# get next node, output data
puts "Next data: #{linkedlist.head.next_node.data}"

# get count of list nodes
puts "Count: #{linkedlist.count}"

# add more items
linkedlist.add_head("String")
linkedlist.add_head(12345)
linkedlist.add_head("truish")
linkedlist.add_head("falsy")
linkedlist.add_head("empty array")

# output list contents with iterate
puts "Array of data from iterate: #{linkedlist.iterate.to_s}"

# output new list count
puts "New count: #{linkedlist.count}"

# returns true because has value "falsy"
puts "Expect true: #{linkedlist.search("falsy")}"

# returns true because has empty array value
puts "Expect true: #{linkedlist.search("empty array")}"

# add new tail node
linkedlist.add_tail(123456)

# get all nodes again
puts "Add tail and iterate again: #{linkedlist.iterate.to_s}"

# get new count
puts "New count: #{linkedlist.count}"

# get tail node
puts "Tail node: #{linkedlist.tail.data}"

# get head node
puts "Head node: #{linkedlist.head.data}"