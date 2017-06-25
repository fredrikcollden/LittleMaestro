//
//  NightLevel.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-11-17.
//  Copyright © 2015 Marie. All rights reserved.
//

import SpriteKit

protocol LevelDelegate {
    func playAll()
}

class NightLevel: SKNode {
    var movables: [SK3DNode] = []
    let zFactor = 2
    var mainLayer = SKSpriteNode()
    var backLayer1 = SKSpriteNode()
    var backLayer2 = SKSpriteNode() //stand still
    var frontLayer1 = SKSpriteNode()
    

    var fl1z = CGFloat(2)
    var mz = CGFloat(1)
    var bl1z = CGFloat(0.1)
    var bl2z = CGFloat(0)
    
    var levelDelegate: LevelDelegate?
    var numberOfBars: Int
    var sceneSize: CGSize
    
    init (numberOfBars:Int, sceneSize:CGSize) {
        self.sceneSize = sceneSize
        self.numberOfBars = numberOfBars
        let skyTexture = SKTexture(imageNamed: "nightsky")
        let moonTexture = SKTexture(imageNamed: "moon")
        let pole = SKTexture(imageNamed: "pole")
        let wire = SKTexture(imageNamed: "wire")
        let fence = SKTexture(imageNamed: "fence")
        let cloud1 = SKTexture(imageNamed: "cloud1")
        print("scenesize: \(sceneSize)")
        
        let wireOffset = GameData.sharedInstance.noteHeight*1
        let wireSpacing = GameData.sharedInstance.noteHeight*2
        for i in 0 ... 4{
            let wire = SKSpriteNode(texture: wire)
            wire.size.width = sceneSize.width * CGFloat(numberOfBars)
            print("wiresize \(wire.size.width)")
            wire.anchorPoint.x = 0
            wire.position.y = sceneSize.height - (wireSpacing*CGFloat(i) + wireOffset)
            wire.position.x = 0
            wire.zPosition = 10
            self.mainLayer.addChild(wire)
        }
        
        for i in 0 ... numberOfBars{
            let poleLeft = SKSpriteNode(texture: pole)
            
            poleLeft.zPosition = 11
            poleLeft.anchorPoint = CGPoint(x: 1, y: 1)
            poleLeft.position = CGPoint(x: (sceneSize.width * CGFloat(i))-20, y: (sceneSize.height*0.96))

            self.mainLayer.addChild(poleLeft)
            
        }
        
        for _ in 0 ... 2{
            let cloud1 = SKSpriteNode(texture: cloud1)
            cloud1.size.height *= GameData.sharedInstance.deviceScale
            cloud1.size.width *= GameData.sharedInstance.deviceScale
            cloud1.anchorPoint = CGPoint(x: 0, y: 1)
            let cloudX = (CGFloat(arc4random_uniform(UInt32(sceneSize.width))))/(1-bl1z)
            let cloudY = sceneSize.height - (CGFloat(arc4random_uniform(UInt32(sceneSize.height*0.3))))
            cloud1.zPosition = 5
            cloud1.position = CGPoint(x: cloudX, y: cloudY)
            
            let randomMovement = CGFloat(arc4random_uniform(UInt32(200))+400)
            let randomTime = Double(arc4random_uniform(UInt32(10))+60)
            let animIn = SKAction.moveByX(-randomMovement, y: 0, duration: randomTime)
            let animOut = animIn.reversedAction()
            let actionAnim = SKAction.repeatActionForever(SKAction.sequence([animIn, animOut]))
            cloud1.runAction(actionAnim)
            
            self.backLayer1.addChild(cloud1)
        }
        
        self.mainLayer.size.width = sceneSize.width * CGFloat(numberOfBars)
        self.mainLayer.size.height = sceneSize.height
        
        
        let sky = SKSpriteNode(texture: skyTexture)
        sky.zPosition = 1
        sky.anchorPoint = CGPointZero
        sky.size = sceneSize
        sky.position = CGPoint(x: (0), y: 0)
        self.backLayer2.addChild(sky)
        
        let moon = SKSpriteNode(texture: moonTexture)
        moon.zPosition = 2
        moon.anchorPoint = CGPoint(x: 0, y: 0.5)
        moon.size.height *= GameData.sharedInstance.deviceScale
        moon.size.width *= GameData.sharedInstance.deviceScale
        moon.position = CGPoint(x: (0), y: sceneSize.height*0.9)
        self.backLayer2.addChild(moon)
        print("\(numberOfBars) --- \(numberOfBars*Int(fl1z))")
        for i in 0 ... (numberOfBars*Int(fl1z)-2){
            let fence = SKSpriteNode(texture: fence)
            fence.size.width = sceneSize.width
            fence.zPosition = 21
            fence.anchorPoint = CGPoint(x: 0, y: 1)
            fence.position = CGPoint(x: (sceneSize.width * CGFloat(i)), y: 100*GameData.sharedInstance.deviceScale)
            self.frontLayer1.addChild(fence)
            print("add fence \(fence.position)")
        }
        
        super.init()
        
        self.zPosition = 0
        mainLayer.zPosition = 10
        backLayer2.zPosition = 1
        backLayer1.zPosition = 5
        frontLayer1.zPosition = 20
        self.addChild(self.mainLayer)
        self.addChild(self.backLayer2)
        self.addChild(self.backLayer1)
        self.addChild(self.frontLayer1)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveTo(barNum: Int, playWholeSong: Bool){
        let myDuration = Double(4)
        
        
        let moveLeft = SKAction.moveToX(-(self.sceneSize.width * CGFloat(barNum)), duration: myDuration)
        let moveLeftReverse = SKAction.moveToX((self.sceneSize.width * CGFloat(barNum)), duration: myDuration)
        let moveLeftFront1 = SKAction.moveToX((1-fl1z)*(self.sceneSize.width * CGFloat(barNum)), duration: myDuration)
        let moveLeftBack1 = SKAction.moveToX((1-bl1z)*(self.sceneSize.width * CGFloat(barNum)), duration: myDuration)
        
        moveLeft.timingMode = SKActionTimingMode.EaseInEaseOut
        moveLeftReverse.timingMode = SKActionTimingMode.EaseInEaseOut
        moveLeftFront1.timingMode = SKActionTimingMode.EaseInEaseOut
        moveLeftBack1.timingMode = SKActionTimingMode.EaseInEaseOut

        
        if playWholeSong {
            self.runAction(moveLeft, completion: playAll)
            self.backLayer2.runAction(moveLeftReverse)
            self.frontLayer1.runAction(moveLeftFront1)
            self.backLayer1.runAction(moveLeftBack1)
        } else {
            self.runAction(moveLeft)
            self.backLayer2.runAction(moveLeftReverse)
            self.frontLayer1.runAction(moveLeftFront1)
            self.backLayer1.runAction(moveLeftBack1)
        }
    }
    
    func moveWhole(tempo:CGFloat) {
        let moveAll = SKAction.moveToX(-(sceneSize.width * CGFloat(self.numberOfBars-1)), duration:
            Double(tempo/1200*CGFloat(self.numberOfBars*32)))
        let moveAllReverse = SKAction.moveToX((sceneSize.width * CGFloat(self.numberOfBars-1)), duration:
            Double(tempo/1200*CGFloat(self.numberOfBars*32)))
        let moveAllFront1 = SKAction.moveToX((1-fl1z)*(sceneSize.width * CGFloat(self.numberOfBars-1)), duration:
            Double(tempo/1200*CGFloat(self.numberOfBars*32)))
        let moveAllBack1 = SKAction.moveToX((1-bl1z)*(sceneSize.width * CGFloat(self.numberOfBars-1)), duration:
            Double(tempo/1200*CGFloat(self.numberOfBars*32)))
        
        moveAll.timingMode = SKActionTimingMode.EaseInEaseOut
        moveAllReverse.timingMode = SKActionTimingMode.EaseInEaseOut
        moveAllFront1.timingMode = SKActionTimingMode.EaseInEaseOut
        moveAllBack1.timingMode = SKActionTimingMode.EaseInEaseOut
        
        self.backLayer2.runAction(moveAllReverse)
        self.backLayer1.runAction(moveAllBack1)
        self.frontLayer1.runAction(moveAllFront1)
        self.runAction(moveAll)
    }
    
    func playAll(){
        levelDelegate?.playAll()
    }
    
}
