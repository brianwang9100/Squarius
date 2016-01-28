//
//  Attack.swift
//  Squarius
//
//  Created by Brian Wang on 1/23/16.
//  Copyright © 2016 Brian Wang. All rights reserved.
//

import UIKit

class Attack: AnyObject {
    var damage:Int = 0
    var dodgeable:Bool = true
    
    init(damage:Int, dodgeable:Bool) {
        self.damage = damage
        self.dodgeable = dodgeable
    }
}
