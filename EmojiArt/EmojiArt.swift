//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Ярослав on 8/20/20.
//

import Foundation

struct EmojiArt{
    var backgroundURL: URL?
    
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable {
        let text: String
        var size: Int
        var x: Int
        var y: Int
        let id: Int
        
        fileprivate init(text: String, size: Int, x: Int, y: Int, id: Int) {
            self.text = text
            self.size = size
            self.x = x
            self.y = y
            self.id = id
        }
    }
    
    var uniqueEmojiId = 0
    
    mutating func addEmoji(_ emoji: String, size: Int, x: Int, y: Int){
        uniqueEmojiId += 1
        emojis.append(Emoji(text: emoji, size: size, x: x, y: y, id: uniqueEmojiId))
    }
}
