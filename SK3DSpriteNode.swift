//
//  SK3DSpriteNode.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-11-18.
//  Copyright © 2015 Marie. All rights reserved.
//

import SpriteKit

class SK3DSpriteNode: SKSpriteNode {
    var depth: Int
    
    init(depth: Int, textureName: String) {
        let texture = SKTexture(imageNamed: textureName)
        self.depth = depth
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
