public struct LinkedList<Key: Hashable, Value> {
    public var head: Node<Key, Value>?
    public var tail: Node<Key, Value>?
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public init() {}
    
    public mutating func push(key: Key, value: Value) {
        head = Node(key: key, value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    @discardableResult
    public mutating func pop() -> Node<Key, Value>? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Key, Value>) -> Node<Key, Value>? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next
    }
    
    public func node(at index: Int) -> Node<Key, Value>? {
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "·" // NOTE: Empty list
        }
        return String(describing: head)
    }
}
