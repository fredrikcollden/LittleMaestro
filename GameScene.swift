//
//  GameScene.swift
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-10-29.
//  Copyright (c) 2015 Marie. All rights reserved.
//

import SpriteKit

protocol GameSceneDelegate {
    func startSceneActions(action: String)
}

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let PieceDestination   : UInt32 = 0b1
    static let PuzzlePiece: UInt32 = 0b10
}


class GameScene: SKScene, SKPhysicsContactDelegate, PuzzlePieceDelegate, GuiButtonDelegate, LevelDelegate {
    let backBtn = GuiButton(xScale: GameData.sharedInstance.deviceScale, yScale: GameData.sharedInstance.deviceScale, action: "goToMenu", labelText: "");
    var gameSceneDelegate: GameSceneDelegate?
    let maxNotes = CGFloat(22.0)
    let maxNumNotes = CGFloat(32.0)
    var gridPosition = CGPoint(x:100, y:700)
    var pianoPosition = CGPoint(x:100, y:100)
    var gridSize = CGPoint(x: 100, y: 100)
    var pianoSize = CGPoint(x: 100, y: 100)
    var deviceScale = GameData.sharedInstance.deviceScale
    var allPieces: [PuzzlePiece] = []
    var numberOfPieces:[Int] = []
    var numberPutInPlace = 0
    var allInPlace = false
    var currentLevel: Int
    var numberOfBars = 0
    var currentBar = 0
    var levelCompleted = false
    var bgContainer: NightLevel?
    var skipBar = false
    
    var bars = [[PuzzlePieceDestination?]?](count: 0, repeatedValue: nil)
    var melody2bars = [[PuzzlePiece?]?](count: 0, repeatedValue: nil)
    var chordbars = [[Chord?]?](count: 0, repeatedValue: nil)
    
    let birds = ["redbird-body"]
    var uniqueNotes: [Int] = []
    var noteBirdMapping: [Int: String] = [Int: String]()
    
    var sceneSize:CGSize = CGSize()
    
    let startZ: CGFloat = 3000
    
    var timer = NSTimer()
    var currentTick = 0
    var playBackMelody: [PuzzlePieceDestination?]?
    var playBackMelody2: [PuzzlePiece?]?
    var playBackChord: [Chord?]?
    var playLastTime = false
    var tempo = CGFloat(120)
    
    

    init(levelNo: Int, size: CGSize){
        self.currentLevel = levelNo - 1
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        sceneSize = view.frame.size
        let gridHeight = GameData.sharedInstance.gridHeight
        let gridWidth = GameData.sharedInstance.gridWidth
        
        self.gridPosition = CGPoint(x:(sceneSize.width - gridWidth)/2, y:sceneSize.height - gridHeight) //ipad position
        self.pianoPosition = CGPoint(x:100*GameData.sharedInstance.deviceScale, y:100*GameData.sharedInstance.deviceScale)//ipad position
        
        self.gridSize = CGPoint(x: gridWidth/CGFloat(GameData.sharedInstance.noteNumMax), y: gridHeight/CGFloat(GameData.sharedInstance.noteMaxVis))
        self.pianoSize = CGPoint(x: (sceneSize.width - 2 * pianoPosition.x)/maxNotes, y: 100)
        self.numberOfBars = GameData.sharedInstance.levels[self.currentLevel].bars.count
        bgContainer = NightLevel(numberOfBars: self.numberOfBars, sceneSize: sceneSize)
        bgContainer!.levelDelegate = self
        self.addChild(bgContainer!)
        initBars()
        
        backBtn.userInteractionEnabled = true
        backBtn.anchorPoint = CGPoint(x: 0, y: 1)
        backBtn.position = CGPoint(x: 5, y: self.frame.size.height - 5);
        backBtn.zPosition = 100
        backBtn.guiButtonDelegate = self
        backBtn.color = SKColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1)
        backBtn.colorBlendFactor = 0.4
        
