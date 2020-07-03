//
//  APIManager.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 17/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager {
    typealias completion <T> = (_ result: T, _ failure: NSError?) -> Void
    var error: NSError = NSError(domain: "Erro :c", code: 400, userInfo: [NSLocalizedDescriptionKey: "Tivemos um problema ao obter as informações"])
    
    func getSummoner(summonerName: String, completion: @escaping completion<Summoner?>) {
        guard let summoner = summonerName.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) else {return}
        let url = API.baseURL_BR + API.summonerByName + summoner
        let parameters: Parameters = ["api_key":API.apiKey]
        AF.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    completion(nil, NSError(domain: response.error?.errorDescription ?? "", code: response.error?.responseCode ?? 0))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Summoner.self, from: data)
                    completion(result, nil)
                    return
                }catch {
                    print("Error - JSONDecoder() - ApiManager - getSummoner()")
                    completion(nil,self.error)
                    return
                }
                
            }else if response.response?.statusCode == 404 {
                let error: NSError = NSError(domain: "Erro :c", code: 404, userInfo: [NSLocalizedDescriptionKey: "Summoner não encontrado"])
                completion(nil, error)
            }else {
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print("Failure Response: \(json ?? "")")
                }
            }
        }
    }
    
    func getMatch(id: String, completion: @escaping completion<Spectator?>) {
        
        let url = API.baseURL_BR + API.spectatorMatch + id
        let parameters: Parameters = ["api_key":API.apiKey]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    completion(nil, NSError(domain: response.error?.errorDescription ?? "", code: response.error?.responseCode ?? 0))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Spectator.self, from: data)
                    completion(result, nil)
                    return
                }catch {
                    print("Error - JSONDecoder() - ApiManager - getSummoner()")
                    completion(nil,self.error)
                    return
                }
                
            }else if response.response?.statusCode == 404 {
                let error: NSError = NSError(domain: "Erro :c", code: 404, userInfo: [NSLocalizedDescriptionKey: "Partida não encontrada"])
                completion(nil, error)
            }else {
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print("Failure Response: \(json ?? "")")
                }
            }
        }
        
    }
}

