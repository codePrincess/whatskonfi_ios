// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let manu = "manu" + " is" + " awesome"

var manuArray = ["manu", " is", " awesome"]
manuArray.append("!!")
manuArray += " and this really works...!"
manuArray += ["truely", " awesome"]


for (index, item) in enumerate(manuArray) {
    println("item at \(index) is \(item)")
}


let max: NSNumber = manuArray.count
manuArray[2...6] = [" again its manu"]
manuArray.insert(" ha!", atIndex: 2)
manuArray[0] = "hoi"
manuArray.removeLast()


println("The array contains \(manuArray.count) items")


for manuItem in manuArray {
    println(manuItem)
}









