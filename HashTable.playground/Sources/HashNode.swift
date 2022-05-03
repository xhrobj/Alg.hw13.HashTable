public class Node<Key: Hashable, Value> {
    public var key: Key
    public var value: Value
    public var next: Node?
    
    public init(key: Key, value: Value, next: Node? = nil) {
        self.key = key
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(key):\(value)"
        }
        return "\(key):\(value) -> " + String(describing: next) + " "
    }
}
