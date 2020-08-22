//
//  ContentView.swift
//  Say It Out Loud
//
//  Created by Ryan Morrison on 27/03/2020.
//  Copyright © 2020 Ryan Morrison. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
   let speaker = AVSpeechSynthesizer()
    @State var wordsToSay: String
    @State var newPhrase: String
    var utterance: AVSpeechUtterance {
     AVSpeechUtterance(string: wordsToSay)
   }
    var utterance2: AVSpeechUtterance {
      AVSpeechUtterance(string: newPhrase)
    }
    
var body: some View {
    VStack(alignment: HorizontalAlignment.center) {
        Image("speech")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200.0, height: 200.0)
            .padding(30)
        VStack {
            Text("WHAT DO YOU WANT TO SAY?")
                .font(.caption)
                .bold()
            HStack {
                TextField("Say what?", text: $wordsToSay)
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
        }.padding(20)
         HStack {
            Button(action: {
                self.playSpeech()
            }) {
                Image(systemName: "play.circle")
                    .resizable()
                    .frame(width: 52.0, height: 52.0)
                    .aspectRatio(contentMode: .fit)
                    .accentColor(.green)
            }
            .padding(10)
            Button(action: {
                    if self.speaker.isSpeaking {
                      self.speaker.pauseSpeaking(at: .word)
                    }
            }) {
                Image(systemName: "pause.circle")
                    .resizable()
                    .frame(width: 52.0, height: 52.0)
                    .aspectRatio(contentMode: .fit)
                    .accentColor(.orange)
                
            }.padding(10)
            Button(action: {
                    self.speaker.stopSpeaking(at: .word)
                  }) {
                      Image(systemName: "stop.circle")
                        .resizable()
                        .frame(width: 52.0, height: 52.0)
                        .aspectRatio(contentMode: .fit)
                        .accentColor(.red)
                  }.padding(10)
         }
        
        VStack {
            NavigationView {
                List {
                    ForEach(phraseArray, id: \.self) { phrase in
                        HStack {
                            Image(systemName: "play")
                            Button(phrase) {
                                self.wordsToSay = phrase
                                self.playSpeech()
                            }
                        }
                        
                        
                    }
                }.navigationBarTitle("Key Phrases")
            }
            
            
            
            
           }
        
        
     /*
        HStack {
            TextField("Add a phrase", text: $newPhrase)
            .multilineTextAlignment(.center)
            .font(.subheadline)
            .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
            Button(action: {
                self.addPhrase()
            }) {
                Image(systemName: "plus")
                    .accentColor(.black)
                    .padding(20)
            }
        }.background(Color.secondary)
   */
        
      }
    
    }
    
    func addPhrase(){
        phraseArray.append(newPhrase)
        UIApplication.shared.endEditing()
        if self.speaker.isPaused {
        self.speaker.continueSpeaking()
        } else {
         self.speaker.speak(self.utterance2)
        }
    }
    
    func playSpeech() {
        if self.speaker.isPaused {
            self.speaker.continueSpeaking()
            } else {
             self.speaker.speak(self.utterance)
            }
        UIApplication.shared.endEditing()
    }
   
    
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(wordsToSay: "Say something...", newPhrase: "Hi")
    }
}
