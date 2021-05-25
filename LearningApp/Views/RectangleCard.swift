//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Rahul Parekh on 2021-05-24.
//

import SwiftUI


struct RectangleCard: View {
    var color = Color.white
    var body: some View {
        
        Rectangle()
            .foregroundColor(color)
            .shadow(radius: 5)
            .cornerRadius(10)
            
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
