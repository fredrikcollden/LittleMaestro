//
//  GameViewController.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-10-29.
//  Copyright (c) 2015 Marie. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameSceneDelegate, StartSceneDelegate, CategoriesSceneDelegate {
    var whiteTransition = SKTransition.fadeWithColor(UIColor(red: CGFloat(1.0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(1.0)), duration: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GameData.sharedInstance.resetData()
        GameData.sharedInstance.loadData()
        
        let skView = self.view as! SKView
        let scene = StartScene(size: skView.bounds.size)
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        scene.startSceneDelegate = self
        skView.presentScene(scene)
    }
    
    func startSceneActions(action: String) {
        let skView = view as! SKView
        let categoriesScene = CategoriesScene(size: skView.bounds.size)
        categoriesScene.categoriesSceneDelegate = self
        skView.presentScene(categoriesScene, transition: whiteTransition)
    }
    
    func loadLevel (levelNo: Int) {
        let skView = view as! SKView
        let gameScene = GameScene(levelNo: levelNo, size: skView.bounds.size)
        gameScene.gameSceneDelegate = self
        skView.presentScene(gameScene, transition: whiteTransition)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
