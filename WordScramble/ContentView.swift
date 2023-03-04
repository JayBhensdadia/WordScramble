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
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
        }
        
    }
    func startGame(){
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            
            // 2. Load start.txt into a string
            
            if let startWords = try? String(contentsOf: startWordsURL){
                
                // 3. Split the string up into an array of strings, splitting on line breaks
                
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // If we are here everything has worked, so we can exit
                return
            }
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
