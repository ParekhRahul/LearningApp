//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Rahul Parekh on 2021-05-18.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack{
        if url != nil {
            VideoPlayer(player: AVPlayer(url: url!))
                .cornerRadius(10)
        }
        
        // Description
        
        
        // Next lesson button if there is next lesson
            if model.hasNextLesson(){
                Button(action: {
                    model.nextLesson()
                }, label: {
                    
                    ZStack{
                    
                    Rectangle()
                        .frame(height:48)
                        .foregroundColor(Color.green)
                        .shadow(radius: 5)
                        .cornerRadius(10)
                        
                        
                        
                    Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                        .foregroundColor(Color.white)
                        .bold()
                    }
                })
            }
        
            
        }
        .padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
