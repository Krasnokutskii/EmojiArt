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
            }
            .padding(.horizontal)
            
            Color.white.overlay(
                Group{
                    if document.background != nil {
                        Image(uiImage: document.background!)
                    }
                }
            )
                .edgesIgnoringSafeArea([.bottom,.horizontal])
                .onDrop(of: ["public.image"], isTargeted: nil) { providers, location in
                    return drop(providers: providers, at: location) //what for return bool?
                }
        }
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint) ->Bool {//careful
        let isFounded = providers.loadFirstObject(ofType: URL.self){ url in
            print(url)
            document.setBackground(url)
        }
        return isFounded
    }
    
    private let defaultEmojiSize: CGFloat = 50
}



