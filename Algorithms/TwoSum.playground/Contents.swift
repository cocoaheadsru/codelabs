/*
 MBLTdev CodeLabs by CocoaHeads
 Algoritms
 Two Sum
 */

import Foundation
import PlaygroundSupport

let integers: [Int] = [2, 5, 4, 12, 7]

/*
 Фукция должна возвращать индексы двух чисел из массива array,
 сумма которых равна переданному значению target
 */
func findTarget(_ target: Int, in array: [Int]) -> [Array<Int>.Index] {
    
    var arr: [(Int, Int)] = []
    array.enumerated().forEach { (offset, element) in
        array.enumerated().enumerated().forEach({ (offset2, element2) in
            if offset + offset2 == target {
                arr.append((offset, offset2))
            }
        })
    }
    
    return arr
}

// Ожидаемый ответ [2, 3]
findTarget(16, in: integers)
