//
//  UInt8Word.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import Foundation

struct UInt8Word {
    
    var word: String? {
        didSet {
            if Int((self.word?.characters.count)!) >= Int(UInt8.max) {
                self.trim()
            }
        }
    }
    
    var size: UInt8? {
        get {
            return UInt8((word?.characters.count)!)
        }
    }
    
    let defaultTrimSize: Int = 16
    
    init(){
        self.word = self.generate(self.defaultTrimSize)
    }
    
    init(word: String){
        self.word = word
    }
    
    func generate(size: Int) -> String {
        return RandomWord.generate(size)
    }
    
    mutating func trim() {
        if let string = word {
            if Int(string.characters.count) >   defaultTrimSize {
                let excess = Int(string.characters.count) % defaultTrimSize
                self.word = self.word?.trimFromEndBy(excess)
            }
        }
    }
}

struct RandomWord {
    
    static private let max: UInt32 = 62
    static private let upperCharacters = (UnicodeScalar("A").value...UnicodeScalar("Z").value).map {String(UnicodeScalar($0))}
    static private let lowerCharacters = (UnicodeScalar("a").value...UnicodeScalar("z").value).map {String(UnicodeScalar($0))}
    static private let numbers = (0...9 as Range).map {String($0)}
    static private var allCharacters = [String]()
    
    static func generate(size: Int) -> String {
        var string: String = ""
        
        while string.characters.count < size {
            string.append(randomChar())
        }
        
        return string
    }
    
    static private func randomNumber() -> Int {
        return Int(arc4random_uniform(max))
    }
    
    static private func randomChar() -> Character {
        
        if allCharacters.count == 0 {
            for x in upperCharacters {
                allCharacters.append(x)
            }
            
            for x in lowerCharacters {
                allCharacters.append(x)
            }
            
            for x in numbers {
                allCharacters.append(x)
            }
        }
        
        let random = randomNumber()
        let char: Character = Character(allCharacters[random])
        
        return char
    }
}