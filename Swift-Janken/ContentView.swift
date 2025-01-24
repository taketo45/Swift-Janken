//
//  ContentView.swift
//  Swift-Janken
//
//  Created by Taketoshi Ikegai on 2025/01/24.
//

import SwiftUI

struct ContentView: View {
    @State var imageName = "janken"
    @State var winlose = ""
    @State var playerHandImage = "janken"
    @State var pcHandImage = "janken"
    @State var playerHand = ""
    var body: some View {
        VStack {
            Image(imageName)
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            HStack {
                Image(playerHandImage)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Image(pcHandImage)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
            Text(winlose)
        }
        .padding()
        HStack {
            Button("ぐー"){
                junken("gu")
            }
            .modifier(ButtonModifier(backgtoundColor: .red))
            Button("ちょき"){
                junken("choki")
            }
            .modifier(ButtonModifier(backgtoundColor: .blue))
            Button("ぱー"){
                junken("pa")
            }
            .modifier(ButtonModifier(backgtoundColor: .green))
        }

    }
    
    func junken(_ playerHand: String){
        playerHandImage = playerHand
        let pcHand = getPcHand()
        pcHandImage = pcHand
        winlose = JudgeHand(playerHand, pcHand)
    }
    
}

#Preview {
    ContentView()
}

struct ButtonModifier: ViewModifier {
    let backgtoundColor: Color
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(backgtoundColor)
            .foregroundColor(.white)
    }
}

func getPcHand()->String {
    let dashites = ["gu", "choki", "pa"]
    
    return dashites[Int.random(in: 0...2)]
}

func JudgeHand(_ playerHand:String, _ pcHand:String)->String{
    let results: [String: [String: String]] = [
        "gu": ["pa": "まけ", "choki": "かち"],
        "choki": ["gu": "まけ", "pa": "かち"],
        "pa": ["choki": "まけ", "gu": "かち"]
    ]
    return playerHand == pcHand ? "あいこ" : (results[playerHand]?[pcHand] ?? "")
    
}
