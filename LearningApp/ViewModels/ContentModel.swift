//
//  ContentModel.swift
//  LearningApp
//
//  Created by Rahul Parekh on 2021-05-17.
//

import Foundation

class ContentModel: ObservableObject {
    
    
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current lesson explanation
    
    @Published var lessonDescription = NSAttributedString()
    
    var styleData:Data?
    
    // Current content selected
    @Published var currentContentSelected:Int?
    
    init() {
        getLocalData()
    }
    
    // MARK: Data methods
    func getLocalData() {
        
        // get the url to the json file
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do{
        // read the file into a data object
        
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            
            // try to decode a json into an array modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            self.modules = modules
        }
        catch{
            // todo log error
            print("Could't parse local data")
        }
        
        // Parse the style data
        
        let styleUrl = Bundle.main.url(forResource: "style",withExtension: "html")
        do{
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData        }
        catch{
            print("Could't parsr style data")
            
        }
        
       
    }
    
    // MARK: Module navigation methods
    
    func beginModule(_ moduleid:Int) {
        
        // Find the index for this module id
        
        for index in 0..<[modules].count{
            if(modules[index].id == moduleid){
                currentModuleIndex = index
                break
            }
        }
        
        // set the current module
        currentModule  = modules[currentModuleIndex]
    }
    
    // MARK: Lesson navigation methods
    
    func beginLesson(_ lessonIndex:Int) {
        
        // Check that the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count{
            currentLessonIndex = lessonIndex
        }
        else{
            currentLessonIndex = 0
        }
        
        
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        
        // Advance the lesson index
        
        currentLessonIndex += 1
        
        // Check that it is within the range
        
        if currentLessonIndex < currentModule!.content.lessons.count{
            
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else
        {
            // Reset the lesson set
            currentLessonIndex = 0
            currentLesson = nil
        }
        
        
    }
    
    func hasNextLesson() -> Bool {
        
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add styling data
        
        if styleData != nil {
            data.append(styleData!)
        }
        
        // Add the html data
        
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        
        if let attributedString  = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil){
            
            resultString = attributedString
        }
        
        return resultString
    }
}
