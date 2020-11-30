//
//  SignupWebService.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/11/30.
//

import Foundation

protocol SignupWebServiceProcotol {
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupErrors?) -> Void)
}

class SignupWebServiceStub: SignupWebServiceProcotol {
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupErrors?) -> Void) {
        
    }
}

class SignupWebService: SignupWebServiceProcotol {
    
    private var urlString: String
//    private var urlSession: URLSession , urlSession: URLSession
    
    init(urlString: String) {
        self.urlString = urlString
//        self.urlSession = urlSession
    }
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupErrors?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            // TODO: Create Unit Test to test a specific error message is return url is nil
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(formModel)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //TODO: Write a new Unit Test to handle and error here
            
            if let data = data, let signResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                completionHandler(signResponseModel, nil)
            } else {
                //TODO: Write a new Unit Test to handle and error here
            }
        }
        
        dataTask.resume()
    }
    
}
