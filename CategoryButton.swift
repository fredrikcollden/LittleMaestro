//
//  CategoryButton.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-11-26.
//  Copyright © 2015 Marie. All rights reserved.
//

import SpriteKit

protocol CategoryButtonDelegate {
    func categoryButtonClick(action: Int)
}


class CategoryButton: SKSpriteNode{
    var categoryButtonDelegate: CategoryButtonDelegate?
    var action: Int
    
    init(imageNamed: String, action: Int){
        let texture = SKTexture(imageNamed: imageNamed)
        self.action = action
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    
        self.texture = texture
        self.userInteractionEnabled = true
        self.zPosition = 2
        
        let animIn = SKAction.scaleXBy(1.04, y: 0.95, duration: 1.0)
        animIn.timingMode = SKActionTimingMode.EaseInEaseOut
        let animOut = animIn.reversedAction()
        let actionAnim = SKAction.repeatActionForever(SKAction.sequence([animIn, animOut]))
        self.runAction(actionAnim)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            self.categoryButtonDelegate?.categoryButtonClick(self.action)
        }
        
    }

}
