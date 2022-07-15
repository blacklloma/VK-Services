//
//  JSONModel.swift
//  VK Test
//
//  Created by Ilya Vladimirovich on 14.07.2022.
//

import UIKit

struct Body: Codable {
    
    let body: Service
    
}

struct Service: Codable {
    
    let services: [Services]
    
}

struct Services: Codable {
    
    var name: String
    var description: String
    var link: String
    var icon_url: URL
    
}

class Api {
    
    func getPost(completion: @escaping ([Services]) -> ()) {
        
        guard let url = URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            if let data = data {
                let results = try! JSONDecoder().decode(Body.self, from: data)
                DispatchQueue.main.async {
                    completion(results.body.services)
                }
            }
        }
        .resume()
    }
    
}
