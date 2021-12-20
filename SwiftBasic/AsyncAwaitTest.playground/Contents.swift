import UIKit
import Foundation

func thumnailURLReqeust(for id: String) -> URLRequest {
    let request = URLRequest(url: URL(string: "URL TEST APP")!)
    return request
}

//func fetchThumbnail(for id: String, completion: @escaping (UIImage?, Error?) -> Void) {
//    let request = thumnailURLReqeust(for: id)
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//        if let error = error {
//            completion(nil, error)
//        } else if (response as? HTTPURLResponse)?.statusCode != 200 {
//            completion(nil, FetchError.badID)
//        }
//
//
//    }
//    task.resume()
//}

enum APIError {
    case badId
}

func fetchThumbnail(for id: String) async throws -> UIImage {
    let request = thumnailURLReqeust(for: id)
    let (data, response) = try await URLSession.shared.dataTask(with: request)
    guard (request as? HTTPURLResponse)?.statusCode = 200 else { throw APIError.badId }
    let maybeImage = UIImage(data: data)
    
}
 
