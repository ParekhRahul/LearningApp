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
    var styleData:Data?
    
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
    
}
