//
//  PuzzlePiece.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-10-29.
//  Copyright © 2015 Marie. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

protocol PuzzlePieceDelegate {
    func addInPlace()
    func birdsFollow(to: CGPoint)
    func birdsFollowStop()
    func birdsExcited()
    func birdsExcitedStop()
}

class PuzzlePiece: SKNode{
    var puzzlePieceDelegate: PuzzlePieceDelegate?
    var isActive = true
    var startPosition: CGPoint
    var snapDestination: PuzzlePieceDestination?
    let note: Int
    var noteLength:CGFloat = 10
    let instrument: String = "piano"
    var playAnim: SKAction?
    var size: CGSize
    let bird: Bird
    var zPos: CGFloat
    var zPosInterval: CGFloat = 1000

    
   
    
    init(note: Int, textureName: String, zPos: CGFloat, startPosition: CGPoint, tintColor: SKColor?=SKColor.clearColor()){
        self.note = note
        self.zPos = zPos
        let texture = SKTexture(imageNamed: textureName)
        self.size = texture.size()
        self.startPosition = startPosition
        self.snapDestination = nil
        self.bird = Bird(texture: texture, zPos: zPos, tintColor: tintColor)
        super.init()
        
        self.addChild(bird)
        
        self.userInteractionEnabled = true
        self.position = startPosition
        self.zPosition = zPos
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.PuzzlePiece
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PieceDestination
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        let animIn = SKAction.scaleXBy(1.2, y: 1.1, duration: 0.2)
        animIn.timingMode = SKActionTimingMode.EaseInEaseOut
        let animOut = animIn.reversedAction()//SKAction.scaleXBy(1/2.06,y: 1/0.98, duration: 1.6)
        self.playAnim = SKAction.sequence([
            animIn,
            animOut,
            ])


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        playNote()
        moveZFront()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.isActive) {
            let touch = touches.first
            let positionInScene = touch!.locationInNode(self)
            let previousPosition = touch!.previousLocationInNode(self)
            let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            let position = self.position
            self.position = CGPoint(x: position.x + translation.x*self.xScale, y: position.y + translation.y*self.xScale)
            puzzlePieceDelegate?.birdsFollow(self.position)
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        puzzlePieceDelegate?.birdsFollowStop()
        if self.snapDestination == nil {
            let returnAnim = SKAction.moveTo(self.startPosition, duration: 0.3)
            returnAnim.timingMode = SKActionTimingMode.EaseOut
            self.runAction(returnAnim)
            moveZBack()
        }
        else if self.isActive {
            let snapAnim = SKAction.moveTo(self.snapDestination!.position, duration: 0.2)
            snapAnim.timingMode = SKActionTimingMode.EaseOut
            self.runAction(snapAnim)
            self.snapDestination!.connectedPuzzlePiece = self
            self.snapDestination!.isActive = false
            self.isActive = false
            puzzlePieceDelegate?.addInPlace()
            moveZInactive()
            puzzlePieceDelegate?.birdsExcitedStop()
        }

    }
    
    func actionRunBar(deltaX: CGFloat) {
        self.startPosition.x += deltaX
        let dur = Double((arc4random_uniform(UInt32(200))+300))/100
        print(dur)
        let movement = SKAction.moveByX(deltaX, y: 0, duration: dur)
        movement.timingMode = SKActionTimingMode.EaseInEaseOut
        self.runAction(movement)
        self.bird.actionRunFor(dur)
    }
    
    func moveZFront() {
        self.zPosition = self.zPos + zPosInterval
        self.bird.setZPos(self.zPos + zPosInterval)
    }
    
    func moveZBack() {
        self.zPosition = self.zPos - zPosInterval
        self.bird.setZPos(self.zPos - zPosInterval)
    }
    
    func moveZInactive() {
        self.zPosition = self.zPos - zPosInterval*2
        self.bird.setZPos(self.zPos - zPosInterval*2)
    }
    
    func playNote(){
        self.bird.actionSing(0.5)
        runAction(SKAction.playSoundFileNamed("\(self.instrument)-\(self.note).caf", waitForCompletion: false))
    }
}
