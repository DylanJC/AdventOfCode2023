import Foundation

enum Constants {
    static let digitRegex = /(\d+)/
}

if let fileUrl = Bundle.main.url(forResource: "day4Input", withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let tmpLines = contents.split(separator: "\n", omittingEmptySubsequences: false)
        let lines = tmpLines.compactMap { String($0) }

        var sum = 0

        for line in lines {
            guard let verticalIndex = line.lastIndex(of: "|") else { continue }
            
            var winningNums = Set<Int>()
            var lineScore = 0

            for (i, match) in line.matches(of: Constants.digitRegex).enumerated() {
                // want to skip the first number on the line because it's just the line number. "card `num`:"
                guard i != 0, let num = Int(match.output.0) else { continue }

                if match.range.lowerBound < verticalIndex {
                    winningNums.insert(num)
                } else if winningNums.contains(num) {
                    lineScore = lineScore == 0 ? 1 : lineScore * 2
                }
            }

            sum += lineScore
        }
        
        var scratchCards = [Int: Int]()
        lines.forEach { line in
            guard let match = line.firstMatch(of: Constants.digitRegex), let lineNum = Int(match.output.0) else { return }
            
            scratchCards[lineNum] = 1
        }

        for (lineNum, line) in lines.enumerated() {
            guard let verticalIndex = line.lastIndex(of: "|") else { continue }
            
            var winningNums = Set<Int>()
            var numMatches = 0

            for (i, match) in line.matches(of: Constants.digitRegex).enumerated() {
                // want to skip the first number on the line because it's just the line number. "card `num`:"
                guard i != 0, let num = Int(match.output.0) else { continue }

                if match.range.lowerBound < verticalIndex {
                    winningNums.insert(num)
                } else if winningNums.contains(num) {
                    numMatches += 1
                }
            }

            if numMatches > 0, lineNum + 2 < lines.count, let curCardCount = scratchCards[lineNum + 1] {
                for nextLine in lineNum + 2...lineNum + 1 + numMatches {
                    
                    scratchCards[nextLine]! += curCardCount
                }
            }
        }
        
        print("part a: \(sum)")
        print("part b: \(scratchCards.values.reduce(0, +))")
    } catch {
        print("contents could not be loaded")
    }
}
