import Foundation

public func calculateSum(lines: [String]) -> Int {
    var sum = 0
    
    for line in lines {
        if line == "" { continue }
//        print(i)
        
        let numHash = line.matches(of: /#/).count
        let neededHash = line.matches(of: /\d+/).compactMap { Int($0.output) }
//            print(neededHash)
//            print(numHash)
        
        let totalHash = neededHash.reduce(0, +)
        
        let numToPlace = totalHash - numHash
        
//            print(numToPlace)
        
        // TODO: probably need this
//        if isValidString(str: line, numHash: neededHash) { sum += 1 }
        
        
        
//            var stringToTest = line
//            var remaining = numToPlace
//
//            for i in 0..<stringToTest.count {
//                stringToTest = line
//                remaining = numToPlace
//
//                while stringToTest !=
//
//                while remaining > 0 {
//                    if stringToTest[
//                }
//            }


        let questionIndexes = line.matches(of: /\?/).compactMap { $0.range.lowerBound }
//            print(line)
        
        let combinations = generateUnique(items: questionIndexes, num: numToPlace)
        
        var total = 0
        
        for combo in combinations {
            var stringToTest = line
            
            for index in combo {
                stringToTest.replaceSubrange(index...index, with: "#")
            }
            
//                print(stringToTest)
            
            if isValidString(str: stringToTest, numHash: neededHash) {
//                print(stringToTest)
                sum += 1
                total += 1
            }
        }
        
//        print(total)

//            print()
//            print(line)
//            sum += 1
    }
    
    return sum
}


extension String {
    func sub(_ num: Int) -> Character? {
        guard num < self.count else { return nil }
        
        return self[self.index(self.startIndex, offsetBy: num)]
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public func isValidString(str: String, numHash: [Int]) -> Bool {
    let matches = str.matches(of: /#+/)
    let totalNum = matches.compactMap { $0.output.count }.reduce(0, +)
    let matchesLens = matches.compactMap { $0.output.count }

    guard totalNum == numHash.reduce(0, +), matchesLens == numHash else { return false }

    for i in 0..<matches.count {
        if matches[i].output.count != numHash[i] { return false }
    }
    
    return true
}

public func generateUnique<T>(items: [T], num: Int) -> [[T]] {
    var result = [[T]]()
    
    func backtrack(pool: [T], curArr: [T]) {
        if curArr.count == num {
            result.append(curArr)
        }

        var arrCopy = curArr
        
        for x in 0..<pool.count {
            arrCopy.append(pool[x])
            backtrack(pool: Array(pool[x + 1..<pool.count]), curArr: arrCopy)
            _ = arrCopy.popLast()
        }
    }
    
    backtrack(pool: items, curArr: [])
    return result
}
