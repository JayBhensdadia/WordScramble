//
//  ContentView.swift
//  WordScramble
//
//  Created by Jay Bhensdadia on 04/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter your word",text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(usedWords, id: \.self){word in
                        HStack{
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
        }
        
    }
    func addNewWord(){
        let trimmedWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedWord.count <= 1{
            return
        }else{
            withAnimation{
                usedWords.insert(trimmedWord, at: 0)
            }
            newWord = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
