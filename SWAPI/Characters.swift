//
//  Characters.swift
//  SWAPI
//
//  Created by Samuel Pena on 6/21/22.
//  Copyright © 2022 Samuel Pena. All rights reserved.
//

import Foundation

class Characters {
    
    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Character]
    }
    
    struct Character: Codable {
        var name = ""
        var url = ""
    }
    
    var count = 0
    var urlString = "https://swapi.dev/api/people/?offset=0&limit=20"
    var characterArray: [Character] = []
    
    func getData(completed: @escaping ()->()) {
        print("🕸 We are accessing the url \(urlString)")
        
        // create a url
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a url from \(urlString)")
            return
        }
        
        // create a session
        let session = URLSession.shared
        
        // get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription)")
            }
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                print("😎 Here is what was returned \(returned)")
                self.characterArray = self.characterArray + returned.results
                self.urlString = returned.next ?? ""
                self.count = returned.count
            } catch {
                print("😡 JSON ERROR: thrown when we tried to decode from Returned.self with data")
            }
            completed()
        }
        
        task.resume()
    }
}
