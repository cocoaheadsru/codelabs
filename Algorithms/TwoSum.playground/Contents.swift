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
//func findTarget(_ target: Int, in array: [Int]) -> [Array<Int>.Index] {
//    // Ваша реализация
//    for i in 0..<array.count {
//        for j in i+1..<array.count {
//            if array[i] + array[j] == target {
//                return [i, j]
//            }
//        }
//    }
//
//    return []
//}

func findTarget(_ target: Int, in array: [Int]) -> [Array<Int>.Index] {
    // Ваша реализация
    var dict = [Int: Int]()
    
    for i in 0..<array.count {
        dict[array[i]] = i
    }
    
    for key in dict.keys {
        if let anotherIndex = dict[target - key] {
            return [dict[key]!, anotherIndex]
        }
    }
    
    return []
}

// Ожидаемый ответ [2, 3]
findTarget(16, in: integers)

