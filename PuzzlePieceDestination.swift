//
//  PuzzlePieceDestination.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-10-29.
//  Copyright © 2015 Marie. All rights reserved.
//

import Foundation
import SpriteKit

class PuzzlePieceDestination: SKNode{
    var depth: Int
    let note: Int
    var isActive = true
    var connectedPuzzlePiece: PuzzlePiece?
    let size: CGSize
    let bird: SKSpriteNode
    
    init(depth: Int, note: Int, textureName: String){
        self.note = note
        self.depth = depth
        let texture = SKTexture(imageNamed: textureName)
        self.size = texture.size()
        self.bird = SKSpriteNode(texture: texture)
        self.bird.anchorPoint = CGPoint(x: 0.5, y: 0)
        super.init()
        self.addChild(bird)
        self.userInteractionEnabled = true

        self.bird.color = SKColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.bird.colorBlendFactor = 1
        self.zPosition = 50
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.PieceDestination
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PuzzlePiece
        self.physicsBody?.collisionBitMask = PhysicsCategory.None

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
