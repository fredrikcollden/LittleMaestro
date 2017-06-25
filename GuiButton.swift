//
//  GuiButton.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-11-11.
//  Copyright © 2015 Marie. All rights reserved.
//

import UIKit
import SpriteKit

protocol GuiButtonDelegate {
    func guiButtonClick(action: String)
}

class GuiButton: SKSpriteNode {
    var guiButtonDelegate: GuiButtonDelegate?
    var label = SKLabelNode(fontNamed: "Chalkduster")
    var action: String
    
    init(xScale: CGFloat, yScale: CGFloat, action: String, labelText: String) {
        
        let texture = SKTexture(imageNamed: "GuiButton")
        let cS: CGFloat = 1.0
        let oH = texture.size().height
        let oW = texture.size().width
        let h = texture.size().height*yScale
        let w = texture.size().width*xScale
        let size = CGSize(width: w,height: h)
        let centerRect = CGRectMake(((oW-cS)/2.0)/oW, ((oH-cS)/2.0)/oH, cS/oW, cS/oH)
        self.action = action;
        super.init(texture: texture, color: SKColor.clearColor(), size: size)
        self.zPosition = 100
        self.centerRect = centerRect;
        self.userInteractionEnabled = true
        
        let animIn = SKAction.scaleXBy(1.04, y: 0.95, duration: 1.0)
        animIn.timingMode = SKActionTimingMode.EaseInEaseOut
        let animOut = animIn.reversedAction()
        let actionAnim = SKAction.repeatActionForever(SKAction.sequence([animIn, animOut]))
        self.runAction(actionAnim)
        
        
        label.text = labelText
        label.fontSize = 20*yScale
        label.position = CGPoint(x:0, y:-size.height/8);
        label.zPosition = 110
        self.addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.action = ""
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            self.guiButtonDelegate?.guiButtonClick(self.action)
        }
        
    }
}
