import Foundation

enum Constants {
    static let regex = /-?\d+/
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

// 0, 0 is top left
struct Coord: Equatable {
    let x: Int
    let y: Int
}

class GenericError: Error { }

var lines = [""]

func exploreAround(currentLoc: Coord, prevLoc: Coord, curChar: Character) -> Coord {
    
    if curChar == "S" {
        if
            prevLoc.x != currentLoc.x && prevLoc.y != currentLoc.y - 1,
            let top = lines[safe: currentLoc.y - 1]?.sub(currentLoc.x)
        {
            if top == "|" || top == "F" || top == "7" {
                return .init(x: currentLoc.x, y: currentLoc.y - 1)
            }
        }
        
        if
            prevLoc.x != currentLoc.x - 1 && prevLoc.y != currentLoc.y,
            let left = lines[safe: currentLoc.y]?.sub(currentLoc.x - 1)
        {
            if left == "-" || left == "F" || left == "L" {
                return .init(x: currentLoc.x - 1, y: currentLoc.y)
            }
        }
        
        if
            prevLoc.x != currentLoc.x + 1 && prevLoc.y != currentLoc.y,
            let right = lines[safe: currentLoc.y]?.sub(currentLoc.x + 1)
        {
            if right == "-" || right == "J" || right == "7" {
                return .init(x: currentLoc.x + 1, y: currentLoc.y)
            }
        }
        
        return .init(x: currentLoc.x, y: currentLoc.y + 1)
    }
    
    let above = Coord(x: currentLoc.x, y: currentLoc.y - 1)
    let below = Coord(x: currentLoc.x, y: currentLoc.y + 1)
    let left = Coord(x: currentLoc.x - 1, y: currentLoc.y)
    let right = Coord(x: currentLoc.x + 1, y: currentLoc.y)
    
    if curChar == "|" {
        if prevLoc == above {
            return below
        }
        return above
    }
    
    if curChar == "-" {
        if prevLoc == left {
            return right
        }
        
        return left
    }
    
    if curChar == "7" {
        if prevLoc == left {
            return below
        }
        
        return left
    }
    
    if curChar == "L" {
        if prevLoc == above {
            return right
        }
        
        return above
    }
    
    if curChar == "J" {
        if prevLoc == above {
            return left
        }
        
        return above
    }
    
    if curChar == "F" {
        if prevLoc == below {
            return right
        }
        
        return below
    }
    
    
    print("got here but shouldn't have")
    return above
}

if let fileUrl = Bundle.main.url(forResource: "day10Input", withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let tmpLines = contents.split(separator: "\n", omittingEmptySubsequences: false)
        lines = tmpLines.compactMap { String($0) }

        var numSteps = 0

        var startingLoc: Coord?
        
        for (y, line) in lines.enumerated() {
            for (x, char) in line.enumerated() {
                if char == "S" {
                    startingLoc = .init(x: x, y: y)
                }
            }
        }
        
        guard let startingLoc else { throw GenericError() }
        
        print(startingLoc)
        
        var currentLoc = startingLoc
        var prevLoc = startingLoc
        
        var firstRound = true
        
        while (currentLoc != startingLoc || firstRound){
            firstRound = false
            
            let curChar = lines[safe: currentLoc.y]?.sub(currentLoc.x)
            let tmpLoc = currentLoc
            currentLoc = exploreAround(currentLoc: currentLoc, prevLoc: prevLoc, curChar: curChar ?? ".")
            
            prevLoc = tmpLoc
            numSteps += 1
        }
        
        print("num steps: \(numSteps / 2)")
    } catch {
        print("error occurred")
    }
}

