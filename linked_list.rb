# using Ruby 2.5.3

class LinkedList
	# a singly linked list
	# nodes can be added at the beginning or the end of the list (for implementing stacks and queues later)
	# a list can be searched for known values using the `search` method, which returns true if the value is found

	attr_reader :head, :tail, :count
	# initialize the linked list
	# accepts one value
	# raise exception for empty list since it's pretty hard to deal with otherwise
	def initialize(value=nil)
		@count = 0
		@tail = nil

		if value != nil
			@head = LinkedListNode.new(value)
			@tail = @head
			increment_count
		else
			raise "I'd prefer that you didn't make an empty list"
		end
	end

	def iterate
		# iterates the entire list and returns an array of the list data in the order encountered
		if @head != nil
			this_node = @head
			result = [this_node.data]
			result.push(this_node.data) while this_node = this_node.next_node
			return result
		else
			raise "The list would have to be empty, how did you even reach this case?"
		end
	end

	def search(term)
		# returns true if the value is found in the list
		# consider changing this behavior to return the node
		this_node = @head

		return true if this_node.data == term
		return true if this_node.data == term while this_node = this_node.next_node

		return false
	end

	def find_last
		# find the last node in the list, for use with `add_tail`
		# consider making private :shrug:
		# this could now be `find_index(@count - 1)`
		this_node = @head
		return this_node if this_node.next_node == nil while this_node = this_node.next_node
	end

	def find_index(idx)
		# method uses zero-based indexing, so index cannot exceed @count - 1
		if idx == nil
			raise "Index cannot be nil"
		elsif idx >= @count
			raise "Index cannot exceed the number of nodes minus one"			
		else
			this_node = @head
			idx.times do
				this_node = this_node.next_node
			end
			return this_node
		end
	end

	def add_head(value)
		if @head != nil
			# if head exists create new node with current head as next value, set new node to head
			new_node = LinkedListNode.new(value, @head)

			@head = new_node
		else
			# probably a moot case since head can't be nil now...
			# until node deletion is supported, maybe

			# anyways, create a new node with nil next pointer and set to head instance variable
			@head = LinkedListNode.new(value)
		end

		increment_count
	end

	def add_tail(value)
		if @tail != nil
			# create new node
			new_node = LinkedListNode.new(value)
			# set current tail's next pointer to the new node
			@tail.next_node=(new_node)
			# set tail to the new node
			@tail = new_node
		else
			# if the tail is nil, add node as next value of head node
			# this case should be extraneous since eliminating empty lists
			@tail = LinkedListNode.new(value)

			last_node = find_last
			last_node.next_node=(@tail)
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

# find last node and output data
puts "Last node data: #{linkedlist.find_last.data}"

# find an arbitrary node and output data
puts "Node at index 3: #{linkedlist.find_index(3).data}"

# find the first node (index 0)
puts "Node at index 0: #{linkedlist.find_index(0).data}"

# Uncomment for intentionally failing cases

# what happens when i search for a non-existent node?
# puts "Non-existent node: #{linkedlist.find_index(10)}"

# what happens when i attempt to initialize an empty list?
# puts "Creating an empty list: #{LinkedList.new}"