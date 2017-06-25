//
//  CategoriesScene.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-11-13.
//  Copyright © 2015 Marie. All rights reserved.
//

import SpriteKit

protocol CategoriesSceneDelegate {
    func loadLevel(levelNo: Int)
}

class CategoriesScene: SKScene, LevelButtonDelegate, CategoryButtonDelegate, SpriteButtonDelegate{
    
    var categoriesSceneDelegate: CategoriesSceneDelegate?
    let categoryButton = CategoryButton(imageNamed: "modal-bg2", action: 1)
    let category2Button = CategoryButton(imageNamed: "modal-bg2", action: 2)
    let category3Button = CategoryButton(imageNamed: "modal-bg2", action: 3)
    let musicBoxButton = SpriteButton(imageNamed: "modal-bg2", action: "openMusicBox")
    var thisView: SKView?
    
    override func didMoveToView(view: SKView) {
        let bgImage = SKSpriteNode(imageNamed: "landscape")
        
        bgImage.size = self.size
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        bgImage.zPosition = 1
        self.addChild(bgImage)
        
        categoryButton.position = CGPoint(x:CGRectGetMidX(self.frame)/2, y:CGRectGetMidY(self.frame)*1.5);
        categoryButton.categoryButtonDelegate = self
       
        category2Button.position = CGPoint(x:CGRectGetMidX(self.frame)*1.5, y:CGRectGetMidY(self.frame)*1.5);
        category2Button.categoryButtonDelegate = self

        category3Button.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)/2);
        category3Button.categoryButtonDelegate = self
        
        musicBoxButton.position = CGPoint(x: CGRectGetWidth(self.frame), y: CGRectGetHeight(self.frame))
        musicBoxButton.spriteButtonDelegate = self
        
        thisView = view
        
        self.addChild(categoryButton)
        self.addChild(category2Button)
    }
    
    func categoryButtonClick(action: Int) {
        let levelPicker = ModalWindow(view: self.thisView!)
        levelPicker.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        levelPicker.zPosition = 200
        let numColumns = 3
        for (index, value) in GameData.sharedInstance.categories[action-1].levels.enumerate(){
            let button: LevelButton
            if GameData.sharedInstance.finishedLevels.contains(value.levelNo){
                print("finished level \(value.levelNo)")
                button = LevelButton(levelNo: value.levelNo, levelFinished: true, levelLocked: false)
            }
            else {
                button = LevelButton(levelNo: value.levelNo, levelFinished: false, levelLocked: false)
            }

            button.levelButtonDelegate = self
            button.position.y = CGFloat(100 - (200 * Int(index/numColumns)))
            button.position.x = CGFloat((((index % numColumns) + 1) * 240) - 480)
            
            levelPicker.window.addChild(button)

        }
        self.addChild(levelPicker)
    }
    
    func levelButtonClick(levelNo: Int){
        self.categoriesSceneDelegate?.loadLevel(levelNo)
    }
    
    func spriteButtonClick(action: String){
        let levelPicker = ModalWindow(view: self.thisView!)
        levelPicker.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        levelPicker.zPosition = 200
        
        let button: LevelButton
        button = LevelButton(levelNo: 1, levelFinished: false, levelLocked: false)
        
        levelPicker.window.addChild(button)
        self.addChild(levelPicker)
    }
}
