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
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Avenir-Medium", size: 24))
                .modifier(Shadow())
        }
    }
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Avenir", size: 18))
                .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Avenir", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Avenir", size: 12))
        }
    }
    
    var body: some View {
        VStack {// Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(target)")
                    .modifier(ValueStyle())
            }.padding(.top, 16)
            
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                    .modifier(LabelStyle())
                Slider(value: $sliderValue, in:1...100)
                    .accentColor(Color.green)
                Text("100")
                    .modifier(LabelStyle())
            }.padding(.horizontal, 16)
            
            Spacer()
            
            // Button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/)
                    .modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text(alertTitle()),
                             message: Text("The slider's value is \(sliderValueRounded()).\n" +
                                "You scored \(self.pointsForCurrentRound()) points this round."),
                             dismissButton: .default(Text("OK"), action: {
                                self.score += self.pointsForCurrentRound()
                                self.target = Int.random(in: 1...100)
                                self.round += 1
                             }))
            }
            .background(Image("Button"))
            
            Spacer()
            
            // Score row
            HStack {
                Button(action: {
                    self.resetTheGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over")
                            .modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                Spacer()
                Text("Score:")
                    .modifier(LabelStyle())
                Text("\(score)")
                    .modifier(ValueStyle())
                Spacer()
                Text("Round:")
                    .modifier(LabelStyle())
                Text("\(round)")
                    .modifier(ValueStyle())
                Spacer()
                Button(action: {}) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                            .modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
            }.padding(.bottom, 16)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
    }
    
    func resetTheGame() {
        score = 0
        round = 1
        target = Int.random(in: 1...100)
        sliderValue = 50.0
    }
    
    func sliderValueRounded() -> Int {
        Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    
    func amountOff() -> Int {
        abs(target - sliderValueRounded())
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title : String
        if (difference == 0) {
            title = "Perfect!"
        } else if (difference <= 5) {
            title =  "You almost had it!"
        } else if (difference <= 10) {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
