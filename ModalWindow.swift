//
//  ModalWindow.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-11-16.
//  Copyright © 2015 Marie. All rights reserved.
//

import SpriteKit

class ModalWindow: SKNode{
    
    let window: SKSpriteNode
    let dimmer: SKSpriteNode

    
    
    init(view: SKView){
        dimmer = SKSpriteNode(color: SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5), size: view.frame.size)
        window = SKSpriteNode(imageNamed: "modal-bg")
        super.init()
        
        window.size = CGSize(width: 800, height: 500)
        
        self.addChild(dimmer)
        self.addChild(window)
        self.userInteractionEnabled = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.removeFromParent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
