//
//  RequestServices.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class RequestServices {
    
    private var baseURL = "https://api-meetings.nenado.info"
    
    func logInRequest(Login: String, Password: String, closure: @escaping((UserDataFromServer?) -> Void)) {
        //string for url
        let urlLogIn = baseURL + "/api/v1/auth-user"
        
        //model's data object for respose
        var resultResponse: JSONModels.UserDataFromServer?
       
        //url to request
        guard let requestURL = URL(string: urlLogIn) else {
            closure(nil)
            return
        }
        
        //request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        //prepare JSON for request
        let requestJSON: [String: String] = ["email": Login,
                                      "password": Password]
        
        let requestJSONData = try? JSONSerialization.data(withJSONObject: requestJSON)
        
        //inseart JSON data to request
        request.httpBody = requestJSONData
        
        //Send request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200 {
                    do {
                        resultResponse = try JSONDecoder().decode(JSONModels.UserDataFromServer.self, from: data)
                        
                        let result = UserDataFromServer()
                        
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
    
    func registerRequest(RegisterArguments: MethodsArguments.RegsterRequestArguments, closure: @escaping((UserDataFromServer?) -> Void)) {
        //string for url
        let urlRegister = baseURL + "/api/v1/register-user"
        
        //model's data object for response
        var resultResponse: JSONModels.UserDataFromServer?
        
        //url to request
        guard let requestURL = URL(string: urlRegister) else {
            closure(nil)
            return
        }
        
        //request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        //prepare JSON for request
        let requestJSON: [String: String] = ["email": RegisterArguments.login,
                                             "password": RegisterArguments.password,
                                             "password_confirmation": RegisterArguments.passwordConfirm]
        
        let requestJSONData = try? JSONSerialization.data(withJSONObject: requestJSON)
        
        //inseart JSON data to request
        request.httpBody = requestJSONData
        
        //Send request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200 {
                    do {
                        resultResponse = try JSONDecoder().decode(JSONModels.UserDataFromServer.self, from: data)
                        
                        let result = UserDataFromServer()
                        
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
