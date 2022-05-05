public struct HashTable<Key: Hashable, Value> {
    private let loadFactor = 0.75
    private let storageCapacityDefault = 3

    private var storage: [LinkedList<Key, Value>]
    private var size = 0
    private var threshold: Int
    private var storageCapacity: Int {
        storage.count
    }
    
    public init() {
        storage = Array(repeating: LinkedList<Key, Value>(), count: storageCapacityDefault)
        threshold = Int(Double(storageCapacityDefault) * loadFactor)
    }
    
    public func value(for key: Key) -> Value? {
        let index = storageIndex(for: key)
        let bucket = storage[index]

        var node = bucket.head
        while node != nil {
            if node!.key == key {
                return node!.value
            }
            node = node!.next
        }
        return nil
    }
    
    public mutating func insert(key: Key, with val: Value) {
        guard value(for: key) == nil else {
            replace(val, for: key)
            return
        }
        add(val, for: key)
        rehash()
    }
    
    public mutating func remove(key: Key) {
        let index = storageIndex(for: key)
        var bucket = storage[index]

        guard let indexBeforeNodeRemoved = indexBeforeNode(with: key, in: bucket) else {
            return
        }

        if indexBeforeNodeRemoved < 0 {
            bucket.pop()
        } else {
            bucket.remove(after: bucket.node(at: indexBeforeNodeRemoved)!)
        }
        storage[index] = bucket
        size -= 1
    }
}

extension HashTable {
    private func storageIndex(for key: Key) -> Int {
        abs(key.hashValue % storageCapacity)
    }
    
    private func indexBeforeNode(with key: Key, in bucket: LinkedList<Key, Value>) -> Int? {
        var index = -1
        var node = bucket.head
        while node != nil {
            if node!.key == key {
                return index
            }
            node = node!.next
            index += 1
        }
        return nil
    }
    
    private func replace(_ value: Value, for key: Key) {
        let index = storageIndex(for: key)
        let bucket = storage[index]
        
        var node = bucket.head
        while node != nil {
            if node!.key == key {
                node!.value = value
                return
            }
            node = node!.next
        }
    }
    
    private mutating func add(_ value: Value, for key: Key) {
        let index = storageIndex(for: key)
        storage[index].push(key: key, value: value)
        size += 1
    }

    private mutating func rehash() {
        guard size > threshold else { return }

        let storageCapacityNew = storageCapacity * 2
        var storageNew = Array(repeating: LinkedList<Key, Value>(), count: storageCapacityNew)
        for i in 0..<storage.count {
            var bucket = storage[i]
            while !bucket.isEmpty {
                if let node = bucket.pop() {
                    let index = abs(node.key.hashValue % storageCapacityNew)
                    storageNew[index].push(key: node.key, value: node.value)
                }
            }
        }
        storage = storageNew
        threshold = Int(Double(storageCapacityNew) * loadFactor)
    }
}

extension HashTable: CustomStringConvertible {
    public var description: String {
        var result = ""
        for (i, data) in storage.enumerated() {
            result += "[\(String(i, radix: 16, uppercase: true))]: \(data)\n"
        }
        return result
    }
}
