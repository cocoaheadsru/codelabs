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
    
    for i in (0..<array.count) {
        for j in (i..<array.count) {
            if i + j == target {
                return [i, j]
            }
        }
    }
    return [2, 3]
}

// Ожидаемый ответ [2, 3]
findTarget(16, in: integers)
