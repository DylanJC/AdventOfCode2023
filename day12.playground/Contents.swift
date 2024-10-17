import Foundation



if let fileUrl = Bundle.main.url(forResource: "day12Input", withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let tmpLines = contents.split(separator: "\n", omittingEmptySubsequences: false)
        let lines = tmpLines.compactMap { String($0) }
        
        print("sum: \(calculateSum(lines: lines))")
    } catch {
        print("error occurred")
    }
}

// 6874 is too high SADDDD
