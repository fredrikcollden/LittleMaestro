//
//  Chord
//  MaestroLevel
//
//  Created by Fredrik Colldén on 2015-10-29.
//  Copyright © 2015 Marie. All rights reserved.
//

import Foundation
import SpriteKit


class Chord: SKNode{

    let note: CGFloat
    let baseNote: Int
    let middleNote: Int
    let topNote: Int
    var sevenNote: Int = -1
    var noteLength:CGFloat = 10
    let instrument: String = "piano"
    
    
    init(note: CGFloat){
        self.note = note
        baseNote = Int(note)
        print("chord val: \(note) : basenote: \(baseNote)")
        let typeFloat:CGFloat = note - CGFloat(baseNote)
        let type = Int((typeFloat+0.001)*10)
        print("type \(type)")
        if(type == 4) {
            //print("maj-chord")
            middleNote = baseNote + 4
            topNote = baseNote + 7
        } else if(type == 3) {
            //print("min-chord")
            middleNote = baseNote + 3
            topNote = baseNote + 7
        } else if(type==7){
            //print("seventh chord")
            middleNote = baseNote + 4
            topNote = baseNote + 7
            sevenNote = baseNote+10
        } else {
            //print("base")
            middleNote = -1
            topNote = -1
        }
        
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func playNote(){
        if (baseNote != -1) {
            runAction(SKAction.playSoundFileNamed("\(self.instrument)-\(self.baseNote).caf", waitForCompletion: false))
        }
        if (middleNote != -1) {
            runAction(SKAction.playSoundFileNamed("\(self.instrument)-\(self.middleNote).caf", waitForCompletion: false))
        }
        if (topNote != -1) {
            runAction(SKAction.playSoundFileNamed("\(self.instrument)-\(self.topNote).caf", waitForCompletion: false))
        }
        if (sevenNote != -1) {
            runAction(SKAction.playSoundFileNamed("\(self.instrument)-\(self.sevenNote).caf", waitForCompletion: false))
        }
        
    }
}
