import Foundation

enum Constants {
    static let digitRegex = /(\d+)/
}

func binarySearchMin(start: Int, end: Int, record: Int, totalTime: Int) -> Int {
    guard start != end, start + 1 != end else {
        if start * (totalTime - start) <= record {
            return end
        }
        return start
    }
    
    let mid = (end-start)/2 + start
    
    if mid * (totalTime - mid) <= record {
        return binarySearchMin(start: mid, end: end, record: record, totalTime: totalTime)
    }
    
    return binarySearchMin(start: start, end: mid, record: record, totalTime: totalTime)
}

if let fileUrl = Bundle.main.url(forResource: "day6Input", withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let tmpLines = contents.split(separator: "\n", omittingEmptySubsequences: false)
        let lines = tmpLines.compactMap { String($0) }

        var waysToWin = 1

        let racetimes = lines[0]
            .matches(of: Constants.digitRegex)
            .compactMap { Int($0.output.1) }
        let recordTimes = lines[1]
            .matches(of: Constants.digitRegex)
            .compactMap { Int($0.output.1) }
        
        for (i, raceTime) in racetimes.enumerated() {
            let minTime = binarySearchMin(start: 1, end: raceTime, record: recordTimes[i], totalTime: raceTime)
            let numWinners = (raceTime - minTime * 2) + 1

            waysToWin *= numWinners
        }

        print("Number of ways to beat record: \(waysToWin)")
    } catch {
        print("error occurred")
    }
}
