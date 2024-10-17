import Foundation

enum Constants {
    static let regex = /\w\w\w/
    static let targetNode = "ZZZ"
}

struct Node: Hashable {
    let name: String
    
    // TODO: would be nice to change these to Node
    let left: String
    let right: String    
}

enum Turn {
    case left
    case right
}

class GenericError: Error { }

var numSteps = 0

var num = 0

func allEndNodes(nodes: [Node]) -> Bool {
    for node in nodes {
        if node.name.last! == "Z" {
            print(node.name)
            print(numSteps)
        }
        if node.name.last! != "Z" { return false }
    }
    
    num += 1
    
    if num == 3 { return true} else { return false }
    
//    return true
}

if let fileUrl = Bundle.main.url(forResource: "day8Input", withExtension: "txt"){
    do {
        let contents = try String(contentsOf: fileUrl, encoding: .utf8)
        let tmpLines = contents.split(separator: "\n", omittingEmptySubsequences: false)
        let lines = tmpLines.compactMap { String($0) }

        
        let instructions: [Turn] = lines[0].compactMap {
            if $0 == "L" {
                return .left
            } else if $0 == "R" {
                return .right
            }
            
            return nil
        }
        
        var nodes = [String: Node]()
        
        for line in lines {
            let matches = line
                .matches(of: Constants.regex)
                .compactMap { String($0.output) }
            
            guard matches.count == 3 else { continue }
            
            nodes[matches[0]] = .init(name: matches[0], left: matches[1], right: matches[2])
        }
        
        var startingNodes = nodes.filter { $0.key.last! == "A" }.compactMap { $0.value }
        
//        var endingNodes = nodes.filter { $0.key.last! == "Z" }
        
        print(startingNodes[4])
        var currentNodes = [startingNodes[4]]
        
        var x = 0

        while !allEndNodes(nodes: currentNodes) {
//        while x < 2 {
            for instruction in instructions {
                if allEndNodes(nodes: currentNodes) { break }
                
                numSteps += 1
                
                var currentNodesCopy = currentNodes
                
                for (i, node) in currentNodes.enumerated() {
                    
                    // I can't add and remove nodes from this one set. Issue because some nodes might be bouncing between the same. Just use an array instead.
                    
                    switch instruction {
                    case .left:
                        currentNodesCopy.remove(at: i)
                        currentNodesCopy.insert(nodes[node.left]!, at: i)
                    case .right:
                        currentNodesCopy.remove(at: i)
                        currentNodesCopy.insert(nodes[node.right]!, at: i)
                    }
                }
                
                currentNodes = currentNodesCopy
            }
        }
        
        
        
//        while currentNode.name != Constants.targetNode {
//            for instruction in instructions {
//                if currentNode.name == Constants.targetNode {
//                    break
//                }
//
//                numSteps += 1
//
//                switch instruction {
//                case .left:
//                    currentNode = nodes[currentNode.left]!
//                case .right:
//                    currentNode = nodes[currentNode.right]!
//                }
//            }
//        }

        print("number of steps: \(numSteps)")
    } catch {
        print("error occurred")
    }
}




// Solutions were LCM of 12599, 21389, 13771, NDA: 17873, HCA: 15529, PBA: 17287
