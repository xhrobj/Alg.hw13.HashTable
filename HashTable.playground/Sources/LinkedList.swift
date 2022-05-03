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
    
    public mutating func append(key: Key, value: Value) {
        guard !isEmpty else {
            push(key: key, value: value)
            return
        }
        tail?.next = Node(key: key, value: value)
        tail = tail?.next
    }
    
    @discardableResult
    public mutating func insert(key: Key, value: Value, after node: Node<Key, Value>) -> Node<Key, Value> {
        guard tail !== node else {
            append(key: key, value: value)
            return tail!
        }
        node.next = Node(key: key, value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        guard let head = head else {
            return nil
        }
        guard head.next != nil else {
            return pop()
        }
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Key, Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
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
            return "Empty list"
        }
        return String(describing: head)
    }
}
