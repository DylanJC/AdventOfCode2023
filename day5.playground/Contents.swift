import Foundation

enum Constants {
    static let digits = /\d+/
}

if let fileUrl = Bundle.main.url(forResource: "day5Input", withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let tmpLines = contents.split(separator: "\n", omittingEmptySubsequences: false)
        let lines = tmpLines.compactMap { String($0) }

        let seeds = lines[0].matches(of: Constants.digits)
        
        var lowestLocationNumber = Int.max
        
        for seed in seeds {
            let seedMap = [Int: Int]()
            
            
        }
    } catch {
        print("contents could not be loaded")
    }
}
