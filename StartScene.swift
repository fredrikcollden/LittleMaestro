//
//  StartScene.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-11-11.
//  Copyright © 2015 Marie. All rights reserved.
//

import SpriteKit


protocol StartSceneDelegate {
    func startSceneActions(action: String)
}

class StartScene: SKScene, SpriteButtonDelegate {
    var startSceneDelegate: StartSceneDelegate?
    
    var label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
    var labelShadow = SKLabelNode(fontNamed: "MarkerFelt-Wide")
    let playBtn = SpriteButton(imageNamed: "playbutton", action: "start")
  
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
       let bgImage = SKSpriteNode(imageNamed: "farmbg")
        bgImage.size = self.size
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        bgImage.zPosition = 1
        self.addChild(bgImage)
        
        label.text = "LITTLE MAESTRO"
        label.fontSize = 100
        label.fontColor = UIColor.whiteColor()
        label.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+70);
        label.zPosition = 3
        
        
        labelShadow.text = "LITTLE MAESTRO"
        labelShadow.fontSize = 100
        labelShadow.fontColor = UIColor.blackColor()
        labelShadow.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+62);
        labelShadow.zPosition = 2
        
        playBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-150);
        playBtn.spriteButtonDelegate = self

        let textureBird = SKTexture(imageNamed: "redbird-body")
        let bird = Bird(texture: textureBird, zPos: 4)
        bird.xScale = 1.0
        bird.yScale = 1.0
        bird.position = CGPoint(x:800, y:532);
        self.addChild(bird)
        bird.actionSing(3)
        bird.actionRun(10)
        bird.actionLookAt(bird.position, to: CGPointZero)
        
        self.addChild(playBtn)
        self.addChild(labelShadow)
        self.addChild(label)
        print("start app")
    }
    
    
    func spriteButtonClick(action: String) {
        self.startSceneDelegate?.startSceneActions("\(action)")
    }
        
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

