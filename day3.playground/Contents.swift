import Foundation

let fileName = "day1Input"

extension String {
    func sub(_ num: Int) -> Character? {
        guard num > 0 && num < self.count else { return nil }
        
        return self[self.index(self.startIndex, offsetBy: num)]
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

func symbolAround(i: Int, j: Int, lines: [String]) -> Bool {
    let positionsToCheck: [Character] = [
        lines[safe: i-1]?.sub(j-1),
        lines[safe: i]?.sub(j-1),
        lines[safe: i+1]?.sub(j-1),
        lines[safe: i-1]?.sub(j),
        lines[safe: i-1]?.sub(j+1),
        lines[safe: i]?.sub(j+1),
        lines[safe: i+1]?.sub(j),
        lines[safe: i+1]?.sub(j+1)
    ].compactMap { $0 }
    
    var hasSymbol = false
    
    positionsToCheck.forEach {
        if ($0.isPunctuation || $0.isSymbol) && $0 != "." {
            hasSymbol = true
        }
    }
    
    return hasSymbol
}

struct starIndex: Hashable {
    let i: Int
    let j: Int
}

struct star {
    let index: starIndex
}
    
func starsAround(i: Int, j: Int, lines: [String]) -> [star] {
    var starList = [star]()

    for x in i-1...i+1 {
        for y in j-1...j+1 {
            if lines[safe: x]?.sub(y) == "*" {
                starList.append(.init(index: .init(i: x, j: y)))
            }
        }
    }

    return starList
}



if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let tmpLines = contents.split(separator: "\n", omittingEmptySubsequences: false)
        let lines = tmpLines.compactMap { String($0) }

        var partASum = 0

        for (i, line) in lines.enumerated() {
            var curNum = ""
            var hasSymbolAround = false

            for (j, char) in line.enumerated() {
                if let digit = char.wholeNumberValue {
                    curNum += String(digit)

                    if !hasSymbolAround {
                        hasSymbolAround = symbolAround(i: i, j: j, lines: lines)
                    }
                }

                if curNum != "" && (!char.isWholeNumber || j + 1 == line.count) {
                    if hasSymbolAround {
                        let convertedNum = Int(curNum)!
                        partASum += convertedNum
                    }

                    curNum = ""
                    hasSymbolAround = false
                }
            }
        }

        print("part a sum: \(partASum)")
        
        var starMap = [starIndex: [Int]]()
        
        var partBSum = 0
        
        for (i, line) in lines.enumerated() {
            var curNum = ""
            var hasStarAround = false
            var stars = [star]()
            
            for (j, char) in line.enumerated() {
                if let digit = char.wholeNumberValue {
                    curNum += String(digit)
                    
                    if !hasStarAround {
                        stars = starsAround(i: i, j: j, lines: lines)
                        
                        hasStarAround = !stars.isEmpty
                    }
                }
                
                if curNum != "" && (!char.isWholeNumber || j + 1 == line.count) {
                    if hasStarAround {
                        let convertedNum = Int(curNum)!
                        
                        stars.forEach { star in
                            if starMap.keys.contains(where: { $0 == star.index }) {
                                starMap[star.index]?.append(convertedNum)
                            } else {
                                starMap[star.index] = [convertedNum]
                            }
                        }
                    }

                    curNum = ""
                    hasStarAround = false
                    stars = []
                }
            }
        }
        
        starMap.values.forEach { nums in
            guard nums.count == 2 else { return }
            
            partBSum += nums[0] * nums[1]
        }
        
        print("part B sum: \(partBSum)")
        
    } catch {
        print("contents could not be loaded")
    }
}





// 11255051 too high
