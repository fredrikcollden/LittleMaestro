//
//  GameData.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-10-30.
//  Copyright © 2015 Marie. All rights reserved.
//
// Melody
// -1 = sustain
// -2 = pause
// 0 = A
// 22 = G

import UIKit

class GameData {
    
    var categories: [Category] = []
    var levels: [LevelData] = []
    var deviceScale:CGFloat
    var deviceHeight:Int
    var deviceWidth:Int
    var deviceSize: CGSize?
    
    var noteMax:Int = 23
    var noteNumMax:Int = 32
    var noteMaxVis:Int
    var noteHeight:CGFloat
    var gridHeight:CGFloat
    var gridWidth:CGFloat
    let blacks:[Int] = [1,4,6,9,11,13,16,18,21]
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var finishedLevels: [Int] = []
    
    init() {
        deviceScale = 1.0   //Ipad2
        deviceHeight = 768
        deviceWidth = 1024
        
        gridHeight = CGFloat(deviceHeight)*0.8
        gridWidth = CGFloat(deviceWidth)*0.8
        noteMaxVis = noteMax-blacks.count
        noteHeight = gridHeight/CGFloat(noteMaxVis)
        print(noteHeight)
        
        let cat1 = Category()
        let cat2 = Category()
        let cat3 = Category()
        
        categories.append(cat1)
        categories.append(cat2)
        categories.append(cat3)
        
        let lvl1 = LevelData()
        lvl1.levelNo = 1
        
        //lvl1.key = cMaj
        let bar1 = Bar()
        bar1.melody = [3,-1,-1,-1,3,-1,-1,-1,10,-1,-1,-1,10,-1,-1,-1,12,-1,-1,-1,12,-1,-1,-1,10,-1,-1,-1,-1,-1,-1,-1]
        lvl1.bars.append(bar1)
        let bar2 = Bar()
        bar2.melody = [8,-1,-1,-1,8,-1,-1,-1,7,-1,-1,-1,7,-1,-1,-1,5,-1,-1,-1,5,-1,-1,-1,3,-1,-1,-1,-1,-1,-1,-1]
        lvl1.bars.append(bar2)

        
        let lvl2 = LevelData()
        lvl2.levelNo = 2
        //lvl2.key = cMaj
        let lvl2bar1 = Bar()
        lvl2bar1.melody = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,-1,-1,-1,-1,-1,21,-1,-1,0]
        lvl2.bars.append(lvl2bar1)
        let lvl2bar2 = Bar()
        lvl2bar2.melody = [4,-1,-1,-1,4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl2.bars.append(lvl2bar2)
        
        
        let lvl3 = LevelData()
        lvl3.levelNo = 3
        let lvl3bar1 = Bar()
        lvl3bar1.melody =  [3,-1,-1,-1,3,-1,-1,-1,10,-1,-1,-1,10,-1,-1,-1,12,-1,-1,-1,12,-1,-1,-1,10,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar1.melody2 = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar1.chord =    [3.4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,8.4,-1,-1,-1,-1,-1,-1,-1,3.4,-1,-1,-1,-1,-1,-1,-1]
        lvl3.bars.append(lvl3bar1)
        let lvl3bar2 = Bar()
        lvl3bar2.melody = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar2.melody2 = [8,-1,-1,-1,8,-1,-1,-1,7,-1,-1,-1,7,-1,-1,-1,5,-1,-1,-1,5,-1,-1,-1,3,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar2.chord =    [8.4,-1,-1,-1,-1,-1,-1,-1,3.4,-1,-1,-1,-1,-1,-1,-1,10.4,-1,-1,-1,-1,-1,-1,-1,3.4,-1,-1,-1,-1,-1,-1,-1]
        lvl3.bars.append(lvl3bar2)
        let lvl3bar3 = Bar()
        lvl3bar3.melody = [10,-1,-1,-1,10,-1,-1,-1,8,-1,-1,-1,8,-1,-1,-1,7,-1,-1,-1,7,-1,-1,-1,5,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar3.melody2 = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar3.chord =    [3.4,-1,-1,-1,-1,-1,-1,-1,8.4,-1,-1,-1,-1,-1,-1,-1,3.4,-1,-1,-1,-1,-1,-1,-1,10.4,-1,-1,-1,-1,-1,-1,-1]
        lvl3.bars.append(lvl3bar3)
        let lvl3bar4 = Bar()
        lvl3bar4.melody =  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar4.melody2 = [10,-1,-1,-1,10,-1,-1,-1,8,-1,-1,-1,8,-1,-1,-1,7,-1,-1,-1,7,-1,-1,-1,5,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar4.chord =   [3.4,-1,-1,-1,-1,-1,-1,-1,8.4,-1,-1,-1,-1,-1,-1,-1,3.4,-1,-1,-1,-1,-1,-1,-1,10.4,-1,-1,-1,-1,-1,-1,-1]
        lvl3.bars.append(lvl3bar4)
        let lvl3bar5 = Bar()
        lvl3bar5.melody2 =  [3,-1,-1,-1,3,-1,-1,-1,10,-1,-1,-1,10,-1,-1,-1,12,-1,-1,-1,12,-1,-1,-1,10,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar5.melody = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar5.chord =    [3.4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,8.4,-1,-1,-1,-1,-1,-1,-1,3.4,-1,-1,-1,-1,-1,-1,-1]
        lvl3.bars.append(lvl3bar5)
        let lvl3bar6 = Bar()
        lvl3bar6.melody2 = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar6.melody = [8,-1,-1,-1,8,-1,-1,-1,7,-1,-1,-1,7,-1,-1,-1,5,-1,-1,-1,5,-1,-1,-1,3,-1,-1,-1,-1,-1,-1,-1]
        lvl3bar6.chord =    [8.4,-1,-1,-1,-1,-1,-1,-1,3.4,-1,-1,-1,-1,-1,-1,-1,10.4,-1,-1,-1,-1,-1,-1,-1,3.4,-1,-1,-1,-1,-1,-1,-1]
        lvl3.bars.append(lvl3bar6)
        
        
        let lvl4 = LevelData()
        lvl4.levelNo = 4
        let lvl4bar1 = Bar()
        lvl4bar1.melody2 =  [10,-1,-1,-1,-1,-1,12,-1,10,-1,-1,-1,8,-1,-1,-1,7,-1,-1,-1,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl4bar1.melody = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,10,-1,-1,-1,-1,-1,-1,-1]
        lvl4bar1.chord =    [3.4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl4.bars.append(lvl4bar1)
        let lvl4bar2 = Bar()
        lvl4bar2.melody = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,10,-1,-1,-1,-1,-1,-1,-1]
        lvl4bar2.melody2 = [5,-1,-1,-1,7,-1,-1,-1,8,-1,-1,-1,-1,-1,-1,-1,7,-1,-1,-1,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl4bar2.chord =    [10.4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,3.4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl4.bars.append(lvl4bar2)
        let lvl4bar3 = Bar()
        lvl4bar3.melody = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,10,-1,-1,-1,-1,-1,-1,-1]
        lvl4bar3.melody2 = [10,-1,-1,-1,-1,-1,12,-1,10,-1,-1,-1,8,-1,-1,-1,7,-1,-1,-1,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl4bar3.chord =    [3.4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl4.bars.append(lvl4bar3)
        let lvl4bar4 = Bar()
        lvl4bar4.melody =  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl4bar4.melody2 = [5,-1,-1,-1,-1,-1,-1,-1,10,-1,-1,-1,-1,-1,-1,-1,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl4bar4.chord =   [10.4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,3.4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        lvl4.bars.append(lvl4bar4)
        

        let lvl5 = LevelData()
        lvl5.levelNo = 5
        let lvl6 = LevelData()
        lvl6.levelNo = 6
        
        
        cat1.levels.append(lvl1)
        cat1.levels.append(lvl2)
        cat1.levels.append(lvl3)
        cat1.levels.append(lvl4)
        cat2.levels.append(lvl5)
        cat2.levels.append(lvl6)
        
        self.levels.append(lvl1)
        self.levels.append(lvl2)
        self.levels.append(lvl3)
        self.levels.append(lvl4)
        self.levels.append(lvl5)
        self.levels.append(lvl6)
        
    }
    
    func saveData(){
        defaults.setObject(finishedLevels, forKey: "finishedLevels")
    }
    
    func levelCompleted(levelNo: Int){
        finishedLevels.append(levelNo)
        saveData()
    }
    
    func loadData(){
        let finLev = defaults.arrayForKey("finishedLevels")
        if finLev != nil && finLev is [Int]{
            finishedLevels = finLev as! [Int]
        }
    }
    
    func resetData() {
        defaults.removeObjectForKey("finishedLevels")
    }
    
    class var sharedInstance :GameData {
        struct Singleton {
            static let instance = GameData()
        }
        return Singleton.instance
    }
}
