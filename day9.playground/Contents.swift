import Foundation

enum Constants {
    static let regex = /-?\d+/
}

extension String {
    func sub(_ num: Int) -> Character? {
        guard num > 0 && num < self.count else { return nil }
        
        return self[self.index(self.startIndex, offsetBy: num)]
    }
}

func allZeroes(arr: [Int]) -> Bool {
    for num in arr {
        if num != 0 { return false }
    }
    
    return true
}

func getDiff(_ arr: [Int]) -> [Int] {
    var diff = [Int]()
    
    for i in 0..<arr.count - 1 {
        diff.append(arr[i+1] - arr[i])
    }
    
    return diff
}

func extrapolatePos(from arr: [Int]) -> Int {
    var finalNum = 0
    
    var arrCopy = arr
    
    arrCopy.remove(at: arrCopy.count - 1)
    
    var rev = Array(arrCopy.reversed())

    for i in 0..<rev.count {
        finalNum += rev[i]
    }
    
    return finalNum
}

func extrapolateNeg(from arr: [Int]) -> Int {
    var finalNum = 0
    
    var arrCopy = arr
    
    arrCopy.remove(at: arrCopy.count - 1)
    
    var rev = Array(arrCopy.reversed())
    
    for i in 0..<rev.count {
        finalNum = rev[i] - finalNum
    }
    
    return finalNum
}

if let fileUrl = Bundle.main.url(forResource: "day9Input", withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let tmpLines = contents.split(separator: "\n", omittingEmptySubsequences: false)
        let lines = tmpLines.compactMap { String($0) }
        
        var sum = 0

        for line in lines {
            if line == "" { continue }

            var endNums = [Int]()
            let matches = line.matches(of: Constants.regex).compactMap { Int($0.output) }

            var curArr = matches

            while !allZeroes(arr: curArr) {
                let diffArr = getDiff(curArr)
                endNums.append(diffArr.last!)
                curArr = diffArr
            }

            endNums.insert(matches.last!, at: 0)

            let newEnd = extrapolatePos(from: endNums)

            sum += newEnd
        }
        
        var partBSum = 0
        
        for line in lines {
            if line == "" { continue }
            
            var startNums = [Int]()
            let matches = line.matches(of: Constants.regex).compactMap { Int($0.output) }
            
            var curArr = matches
            
            while !allZeroes(arr: curArr) {
                let diffArr = getDiff(curArr)
                startNums.append(diffArr.first!)
                curArr = diffArr
            }
            
            startNums.insert(matches.first!, at: 0)
            
            let newStart = extrapolateNeg(from: startNums)

            partBSum += newStart
        }

        print("sum of extrapolate: \(sum)")
        print("sum part B: \(partBSum)")
    } catch {
        print("error occurred")
    }
}




// Solutions were LCM of 12599, 21389, 13771, NDA: 17873, HCA: 15529, PBA: 17287
