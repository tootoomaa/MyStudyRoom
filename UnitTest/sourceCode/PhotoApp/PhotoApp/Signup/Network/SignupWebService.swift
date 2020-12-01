//
//  SignupWebService.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/11/30.
//

import Foundation

class SignupWebService {
    
    private var urlString: String
    private var urlSession: URLSession
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completionHandler(nil, .invalidRequestURLString)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(formModel)
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            if let requestError = error {
                completionHandler(nil, SignupError.failedRequest(description: requestError.localizedDescription))
                return
            }
            
            if let data = data, let signResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                completionHandler(signResponseModel, nil)
            } else {
                completionHandler(nil, .invalidResponseModel)
            }
        }
        
        dataTask.resume()
    }
    
}
