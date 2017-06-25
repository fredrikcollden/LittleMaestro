//
//  LevelButton.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-11-21.
//  Copyright © 2015 Marie. All rights reserved.
//

import SpriteKit
protocol LevelButtonDelegate {
    func levelButtonClick(levelNo: Int)
}

class LevelButton: SKNode, GuiButtonDelegate{
    var levelButtonDelegate: LevelButtonDelegate?
    var levelNo: Int
    var levelFinished: Bool
    var levelLocked: Bool
    
    init(levelNo: Int, levelFinished: Bool, levelLocked: Bool){
        let button = GuiButton(xScale: 4, yScale: 3.5, action: "", labelText: "Lvl \(levelNo)")
        self.levelNo = levelNo
        self.levelFinished = levelFinished
        self.levelLocked = levelLocked
        
        super.init()
        
        if levelFinished {
            let tick = SKSpriteNode(imageNamed: "greentick")
            tick.position = CGPoint(x: 80, y:70)
            tick.zPosition = 300
            tick.size = CGSize(width: 100, height: 100)
            button.addChild(tick)
        }
        
        if levelLocked {
            button.userInteractionEnabled = false
            button.color = SKColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        button.guiButtonDelegate = self
        self.addChild(button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func guiButtonClick(action: String) {
        self.levelButtonDelegate?.levelButtonClick(self.levelNo)
    }

}
