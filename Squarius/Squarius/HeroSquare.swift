//
//  HeroSquare.swift
//  Squarius
//
//  Created by Brian Wang on 1/18/16.
//  Copyright © 2016 Brian Wang. All rights reserved.
//

import UIKit
import SpriteKit

class HeroSquare: Square {
    
    var damage:Int!
    var hp:Int!
    var exp:Int!
    var expToNextLevel:Int!
    var level:Int!
    
    var dodgeRate:Float = 0.70 //70% chance to ignore damage
    var defendRate:Float = 0.80 //90% of damage negated
    
    var damageMult:Float = 1.0
    var defendMult:Float = 1.0
    var dodgeMult:Float = 1.0
    
    var hasAttacked:Bool = false
    
    var currentState:SquareState = .None
    
    
    func setup(hp:Int, level:Int, damage:Int, dodgeRate:Float, defendRate:Float, damageMult:Float, defendMult:Float, dodgeMult:Float) {
        self.hp = hp
        self.level = level
        self.damage = damage
        self.dodgeRate = dodgeRate
        self.defendRate = defendRate
        self.damageMult = damageMult
        self.defendMult = defendMult
        self.dodgeMult = dodgeMult
    }
    
    func randomize() {
        
    }
    
    func attack(beat:Int, selected:EnemySquare, accuracy:AccuracyMult) {
        let attackDamage:Int = Int(Float(self.damage!)*accuracy.rawValue*damageMult) //damage * accuracy * damage mult
        let attack:Attack = Attack.init(damage: attackDamage, dodgeable:false)
        
        //do animations here
        
        selected.handleAttack(self, attack:attack)
    }
    
    func defend(beat:Int, accuracy:AccuracyMult) {
        //defend animation
    }
    
    func dodge(beat:Int, accuracy:AccuracyMult) {
        //dodge animation
    }
    
    func charge(beat:Int, accuracy:AccuracyMult) {
        //charge animation
    }
    
    func handleAttack(selected:Square, attack:Attack) {
        switch(currentState) {
        case .Attack:
            hp = hp - attack.damage
            //damage animation
            break
        case .Defend:
            hp = hp - attack.damage * Int(1 - defendRate * defendMult)
            //defend animation
            break
        case .Charge:
            hp = hp - attack.damage
            //damage animation
            break
        case .Dodge:
            if (attack.dodgeable) {
                let lowerBound:Int = 0
                let upperBound:Int = Int(100 * dodgeRate)
                let selected:Int = Int(arc4random_uniform(UInt32(upperBound + 1)))
                if (selected >= lowerBound && selected <= upperBound) {
                    //dodge animation
                    //do nothing
                }
            } else {
                hp = hp - attack.damage
            }
            break
        case .None:
            hp = hp - attack.damage
            //damage animation
            break
        }
    }
    
    func handleActionWithState(state:SquareState, beat:Int, selected:EnemySquare, accuracy:AccuracyMult) {
        currentState = state
        switch(state) {
        case .Attack:
            attack(beat, selected:selected, accuracy:accuracy)
            break
        case .Defend:
            defend(beat, accuracy:accuracy)
            break
        case .Charge:
            charge(beat, accuracy:accuracy)
            break
        case .Dodge:
            dodge(beat, accuracy:accuracy)
            break
        case .None:
            
            break
        }
    }
}
