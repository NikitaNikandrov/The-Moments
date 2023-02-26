//
//  MeetingsRequestServices.swift
//  The Moments
//
//  Created by Никита on 26.02.2023.
//

import Foundation

class MeetingsRequestService {
    
    func prepareRequest(request: inout URLRequest, token: String) {
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
    }
    
    func getFavoritsMeetingsRequest(token: String, closure: @escaping((ResultOfResponse <[MeetingsDataModel]>) -> Void)) {
        
        let urlMeetings = Resources.NetworkServicesStrings.baseURL + Resources.NetworkServicesStrings.meetingsURL
        
        guard let requestURL = URL(string: urlMeetings) else { return }

        var request = URLRequest(url: requestURL)
        prepareRequest(request: &request, token: token)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let responseData: MeetingsJSONModel.MeetingsJSONModel = try JSONDecoder().decode(MeetingsJSONModel.MeetingsJSONModel.self,
                                                                                                         from: data)
                        let result = [MeetingsDataModel()]
                        if responseData.serviceData.perPage != 0 {
                            for item in responseData.serviceData.data! {
                                let meeting = MeetingsDataModel()
                                meeting.name = item.name
                                meeting.description = item.description
                                meeting.startAt = item.startAt
                                meeting.endAt = item.endAt
                                meeting.image = item.avatar?.image
                            }
                        }
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
}
