//
//  RequestServices.swift
//  The Moments
//
//  Created by Никита on 18.12.2021.
//

import Foundation

enum Result<T> {
    case sucsess(T)
    case error(Int, String)
}

class AuthenticationRequestService {
    
    private func prepareRequest(request: inout URLRequest) {
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
    }

    func logInRequest(login: String, password: String, closure: @escaping((Result <LogInUserDataFromServer>) -> Void)) {

        let urlLogIn = Resources.NetworkServicesStrings.baseURL + Resources.NetworkServicesStrings.logInURL

        guard let requestURL = URL(string: urlLogIn) else { return }

        var request = URLRequest(url: requestURL)
        prepareRequest(request: &request)

        let requestJSON: [String: String] = [ "email": login,
                                           "password": password ]

        let requestJSONData = try? JSONSerialization.data(withJSONObject: requestJSON, options: .prettyPrinted)

        request.httpBody = requestJSONData

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let responseData: LoginJSONModel.SuccessLogInJSONmodel = try JSONDecoder().decode(LoginJSONModel.SuccessLogInJSONmodel.self, from: data)
                        let result = LogInUserDataFromServer()
                        result.name = responseData.data.name
                        result.token = responseData.data.token
                        closure(.sucsess(result))
                    } catch let error { print(error) }

                case 400:
                    closure(.error(400, Resources.ErrorMessages.serverError))
                default:
                    closure(.error(400, Resources.ErrorMessages.serverError))
                }
            }
        }.resume()
    }

    func registerRequest(RegisterArguments: MethodArguments.RegisterUserArguments, closure: @escaping((Result <BaseUserDataFromServer>) -> Void)) {

        let urlRegister = Resources.NetworkServicesStrings.baseURL + Resources.NetworkServicesStrings.registerURL

        guard let requestURL = URL(string: urlRegister) else {
            closure(.error(400, "error"))
            return
        }

        var request = URLRequest(url: requestURL)
        prepareRequest(request: &request)

        let requestJSON: [String: String] = [ "name": RegisterArguments.login,
                                              "email": RegisterArguments.email,
                                              "password": RegisterArguments.password ]

        let requestJSONData = try? JSONSerialization.data(withJSONObject: requestJSON, options: .prettyPrinted)

        request.httpBody = requestJSONData

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200 :
                    var resultResponse: RegisterJSONModels.SuccessRegistrJSONModel?
                    do {
                        resultResponse = try JSONDecoder().decode(RegisterJSONModels.SuccessRegistrJSONModel.self, from: data)
                        let result = LogInUserDataFromServer()
                        result.name = resultResponse?.data.name
                        closure(.sucsess(result))
                    } catch let error { print(error) }
                case 422:
                    var resultResponse: RegisterJSONModels.BadPassRegistrJSONModel?
                    do {
                        resultResponse = try JSONDecoder().decode(RegisterJSONModels.BadPassRegistrJSONModel.self, from: data)
                        guard let message = resultResponse?.message.password[0] else { return }
                        closure(.error(422, message))
                    } catch let error { print(error) }
                default:
                    var resultResponse: RegisterJSONModels.FailRegisterRegistrJSONModel?
                    do {
                        resultResponse = try JSONDecoder().decode(RegisterJSONModels.FailRegisterRegistrJSONModel.self, from: data)
                        guard let message = resultResponse?.message else { return }
                        closure(.error(400, message))
                    } catch let error { print(error) }
                }
            }
        }.resume()
    }
}
