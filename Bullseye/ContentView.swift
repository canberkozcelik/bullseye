//
//  ContentView.swift
//  Bullseye
//
//  Created by Canberk Özçelik on 26.11.2019.
//  Copyright © 2019 Canberk Özçelik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    var body: some View {
        VStack {// Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(target)")
            }.padding(.top, 16)
            
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in:1...100)
                Text("100")
            }.padding(.horizontal, 16)
            
            Spacer()
            
            // Button row
            Button(action: {
                self.alertIsVisible = true
                self.score += self.pointsForCurrentRound()
                self.round += 1
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/)
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text("Hello there!"),
                             message: Text("The slider's value is \(sliderValueRounded()).\n" +
                                "You scored \(self.pointsForCurrentRound()) points this round."),
                             dismissButton: .default(Text("Awesome!")))
            }
            
            Spacer()
            
            // Score row
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Start over")
                }.padding(16)
                Spacer()
                Text("Score:").foregroundColor(Color.red)
                Text("\(score)")
                Spacer()
                Text("Round:").foregroundColor(Color.purple)
                Text("\(round)")
                Spacer()
                Button(action: {}) {
                    Text("Info")
                }
            }.padding(.bottom, 16)
        }
    }
    
    func sliderValueRounded() -> Int {
        Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        return 100 - abs(target - sliderValueRounded())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