        self.addChild(backBtn)

        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        
    }
    
    func initBars() {
        let allBars = GameData.sharedInstance.levels[self.currentLevel].bars
        let blacks = GameData.sharedInstance.blacks
        
        //Analyze level a bit
        for (_, bar) in allBars.enumerate() {
            var minNote = 0
            var maxNote = 0
            let melody: [Int] = bar.melody
            for (_, value) in melody.enumerate() {
                if (value >= 0) {
                    if(value < minNote) {
                        minNote = value
                    }
                    if (value > maxNote){
                        maxNote = value
                    }
                    if (!uniqueNotes.contains(value)) {
                        uniqueNotes.append(value)
                    }
                }
            }
        }
        for (value) in uniqueNotes {
            if (noteBirdMapping[value] == nil){
                noteBirdMapping[value] = birds[noteBirdMapping.count % birds.count]
            }
        }
        print(noteBirdMapping)
        
        //Start generating puzzle pieces
        for (barNum, bar) in allBars.enumerate() {
            var numPieces = 0
            let melody: [Int] = bar.melody
            var puzzlePieceDestinations: [PuzzlePieceDestination?] = []
            for (index, value) in melody.enumerate() {
                if (value >= 0) {
                    
                    var skipCount = 0
                    for (val) in blacks {
                        if (val < value) {
                            skipCount += 1
                        }
                    }
                    
                    let birdBody = noteBirdMapping[value]!
                    
                    let piece = PuzzlePiece(note: value, textureName: birdBody, zPos: startZ + (CGFloat(index*10+320*barNum)) , startPosition: CGPoint(x:(CGFloat(value)*pianoSize.x) + pianoPosition.x, y:pianoPosition.y), tintColor: SKColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1))
                    let pieceDest = PuzzlePieceDestination(depth: 10, note: value, textureName: birdBody)
                    pieceDest.position = CGPoint(x:(CGFloat(index)*gridSize.x) + (gridPosition.x + CGFloat(barNum) * frame.size.width), y:gridPosition.y+(CGFloat(value-skipCount)*gridSize.y)+gridSize.y/10)
                
                    let pHeight = 2*GameData.sharedInstance.noteHeight/piece.bird.birdBody.size.height

                    piece.setScale(pHeight)
                    pieceDest.setScale(pHeight)
                
                    piece.puzzlePieceDelegate = self
                    bgContainer?.addChild(piece)
                    allPieces.append(piece)
                    puzzlePieceDestinations.append(pieceDest)
                    bgContainer?.addChild(pieceDest)
                    numPieces += 1
                } else {
                    puzzlePieceDestinations.append(nil)
                }
            }
            
            var puzzlePieces: [PuzzlePiece?] = []
            for (index, value) in bar.melody2.enumerate() {
                if (value >= 0) {
                    var skipCount = 0
                    for (val) in blacks {
                        if (val < value) {
                            skipCount += 1
                        }
                    }
                    let piece = PuzzlePiece(note: value, textureName: "redbird-body", zPos: startZ + (CGFloat(index*10+320*barNum)) , startPosition: CGPoint(x:(CGFloat(index)*gridSize.x) + (gridPosition.x + CGFloat(barNum) * frame.size.width), y:gridPosition.y+(CGFloat(value-skipCount)*gridSize.y)+gridSize.y/10), tintColor: SKColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1))
                    let pHeight = 2*GameData.sharedInstance.noteHeight/piece.bird.birdBody.size.height
                    piece.setScale(pHeight)
                    bgContainer?.addChild(piece)
                    piece.puzzlePieceDelegate = self
                    puzzlePieces.append(piece)
                } else {
                    puzzlePieces.append(nil)
                }
            }
            self.melody2bars.append(puzzlePieces)
            
            var chords: [Chord?] = []
            for (_, value) in bar.chord.enumerate() {
                if (value >= 0) {
                    
                    
                    let chord = Chord(note: CGFloat(value))
                    chord.setScale(0.1)
                    bgContainer?.addChild(chord)
                    chords.append(chord)
                } else {
                    chords.append(nil)
                }
            }
            self.chordbars.append(chords)
            
            
            self.bars.append(puzzlePieceDestinations)
            self.numberOfPieces.append(numPieces)
        }
    }
    
    
    func birdsRunBar(deltaX: CGFloat) {
        for piece in allPieces {
            if (piece.isActive) {
                piece.actionRunBar(deltaX)
            }
        }
    }
    
    func birdsFollow(to: CGPoint) {
        for piece in allPieces {
            piece.bird.actionLookAt(piece.position, to: to)
        }
    }
    func birdsFollowStop() {
        for piece in allPieces {
            piece.bird.actionLookAtStop()
        }
    }
    func birdsExcited() {
        for piece in allPieces {
            piece.bird.actionRun(100)
        }
    }
    func birdsExcitedStop() {
        for piece in allPieces {
            piece.bird.actionRunStop()
        }
    }
   
    func puzzlePiecePutInPlace(puzzlePiece:PuzzlePiece, place:PuzzlePieceDestination) {
        if (puzzlePiece.note == place.note && place.isActive) {
            print("did put in place")
            puzzlePiece.snapDestination = place
            birdsExcited()
        }
    }
    
    func puzzlePiecePutOutPlace(puzzlePiece:PuzzlePiece, place:PuzzlePieceDestination) {
        if (puzzlePiece.note == place.note) {
            print("put out place")
            if (puzzlePiece.snapDestination == place) {
                puzzlePiece.snapDestination = nil
                birdsExcitedStop()
            }
        }
       
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        print("begin contact")
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.PieceDestination != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.PuzzlePiece != 0)) {
                puzzlePiecePutInPlace(secondBody.node as! PuzzlePiece, place: firstBody.node as! PuzzlePieceDestination)
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        print("end contact")
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.PieceDestination != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.PuzzlePiece != 0)) {
                puzzlePiecePutOutPlace(secondBody.node as! PuzzlePiece, place: firstBody.node as! PuzzlePieceDestination)
        }
        
    }
    
    func addInPlace() {
        self.numberPutInPlace += 1
        print(numberOfPieces[self.currentBar])
        if numberPutInPlace == numberOfPieces[self.currentBar] {
            numberPutInPlace = 0
            startPlayBack(self.currentBar)
        }
    }
    
    func playAll(){
        startPlayBack()
    }
    
    func startPlayBack(barNum: Int?=nil){
        if (barNum == nil) {
            print("play whole song")
            self.playBackMelody = []
            self.playBackMelody2 = []
            self.playBackChord = []
            for bar in self.bars {
                self.playBackMelody?.appendContentsOf(bar!)
            }
            for bar in self.melody2bars {
                self.playBackMelody2?.appendContentsOf(bar!)
            }
            for bar in self.chordbars {
                self.playBackChord?.appendContentsOf(bar!)
            }
            
            self.playLastTime = true
            bgContainer?.moveWhole(self.tempo)
            
        } else {
            self.playBackMelody = self.bars[barNum!]
            self.playBackMelody2 = self.melody2bars[barNum!]
            self.playBackChord = self.chordbars[barNum!]
            print("play bar \(barNum)")
        }
        
        self.timer = NSTimer(timeInterval: Double(self.tempo/CGFloat(1200)), target: self, selector: #selector(GameScene.playBackTick), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    func stopPlayBack(){
        self.currentTick = 0;
        timer.invalidate()
        if self.playLastTime {
            print("end level")
            self.gameSceneDelegate?.startSceneActions("goToMenu")
        }else if self.numberOfBars > (self.currentBar + 1) {
            self.currentBar += 1
            var countNext = 0;
            for val in self.bars[self.currentBar]! {
                if(val != nil){
                    countNext += 1;
                }
            }
            if(countNext > 0) {
                birdsRunBar(sceneSize.width)
                bgContainer?.moveTo(self.currentBar, playWholeSong: false)
                
            } else {
                birdsRunBar(sceneSize.width)
                bgContainer?.moveTo(self.currentBar, playWholeSong: false)
                delay(4.0) {
                    self.startPlayBack(self.currentBar)
                }
                print(self.currentBar)
            }
        } else {
            self.levelCompleted = true
            bgContainer?.moveTo(0, playWholeSong: true)
            print("level completed")
            GameData.sharedInstance.levelCompleted(GameData.sharedInstance.levels[self.currentLevel].levelNo)
        }
    }
    
    func playBackTick(){
        
        if self.currentTick < self.playBackMelody2!.count {
            if (self.playBackMelody2![self.currentTick] != nil) {
                self.playBackMelody2![self.currentTick]!.playNote()
            }
        }
        if self.currentTick < self.playBackChord!.count {
            if (self.playBackChord![self.currentTick] != nil) {
                self.playBackChord![self.currentTick]!.playNote()
            }
        }
        
        if self.currentTick < self.playBackMelody!.count {
            if (self.playBackMelody![self.currentTick] != nil) {
                if self.playBackMelody![self.currentTick]!.connectedPuzzlePiece != nil {
                    self.playBackMelody![self.currentTick]!.connectedPuzzlePiece!.playNote()
                }
            }
            self.currentTick += 1
        } else {
            stopPlayBack()
        }
        
        
    }
    
    func guiButtonClick(action: String) {
        self.gameSceneDelegate?.startSceneActions(action)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
    
}
