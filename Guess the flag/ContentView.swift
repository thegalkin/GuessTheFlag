//
//  ContentView.swift
//  Guess the flag
//
//  Created by Никита Галкин on 21.10.2020.
//

import SwiftUI

struct ContentView: View {
	@State var countries = ["Estonia", "France", "Germany",  "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "USA" ].shuffled()
	@State var correctAnswer = Int.random(in: 0...3)
	@State private var showingScore = false
	@State private var scoreTitle = ""
	@State private var score = 0
    @State private var lastWrong = false
	var body: some View {
		ZStack{
            LinearGradient(gradient: Gradient(colors: lastWrong ? [.red, .black] : [.blue, .yellow]), startPoint: .top, endPoint: .bottomTrailing).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
		VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
			Text("Tap the flag of").foregroundColor(.white)
				.font(.headline)
			//.fontWeight(.medium)
			Text(countries[correctAnswer]).foregroundColor(.white)
				.font(.title)
				.fontWeight(.black)
				
				
				ForEach(0 ..< 4){number in
					Button(action: {
						self.flagTapped(number)
						
					}) {
						Image(self.countries[number])
							.renderingMode(.original)
							.clipShape(Capsule())
							.overlay(Capsule().stroke(Color.black, lineWidth: 1))
							.shadow(color: .black, radius: 2)
						
					}
				}
			
			Text(String(score))
				.font(.title)
				.fontWeight(.black)
		})
		.alert(isPresented: $showingScore, content: {
			Alert(title: Text(scoreTitle), message: Text("Your score is \(score) points"), dismissButton: .default(Text("Continue")){
				
				self.askQuestion()
				
			})
		})
	}
		
}
	func flagTapped(_ number: Int){
		if number == correctAnswer{
			scoreTitle = "Correct Answer"
			score += 1
            lastWrong = false
		} else{
			scoreTitle = "Wrong Answer"
            lastWrong = true
		}
		showingScore = true
	}
	
	func askQuestion(){
		countries.shuffle()
		correctAnswer = Int.random(in: 0...3)
		
		
		
	}
	
}
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
        ContentView()
            .previewDevice("iPhone SE (2nd generation)")
	}
}
