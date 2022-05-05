var hashTable = HashTable<String, Int>()

example(of: "Исходное состояние HashTable:") {
    print(hashTable)
}

example(of: "Добавим несколько (9) элементов:") {
    hashTable.insert(key: "dog", with: 1)
    print(hashTable)

    hashTable.insert(key: "god", with: 2)
    print(hashTable)

    hashTable.insert(key: "anna", with: 3)
    print(hashTable)

    hashTable.insert(key: "marina", with: 4)
    print(hashTable)

    hashTable.insert(key: "👿", with: 5)
    print(hashTable)

    hashTable.insert(key: "😎", with: 6)
    print(hashTable)

//    hashTable.insert(key: "🤖", with: 7)
//    print(hashTable)
//
//    hashTable.insert(key: "💩", with: 8)
//    print(hashTable)
//
//    hashTable.insert(key: "👾", with: 9)
//    print(hashTable)
}

let key1 = "dog"

example(of: "Перезапишем элемент с ключом \"\(key1)\":") {
    hashTable.insert(key: key1, with: 10)
    print(hashTable)
}

example(of: "Поиск элемента с ключом \"\(key1)\":") {
    if let value = hashTable.value(for: key1) {
        print("Найдено. Значение =", value)
    } else {
        print("Не найдено")
    }
}

example(of: "Удаление элемента с ключом \"\(key1)\":") {
    hashTable.remove(key: key1)
    print(hashTable)
}

example(of: "Поиск элемента с ключом \"\(key1)\":") {
    if let value = hashTable.value(for: key1) {
        print("Найдено. Значение =", value)
    } else {
        print("Не найдено")
    }
}
