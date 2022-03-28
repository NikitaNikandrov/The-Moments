//
//  RequestServices.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class RequestServices {
    
    private var baseURL = "https://api-meetings.nenado.info"
    
    func logInRequest(Login: String, Password: String, closure: @escaping((LogInUserDataFromServer?, (Int, String)) -> Void)) {
        //string for url
        let urlLogIn = baseURL + "/api/v1/auth-user"
        
        //url to request
        guard let requestURL = URL(string: urlLogIn) else { return }
        
        //request
        var request = URLRequest(url: requestURL)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        //prepare JSON for request
        let requestJSON: [String: Any] = ["email" : Login,
                                          "password" : Password]
        
        let requestJSONData = try? JSONSerialization.data(withJSONObject: requestJSON, options: .prettyPrinted)
        
        //inseart JSON data to request
        request.httpBody = requestJSONData
        
        //Send request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                closure(nil, (400, "\(error)"))
                return
            }
            guard let data = data else { return }
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let responseData: JSONModels.LogInJSONmodel = try JSONDecoder().decode(JSONModels.LogInJSONmodel.self, from: data)
                        let result = LogInUserDataFromServer()
                        result.id = responseData.data?.id
                        result.name = responseData.data?.name
                        result.email = responseData.data?.email
                        result.avatar = responseData.data?.avatar
                        result.apiToken = responseData.data?.apiToken
                        closure(result, (200, "Sucsessful"))
                    } catch let error { print(error) }
                
                case 400:
                    do {
                        let responseData: JSONModels.LogInJSONmodel = try JSONDecoder().decode(JSONModels.LogInJSONmodel.self, from: data)
                        let errorMessage: String = responseData.message ?? "Server error"
                        closure(nil, (400, errorMessage))
                    } catch let error { print(error) }
                
                default:
                    closure(nil, (400, "Server error"))
                }
            }
        }.resume()
    }
    
    func registerRequest(RegisterArguments: MethodArguments.AuthUserArguments, closure: @escaping((BaseUserDataFromServer?) -> Void)) {
        //string for url
        let urlRegister = baseURL + "/api/v1/register-user"
        
        //model's data object for response
        var resultResponse: JSONModels.LogInJSONmodel?
        
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
                                             "password_confirmation": RegisterArguments.confirmPassword]
        
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
                        resultResponse = try JSONDecoder().decode(JSONModels.LogInJSONmodel.self, from: data)
                        
                        let result = BaseUserDataFromServer()
                        /*
                         result.id = resultResponse?.id
                         result.name = resultResponse?.name
                         result.email = resultResponse?.email
                         */
                        closure(result)
                    } catch let error { print(error) }
                } else {
                    closure(nil)
                }
            }
        }.resume()
    }
}
