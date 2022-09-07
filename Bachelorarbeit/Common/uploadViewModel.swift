//
//  uploadViewModel.swift
//  Bachelorarbeit
//
//  Created by JT X on 18.08.22.
//


// Version 1

import Foundation
class uploadViewModel: ObservableObject{
    
   
    func UploadAudioFiles(){
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
     
     /*
        Webservice().uploadAudios(accessToken:token) {
            (result) in
            switch result{
            case .success(let dictionary):
                print(dictionary)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        */
        Webservice().uploadAudios(token:token) 
        
    }
    
    
    
}




// Version 2


/*
import Foundation

//class uploadViewModel:ObservableObject{
struct uploadViewModel {
    
    
/*    func getTestAudioUrl()-> URL {
        guard let filePathFive = Bundle.main .path(forResource: "testAudio", ofType: "wav") else { return URL.init(fileURLWithPath: "") }
    return URL.init(fileURLWithPath: filePathFive)
      
    }
    */
    func getTestAudioUrl()-> URL {
        guard let filePathFive = Bundle.main .path(forResource: "testAudio", ofType: "wav") else { return }
      
    }
    
    func UploadAudioFiles(){
        let defaults = UserDefaults.standard
        guard let accessToken = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        
        
        let testAudioURL = getTestAudioUrl()
        let audioData = try! Data(contentsOf: testAudioURL)
        
        func uploadImage(accessToke: String, data: Data, completionHandler: @escaping(_ result: AudioRequest) -> Void)
        {
            let uploadurl = URL (string: "http://localhost:8080/projects/{project_id}/tasks")
            
            let webService = Webservice()
            
            /*
             var  project_id = ""
             var  inputs = " "
             var properties = " "
              var content_type = ""
              var transcript = " "
             */
            
            
            let audioRequest = AudioRequest(project_id: "ID 1", inputs: audioData.base64EncodedString(), properties: "", content_type: "", transcript: " " )
               
            
            
  //      accessToken: String, requestUrl: URL, request: AudioRequest, resultType: T.Type, completionHandler:@escaping
            
            webService.uploadFunction(accessToken: accessToken, requestUrl: uploadurl, request: audioRequest, resultType: audioResponse.self  ){
                
            }
            
        }
        
        
        
   /*
        Webservice.uploadAudios(token:token) {
            (result) in
            switch result{
            case .success(let ):
                
            case .failure(let error):
                print(error?.localizedDescription)
                
            }
        }
        */
    
}
*/
