import Foundation

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

struct Galaxy: Equatable, Hashable {
    let id: Int
    let x: Int
    let y: Int
}

func countNumDiff(first: Int, second: Int, arr: [Int]) -> Int {
    var numDiff = 0
    for num in arr {
        if (num > first && num < second) || (num < first && num > second) { numDiff += 1 }
    }
    return numDiff
}


func distance(gal1: Galaxy, gal2: Galaxy, doubleRows: [Int], doubleCols: [Int]) -> Int {
    let xDiff = countNumDiff(first: gal1.x, second: gal2.x, arr: doubleCols)
    let yDiff = countNumDiff(first: gal1.y, second: gal2.y, arr: doubleRows)
    
    return abs(gal1.x - gal2.x) + abs(gal1.y - gal2.y) + (xDiff + yDiff) * (1000000 - 1) 
}

if let fileUrl = Bundle.main.url(forResource: "day11Input", withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let tmpLines = contents.split(separator: "\n", omittingEmptySubsequences: false)
        var lines = tmpLines.compactMap { String($0) }
        
//        var linesCopy = [String]()
        
        var rowNums = [Int]()
        
        for (i, line) in lines.enumerated() {
            if line == "" { continue }
            
            var containsPound = false
            for char in line {
                if char == "#" {
                    containsPound = true
                    break
                }
            }
            
            if !containsPound {
//                var dotString = ""
//                for _ in 0..<line.count { dotString += "." }
//                linesCopy.append(dotString)
                rowNums.append(i)
            }
            
//            linesCopy.append(line)
        }

        var colNums = [Int]()
        
        
        
        // TODO: if this doesn't work, change these back to linesCopy rather than lines
        
        for x in 0..<lines[0].count {
            var containsPound = false
            
            for y in 0..<lines.count {
                if let cur = lines[safe: y]?.sub(x), cur == "#"  {
                    containsPound = true
                }
            }
            
            if !containsPound {
                colNums.append(x)
            }
        }
        
        
//        for num in colNums.reversed() {
//            for y in 0..<linesCopy.count {
//                linesCopy[y].insert(".", at: linesCopy[y].index(linesCopy[y].startIndex, offsetBy: num))
//            }
//        }
        
        print(rowNums)
        print(colNums)
        
        // linesCopy should now be my input
        
        var allGalaxies = [Galaxy]()
        var id = 1
        
        for (y, line) in lines.enumerated() {
            for (x, char) in line.enumerated() {
                if char == "#" {
                    allGalaxies.append(.init(id: id, x: x, y: y))
                    id += 1
                }
            }
        }
        
//        for line in linesCopy { print(line) }
        
        var lengthSum = 0
        
        for i in 0..<allGalaxies.count - 1 {
            for j in i+1..<allGalaxies.count {
                lengthSum += distance(gal1: allGalaxies[i], gal2: allGalaxies[j], doubleRows: rowNums, doubleCols: colNums)
            }
        }
                
        print("length sum: \(lengthSum)")
    } catch {
        print("error occurred")
    }
}
