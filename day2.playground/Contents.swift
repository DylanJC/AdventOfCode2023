import Foundation

let fileName = "day1Input"

enum Constants {
    static let blue = /(\d+) blue/
    static let red = /(\d+) red/
    static let green = /(\d+) green/

    static let maxRed = 12
    static let maxGreen = 13
    static let maxBlue = 14
}

func validGame(matches: [Regex<Regex<(Substring, Substring)>.RegexOutput>.Match], maxNum: Int) -> Bool {
    for match in matches {
        if Int(match.output.1) ?? 0 > maxNum {
            return false
        }
    }
    
    return true
}

if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let lines = contents.split(separator: "\n", omittingEmptySubsequences: false)

        var partASum = 0

        for (lineNum, line) in lines.enumerated() {
            if line == "" { continue }
            
            if
                validGame(matches: line.matches(of: Constants.blue), maxNum: Constants.maxBlue),
                validGame(matches: line.matches(of: Constants.green), maxNum: Constants.maxGreen),
                validGame(matches: line.matches(of: Constants.red), maxNum: Constants.maxRed)
            {
                partASum += lineNum + 1
            }
        }
        
        var partBSum = 0
        
        lines.forEach { line in
            partBSum += [line.matches(of: Constants.blue), line.matches(of: Constants.red), line.matches(of: Constants.green)]
                .compactMap { matches in
                    matches
                        .compactMap { Int($0.output.1) }
                        .max() ?? 0
                }
                .reduce(1, *)
        }

        print("part A sum: \(partASum)")
        print("part B sum: \(partBSum)")
    } catch {
        print("contents could not be loaded")
    }
}


//func countMatches(matches: [Regex<Output>.Match]) -> Bool {
//
//}

