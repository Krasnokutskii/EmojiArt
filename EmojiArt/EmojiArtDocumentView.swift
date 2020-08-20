//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Ярослав on 8/20/20.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    
    @ObservedObject var document: EmojiArtDocument
    
    var body: some View {
        VStack{
            ScrollView(.horizontal){
                HStack{
                    ForEach(EmojiArtDocument.pallet.map{String($0)}, id: \.self){emoji in
                        Text(emoji)
                            .font(Font.system(size: defaultEmojiSize)) //find the way to present as few symbols
                    }
                }
            }.padding(.horizontal)
            
            Color.yellow.overlay(Image(document.background))
                .edgesIgnoringSafeArea([.bottom,.horizontal])
                .onDrop(of: ["pablic.image"], isTargeted: nil) { providers, location in
                    return drop(providers: providers)
                }
        }
    }
    
    private func drop(providers: [NSItemProvider])->Bool{//careful
        let found = providers.loadFirstObject(ofType: URL.self) { url in//figure out extension
            print("dropped url\(url)")
            document.setBackground(url)
        }
        return found
    }
    
    private let defaultEmojiSize: CGFloat = 50
}



