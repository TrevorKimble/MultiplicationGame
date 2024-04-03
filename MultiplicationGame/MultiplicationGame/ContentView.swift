//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Trevor Kimble on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var maxValue = 3
    @State private var questionCount = 5
    @State private var questions = [String]()
    @State private var answers = [Int]()
    @State private var correct = 0
    @State private var questionCounter = 0
    @State private var userInput: Int?
    
    @State private var test = 0
    
    var body: some View {
        VStack{
            Stepper("Max table value \(maxValue)", value: $maxValue, in: 3...15)
            Stepper("How many questions \(questionCount)", value: $questionCount, in: 3...25)
        }
        .onAppear{generateQuestions()}
        .onChange(of: maxValue, perform: { _ in generateQuestions()})
        .onChange(of: questionCount, perform: { _ in generateQuestions()})
        
        Section{
            ForEach(questions, id: \.self) { question in
                Text("\(question)")
            }
        }
Text("_______")
        Text("Correct \(correct)")
        VStack{
            if (questions.indices.contains(questionCounter) ){
                HStack{
                    Text("\(questions[questionCounter]) =")
                    TextField("?", text: Binding<String>(
                        get: { userInput.map(String.init) ?? ""},
                        set: {userInput = Int($0)}
                    ))
                }
                Button {
                    checkAnswer(userInput)
                    userInput = nil
                } label: {
                    Text("Submit")
                }


            }
            
        }
        Text("_______")
        Button{
            generateQuestions()
        } label: {
            Text("Restart")
        }
        
    }
    
    
    
    func generateQuestions(){
        var newQuestions = [String]()
        var newAnswers = [Int]()
        var a = 0
        var b = 0
        for _ in 0..<questionCount{
            a = Int.random(in: 1...maxValue)
            b = Int.random(in: 1...maxValue)
            
            newQuestions.append("\(a) * \(b)")
            newAnswers.append(a * b)
        }
        
        questions = newQuestions
        answers = newAnswers
        correct = 0
        questionCounter = 0
    }
    
    func checkAnswer(_ input: Int?) {
        guard let input = input else { return }
        guard questionCounter < answers.count else {

            return
        }
     
        if input == answers[questionCounter] {
            correct += 1
        }
        questionCounter += 1
    }
}

#Preview {
    ContentView()
}
