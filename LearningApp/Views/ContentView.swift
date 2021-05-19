//
//  ContentView.swift
//  LearningApp
//
//  Created by Rahul Parekh on 2021-05-18.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView{
            LazyVStack{
                
                // Confirm that current module is not nil
                if model.currentModule != nil{
                    ForEach(0..<model.currentModule!.content.lessons.count ){ index in
                        // Lesson Card
                        ContentViewRow(index: index)
                        
                    }
                }
            }
            
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}