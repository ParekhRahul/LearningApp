//
//  ContentModel.swift
//  LearningApp
//
//  Created by Rahul Parekh on 2021-05-17.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    var styleData:Data?
    
    init() {
        getLocalData()
    }
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
    
}
