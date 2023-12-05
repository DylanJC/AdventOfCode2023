import Foundation

enum Constants {
    static let fileName = "day1Input"
    static let numbersMap: [String: Int] = ["one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9]
    static let allRegex = [/(1)/, /(2)/, /(3)/, /(4)/, /(5)/, /(6)/, /(7)/, /(8)/, /(9)/, /(one)/, /(two)/, /(three)/, /(four)/, /(five)/, /(six)/, /(seven)/, /(eight)/, /(nine)/]
}

if let fileUrl = Bundle.main.url(forResource: Constants.fileName, withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let lines = contents.split(separator: "\n", omittingEmptySubsequences: false)
        
        var sum = 0
        
        lines.forEach { line in
            var allIndices = [String.Index: Int]()
            
            Constants.allRegex.forEach { regex in
                line.matches(of: regex)
                    .forEach { match in
                        if let num = Int(match.output.0) {
                            allIndices[match.range.lowerBound] = num
                        } else {
                            let str = String(match.output.0)
                            // Part A: comment the following line out. Part B: uncomment the following line.
                            allIndices[match.range.lowerBound] = Constants.numbersMap[str]!
                        }
                    }
            }
            
            if
                let minKey = allIndices.keys.min(),
                let maxKey = allIndices.keys.max(),
                let min = allIndices[minKey],
                let max = allIndices[maxKey]
            {
                
                sum += Int("\(min)\(max)")!
            }
        }
        
        print("sum: \(sum)")
    } catch {
        print("contents could not be loaded")
    }
}


