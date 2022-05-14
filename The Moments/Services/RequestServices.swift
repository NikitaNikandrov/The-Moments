//
//  RequestServices.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

class RequestServices {
    
    private let baseURL = "https://mssemenov.ru"
    
    func logInRequest(Login: String, Password: String, closure: @escaping((LogInUserDataFromServer?, (Int, String)) -> Void)) {
        //string for url
        let urlLogIn = baseURL + "/api/v1/login"
        
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
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let responseData: LoginJSONModels.LogInJSONmodel = try JSONDecoder().decode(LoginJSONModels.LogInJSONmodel.self, from: data)
                        let result = LogInUserDataFromServer()
                        result.token = responseData.data?.token
                        closure(result, (200, "Sucsessful"))
                    } catch let error { print(error) }
                    
                case 400:
                    closure(nil, (400, "Server error"))
                default:
                    closure(nil, (400, "Server error"))
                }
            }
        }.resume()
    }
    
    func registerRequest(RegisterArguments: MethodArguments.AuthUserArguments, closure: @escaping((BaseUserDataFromServer?) -> Void)) {
        //string for url
        let urlRegister = baseURL + "/api/v1/register-user"
        
        //url to request
        guard let requestURL = URL(string: urlRegister) else {
            closure(nil)
            return
        }
        
        //request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        //prepare JSON for request
        let requestJSON: [String: String] = ["name": RegisterArguments.login,
                                             "email": RegisterArguments.password,
                                             "password": RegisterArguments.confirmPassword]
        
        let requestJSONData = try? JSONSerialization.data(withJSONObject: requestJSON)
        
        //inseart JSON data to request
        request.httpBody = requestJSONData
        
        //Send request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200 :
                    //model's data object for response
                    var resultResponse: RegisterJSONModels.SuccessRegistrJSONModel?
                    do {
                        resultResponse = try JSONDecoder().decode(RegisterJSONModels.SuccessRegistrJSONModel.self, from: data)
                        
                        let result = BaseUserDataFromServer()
                        /*
                         result.id = resultResponse?.id
                         result.name = resultResponse?.name
                         result.email = resultResponse?.email
                         */
                        closure(result)
                    } catch let error { print(error) }
                case 422:
                    var resultResponse: RegisterJSONModels.BadPassRegistrJSONModel?
                    do {
                        resultResponse = try JSONDecoder().decode(RegisterJSONModels.BadPassRegistrJSONModel.self, from: data)
                    closure(nil)
                    } catch let error { print(error) }
                default:
                    var resultResponse: RegisterJSONModels.FailRegisterRegistrJSONModel?
                    do {
                        resultResponse = try JSONDecoder().decode(RegisterJSONModels.FailRegisterRegistrJSONModel.self, from: data)
                    closure(nil)
                    } catch let error { print(error) }
                }
            }
        }.resume()
    }
}
