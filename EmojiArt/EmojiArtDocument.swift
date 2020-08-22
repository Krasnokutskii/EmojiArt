//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Ярослав on 8/20/20.
//

import SwiftUI

class EmojiArtDocument: ObservableObject{
   static let pallet = "🐋🦑🦧🐏🦍🐡🐜"
    
    @Published var emojiArt = EmojiArt()
    
    @Published private(set) var background: UIImage?
    
    // MARK: - Intent
    func addEmoji(_ emoji: String, size: CGFloat, at location: CGPoint){
        emojiArt.addEmoji(emoji, size: Int(size), x: Int(location.x), y: Int(location.y))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, at location: CGPoint){
        if let index = emojiArt.emojis.firstIndex(where: {emoji.id == $0.id}){
            emojiArt.emojis[index].x += Int(location.x)
            emojiArt.emojis[index].y += Int(location.y)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, size: CGFloat){
        if let index = emojiArt.emojis.firstIndex(where: {emoji.id == $0.id }){
            emojiArt.emojis[index].size += Int(size)
        }
    }
    
    func setBackground(_ url: URL?){  //url can be different, we are handle with them in extension
        emojiArt.backgroundURL = url?.imageURL
        fetchBackgroundImageData()
    }
    
    private func fetchBackgroundImageData(){                        //fetch image with Dispatch
        self.background = nil
        if let url = emojiArt.backgroundURL {                       // background url = nil?
            DispatchQueue.global(qos: .userInitiated).async{        // global queue
                if let imageData = try? Data(contentsOf: url){       // try download data of url
                    DispatchQueue.main.async {                      // main for show image in View
                        if url == self.emojiArt.backgroundURL{
                            self.background = UIImage(data: imageData)  // put image data to UIimage
                        }
                    }
                }
            }
        }
    }
}
