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

enum Direction {
    case Left, Right, Up, Down
}

enum AccuracyMult:Float {
    case Fail = 0.0, Ok = 0.8, Good = 1.0, Perfect = 1.25

enum BeatAccuracy:Int {
    //6 + fail
    //5 to 4 ok
    // 3 to 2 good
    // 1 to 0 perfect
    case Fail = 6, Ok = 5, Good = 3, Perfect = 1
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
    
    var selectedSquare:EnemySquare!
    
    var currentBeat:Int = 1
    var currentSquareState:SquareState = .None
    var beatFrameCounter:Int = 0
    var beatFrameThreshold:Int = 30
    
    var currentAccuracyMult:AccuracyMult = .Fail
    var currentBeatAccuracy:BeatAccuracy = .Fail
    
    var gestureRecognized:Bool = false
    
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
        beatFrameCounter++
        if (beatFrameCounter >= beatFrameThreshold && gestureRecognized) {
            //beat recognized between 30 - 35 frames
            incrementBeat()
            gestureRecognized = false
            beatFrameCounter = beatFrameCounter - beatFrameThreshold //extra difference is added on
        }
        if (beatFrameCounter == beatFrameThreshold + BeatAccuracy.Fail.rawValue && !gestureRecognized) {
            //fail after 36 frames
            //assert that beatFramCounter does not go past 36 frames
            incrementBeat()
            gestureRecognized = false
            currentBeatAccuracy
            beatFrameCounter = BeatAccuracy.Fail.rawValue //6 frames
            
            //fail animation
        }

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
        leftSquare.setup(100, level: 1, damage: 10, dodgeRate: 0.7, defendRate: 0.8, damageMult: 1.0, defendMult: 1.0, dodgeMult: 1.0)
        self.addChild(leftSquare)
        
        middleSquare = HeroSquare(texture: SKTexture(imageNamed: "SquareGeneric"), size: CGSizeMake(50,50))
        middleSquare.anchorPoint = CGPointMake(0.5, 0.5)
        middleSquare.position = CGPointMake(self.frame.width/2, offset)
        middleSquare.color = .greenColor()
        middleSquare.blendMode = .Alpha
        middleSquare.colorBlendFactor = 0.5
        middleSquare.setup(80, level: 1, damage: 15, dodgeRate: 0.5, defendRate: 0.5, damageMult: 1.0, defendMult: 1.0, dodgeMult: 1.0)
        self.addChild(middleSquare)
        
        rightSquare = HeroSquare(texture: SKTexture(imageNamed: "SquareGeneric"), size: CGSizeMake(50,50))
        rightSquare.anchorPoint = CGPointMake(0.5, 0.5)
        rightSquare.position = CGPointMake(self.frame.width * 0.70, offset)
        rightSquare.color = .blueColor()
        rightSquare.blendMode = .Alpha
        rightSquare.colorBlendFactor = 0.5
        rightSquare.setup(120, level: 1, damage: 7, dodgeRate: 0.9, defendRate: 0.9, damageMult: 1.0, defendMult: 1.0, dodgeMult: 1.0)
        self.addChild(rightSquare)
    }
    
    func swipeLeft() {
        handleGestureWithGesture(.Left)
    }
    
    func swipeRight() {
        handleGestureWithGesture(.Right)
    }
    
    func swipeUp() {
        handleGestureWithGesture(.Up)
    }
    
    func swipeDown() {
        handleGestureWithGesture(.Down)
    }
    
    func incrementBeat() {
        if (currentBeat == 8) {
            currentBeat = 1
        } else {
            currentBeat = currentBeat + 1
        }
    }
    
    func handleGestureWithGesture(gesture:Direction) {
        if (gestureRecognized) {
            //if there was already a gesture within the last beat, skip the entire loop
            if (currentBeat <= 4) {
                currentSquareState = .None
                //do nothing
                //this is just in case i wanna do something later
            }
            if (currentBeat == 5) {
                //first beat is for action specific
                switch (gesture) {
                    case .Left:
                        currentSquareState = .Charge
                        break
                    case .Right:
                        currentSquareState = .Dodge
                        break
                    case .Up:
                        currentSquareState = .Attack
                        break
                    case .Down:
                        currentSquareState = .Defend
                        break
                    default:
                        currentSquareState = .None
                        break
                }
            }
            //probs should make this more efficient
            if (currentBeat == 6 || currentBeat == 7 || currentBeat == 8) {
                handleActionWithGesture(gesture, state: currentSquareState, beat: currentBeat)
            }
            gestureRecognized = true
        }
    }
    
    func handleActionWithGesture(gesture:Direction, state:SquareState, beat:Int) {
        switch (gesture) {
            case .Left:
                leftSquare.handleActionWithState(state, beat:beat, selected:selectedSquare, accuracy:currentAccuracyMult)
                break
            case .Right:
                rightSquare.handleActionWithState(state, beat:beat, selected:selectedSquare, accuracy:currentAccuracyMult)
                break
            case .Up:
                //maybe use to switch targets?
                break
            case .Down:
                middleSquare.handleActionWithState(state, beat:beat, selected:selectedSquare, accuracy:currentAccuracyMult)
                break
        }
    }
    
}
