//
//  GameScene.swift
//  Squarius
//
//  Created by Brian Wang on 1/15/16.
//  Copyright (c) 2016 Brian Wang. All rights reserved.
//

import SpriteKit

enum SquareState {
    case Attack, Defend, Charge, Dodge, None
}

class GameScene: SKScene {
    let offset:CGFloat = 100.0
    var leftrec:UISwipeGestureRecognizer!
    var rightrec:UISwipeGestureRecognizer!
    var uprec:UISwipeGestureRecognizer!
    var downrec:UISwipeGestureRecognizer!
    
    var enemySquare:EnemySquare!
    var leftSquare: HeroSquare!
    var middleSquare: HeroSquare!
    var rightSquare: HeroSquare!
    
    var currentBeat:Int = 1
    var currentSquareState:SquareState = .None
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!"
//        myLabel.fontSize = 45
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        leftrec = UISwipeGestureRecognizer.init(target: self, action: Selector("swipeLeft"))
        leftrec.direction = UISwipeGestureRecognizerDirection.Left
        rightrec = UISwipeGestureRecognizer.init(target: self, action: Selector("swipeRight"))
        rightrec.direction = UISwipeGestureRecognizerDirection.Right
        uprec = UISwipeGestureRecognizer.init(target: self, action: Selector("swipeUp"))
        uprec.direction = UISwipeGestureRecognizerDirection.Up
        downrec = UISwipeGestureRecognizer.init(target: self, action: Selector("swipeDown"))
        downrec.direction = UISwipeGestureRecognizerDirection.Down
        
        loadSquares()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func loadSquares() {
        enemySquare = EnemySquare(texture: SKTexture(imageNamed: "SquareGeneric"), size: CGSizeMake(100,100))
        enemySquare.anchorPoint = CGPointMake(0.5, 0.5)
        enemySquare.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        enemySquare.color = .grayColor()
        enemySquare.blendMode = .Alpha
        enemySquare.colorBlendFactor = 0.5
        self.addChild(enemySquare)
        
        leftSquare = HeroSquare(texture: SKTexture(imageNamed: "SquareGeneric"), size: CGSizeMake(50,50))
        leftSquare.anchorPoint = CGPointMake(0.5, 0.5)
        leftSquare.position = CGPointMake(self.frame.width * 0.30, offset)
        leftSquare.color = .redColor()
        leftSquare.blendMode = .Alpha
        leftSquare.colorBlendFactor = 0.5
        self.addChild(leftSquare)
        
        middleSquare = HeroSquare(texture: SKTexture(imageNamed: "SquareGeneric"), size: CGSizeMake(50,50))
        middleSquare.anchorPoint = CGPointMake(0.5, 0.5)
        middleSquare.position = CGPointMake(self.frame.width/2, offset)
        middleSquare.color = .greenColor()
        middleSquare.blendMode = .Alpha
        middleSquare.colorBlendFactor = 0.5
        self.addChild(middleSquare)
        
        rightSquare = HeroSquare(texture: SKTexture(imageNamed: "SquareGeneric"), size: CGSizeMake(50,50))
        rightSquare.anchorPoint = CGPointMake(0.5, 0.5)
        rightSquare.position = CGPointMake(self.frame.width * 0.70, offset)
        rightSquare.color = .blueColor()
        rightSquare.blendMode = .Alpha
        rightSquare.colorBlendFactor = 0.5
        self.addChild(rightSquare)
    }
    
    func swipeLeft() {
        
    }
    
    func swipeRight() {
        
    }
    
    func swipeUp() {
        
    }
    
    func swipeDown() {
        
    }
    
    func incrementBeat() {
        if (currentBeat == 8) {
            currentBeat = 1
        } else {
            currentBeat = currentBeat + 1
        }
    }
    
    func handleGesture(gesture:String) {
        if (currentBeat == 5) {
            switch (gesture) {
                case "left":
                    currentSquareState = .Charge
                    break
                case "right":
                    currentSquareState = .Dodge
                    break
                case "up":
                    currentSquareState = .Attack
                    break
                case "down":
                    currentSquareState = .Defend
                    break
                default:
                    currentSquareState = .None
                    break
            }
        }
        
        //probs should make this more efficient
        if (currentBeat == 6) {
            
        }
        if (currentBeat == 7) {
            
        }
        if (currentBeat == 8) {
            
        }
        
        incrementBeat()
    }
    
}
