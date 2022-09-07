//
//  AudioRequest.swift
//  Bachelorarbeit
//
//  Created by JT X on 16.08.22.
//

import Foundation


struct AudioRequest: Codable{
    
   var  project_id = 1
   var  inputs = " "
   var properties = " "
    var content_type = ""
    var transcript = " "
}

struct AudioManager {
    
    func uploadAudio(data:Data, compketionHandler:@escaping(_ result:AudioRequest) -> Void){
        
        
    }
    
    
}
