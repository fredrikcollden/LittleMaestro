//
//  Bird.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-11-20.
//  Copyright © 2015 Marie. All rights reserved.
//

import SpriteKit


class Bird: SKNode {

    let birdBody: SKSpriteNode
    let eyeLeft: SKSpriteNode
    let eyeRight: SKSpriteNode
    let pupilLeft: SKSpriteNode
    let pupilRight: SKSpriteNode
    let beakTop: SKSpriteNode
    let beakBottom: SKSpriteNode
    let footLeft: SKSpriteNode
    let footRight: SKSpriteNode
    let wingLeft: SKSpriteNode
    let wingRight: SKSpriteNode
    
    var eyeLeftPosition = CGPoint(x:-16, y:47)
    var eyeRightPosition = CGPoint(x:16, y:47)
    var pupilLeftPosition = CGPoint(x:-16, y:47)
    var pupilRightPosition = CGPoint(x:16, y:47)
    var beakTopPosition = CGPoint(x:0, y:30)
    var beakBottomPosition = CGPoint(x:0, y:32)
    var footLeftPosition = CGPoint(x:-10, y:-3)
    var footRightPosition = CGPoint(x:10, y:-3)
    var wingLeftPosition = CGPoint(x:-30, y:20)
    var wingRightPosition = CGPoint(x:30, y:20)

    
    var zOrigin:CGFloat
    var tintEffect:CGFloat = 0.5
    
    //Animations
    let beakOpen:SKAction
    let beakClose:SKAction
    
    
    init(texture: SKTexture, zPos: CGFloat, tintColor: SKColor?=SKColor.clearColor()){
        
        beakOpen = SKAction.scaleXBy(1.00, y: 1.8, duration: 0.2)
        beakClose = beakOpen.reversedAction()
        
        self.zOrigin = zPos
        birdBody = SKSpriteNode(texture: texture, color: tintColor!, size: texture.size())
        eyeLeft = SKSpriteNode(imageNamed: "eye")
        eyeRight = SKSpriteNode(imageNamed: "eye")
        pupilLeft = SKSpriteNode(imageNamed: "pupil")
        pupilRight = SKSpriteNode(imageNamed: "pupil")
        beakTop = SKSpriteNode(imageNamed: "topbeak")
        beakBottom = SKSpriteNode(imageNamed: "bottombeak")
        footLeft = SKSpriteNode(imageNamed: "foot")
        footRight = SKSpriteNode(imageNamed: "foot")
        wingLeft = SKSpriteNode(imageNamed: "leftwing")
        wingRight = SKSpriteNode(imageNamed: "rightwing")
        
        super.init()
        
        eyeLeft.position = eyeLeftPosition
        eyeRight.position = eyeRightPosition
        pupilLeft.position = pupilLeftPosition
        pupilRight.position = pupilRightPosition
        beakTop.position = beakTopPosition
        beakBottom.position = beakBottomPosition
        footLeft.position = footLeftPosition
        footRight.position = footRightPosition
        wingLeft.position = wingLeftPosition
        wingRight.position = wingRightPosition
        
        birdBody.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        beakBottom.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
        
        if (tintColor == SKColor.clearColor()) {
            tintEffect = 0
        } else {
            tint(tintColor!)
        }
        
        setZPos(zPos)
        
        self.addChild(wingLeft)
        self.addChild(wingRight)
        
        self.addChild(birdBody)
        
        self.addChild(eyeLeft)
        self.addChild(eyeRight)
        self.addChild(pupilLeft)
        self.addChild(pupilRight)
        self.addChild(beakTop)
        self.addChild(beakBottom)
        self.addChild(footLeft)
        self.addChild(footRight)
    }

    func tint(color: SKColor){
        birdBody.color = color
        birdBody.colorBlendFactor = tintEffect
        eyeLeft.color = color
        eyeLeft.colorBlendFactor = tintEffect
        eyeRight.color = color
        eyeRight.colorBlendFactor = tintEffect
        pupilLeft.color = color
        pupilLeft.colorBlendFactor = tintEffect
        pupilRight.color = color
        pupilRight.colorBlendFactor = tintEffect
        beakTop.color = color
        beakTop.colorBlendFactor = tintEffect
        beakBottom.color = color
        beakBottom.colorBlendFactor = tintEffect
        footLeft.color = color
        footLeft.colorBlendFactor = tintEffect
        footRight.color = color
        footRight.colorBlendFactor = tintEffect
        wingLeft.color = color
        wingLeft.colorBlendFactor = tintEffect
        wingRight.color = color
        wingRight.colorBlendFactor = tintEffect
    }
    
    func setZPos(zPos: CGFloat) {
        //print("zpos \(zPos)")
        self.zOrigin = zPos
        birdBody.zPosition = zPos + 2
        eyeLeft.zPosition = zPos + 3
        eyeRight.zPosition = zPos + 3
        pupilLeft.zPosition = zPos + 4
        pupilRight.zPosition = zPos + 4
        beakTop.zPosition = zPos + 4
        beakBottom.zPosition = zPos + 3
        footLeft.zPosition = zPos + 3
        footRight.zPosition = zPos + 3
        wingLeft.zPosition = zPos + 1
        wingRight.zPosition = zPos + 1
    }
    
    func actionSing(time: NSTimeInterval){
        let beakOpen = SKAction.scaleXBy(1.00, y: 1.8, duration: 0.2)
        let beakClose = beakOpen.reversedAction()
        beakBottom.runAction(SKAction.sequence([beakOpen, SKAction.waitForDuration(time), beakClose]))
    }
    
    func actionRun(count: Int){
        actionRunStop()
        
        let footUp = SKAction.moveByX(0, y: -10, duration: 0.2)
        let footDown = footUp.reversedAction()
        footLeft.runAction(SKAction.repeatAction(SKAction.sequence([footUp, footDown]), count: count))
        footRight.runAction(SKAction.sequence([SKAction.waitForDuration(0.1), SKAction.repeatAction(SKAction.sequence([footUp, footDown]), count: count)]))
    }
    
    func actionRunFor(time: Double){
        actionRunStop()
        
        let count = 20
        let duration = time/(Double(count*2))
        
        let footUp = SKAction.moveByX(0, y: -10, duration: duration)
        let footDown = footUp.reversedAction()
        footLeft.runAction(SKAction.repeatAction(SKAction.sequence([footUp, footDown]), count: count))
        footRight.runAction(SKAction.sequence([SKAction.waitForDuration(0.1), SKAction.repeatAction(SKAction.sequence([footUp, footDown]), count: count)]))
    }
    
    func actionRunStop() {
        footLeft.removeAllActions()
        footRight.removeAllActions()
        footLeft.position = footLeftPosition
        footRight.position = footRightPosition
    }
    
    
    func actionLookAt(from: CGPoint, to: CGPoint) {
        
        let xd = to.x-from.x
        let yd = to.y-from.y
        var xdn = CGFloat(0)
        var ydn = CGFloat(0)
        let normal = CGFloat(3)
        let magnitude = sqrt(xd*xd + yd*yd)
        if (magnitude != 0) {
            xdn = (xd/magnitude)*normal
            ydn = (yd/magnitude)*normal
        }
        
        pupilLeft.position.x = pupilLeftPosition.x + xdn
        pupilLeft.position.y = pupilLeftPosition.y + ydn
        pupilRight.position.x = pupilRightPosition.x + xdn
        pupilRight.position.y = pupilRightPosition.y + ydn
    }
    
    func actionLookAtStop() {
        pupilLeft.position = pupilLeftPosition
        pupilRight.position = pupilRightPosition
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
