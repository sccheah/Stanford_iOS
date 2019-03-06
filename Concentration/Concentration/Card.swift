//
//  Card.swift
//  Concentration
//
//  Created by Stanley Cheah on 3/5/19.
//  Copyright © 2019 Stanley Cheah. All rights reserved.
//

/* Differences between struct and class:
    1) Structs have no inheritance
    2) Structs are value types, class are reference types
 */

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
}
