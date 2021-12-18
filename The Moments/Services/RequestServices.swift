//
//  RequestServices.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class RequestServices {
    
    private var baseURL = "https://api-meetings.nenado.info"
    
    func logInRequest(Login: String, Password: String, closure: @escaping((UserIsLogedIn?) -> Void)) {
        
        let urlLogIn = baseURL + "/api/v1/auth-user"
        var resultResponse: JSONModels.LogInUser?
        
        guard var urlRequest = URLComponents(string: urlLogIn) else {
            closure(nil)
            return
        }
        
        let queryItems = [URLQueryItem(name: "email", value: Login),
                          URLQueryItem(name: "password", value: Password)]
        urlRequest.queryItems = queryItems
        
        guard let finalURLRequest = urlRequest.url else {
            closure(nil)
            return
        }
        
        URLSession.shared.dataTask(with: finalURLRequest) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200 {
                    do {
                        resultResponse = try JSONDecoder().decode(JSONModels.LogInUser.self, from: data)
                        
                        let result = UserIsLogedIn()
                        
                        result.id = resultResponse?.id
                        result.name = resultResponse?.name
                        result.email = resultResponse?.email
                        result.avatar = resultResponse?.avatar
                        result.apiToken = resultResponse?.apiToken
                        
                        closure(result)
                    } catch let error { print(error) }
                } else {
                    closure(nil)
                }
            }
        }.resume()
    }
}
