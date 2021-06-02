//
//  api.swift
//  aversdk
//

import Foundation

public class AverApi {
    private var baseUrl: String
    private enum HttpMethod {
        case get
        case post
    }
    
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    public func getAuthToken(key: String, secret: String, completion: @escaping (String?, Error?) -> ()) {
        guard let encodedKey = self.encodeKey(key: key, secret: secret) else { return }
        self.callService(token: encodedKey, endpoint: "/auth/token", method: HttpMethod.get, params: nil, completion: { (data, error) in
            if(error != nil){
                completion(nil, error)
            }
            
            do {
                guard let data = data else { return }
                let auth = try JSONDecoder().decode(AverAuthResponse.self, from: data)
                completion(auth.token, nil)
            }
            catch{
                completion(nil, error)
            }
        })
    }
    
    public func refreshAuthToken(token: String, completion: @escaping (String?, Error?) -> ()){
        let params: [String:Any] = ["token": token]
        
        self.callService(token: token, endpoint: "/auth/refresh/", method: HttpMethod.post, params: params, completion: { (data, error) in
            if(error != nil){
                completion(nil, error)
            }
            
            do {
                guard let data = data else { return }
                let auth = try JSONDecoder().decode(AverAuthResponse.self, from: data)
                completion(auth.token, nil)
            }
            catch{
                completion(nil, error)
            }
        })
    }
    
    public func createCheck(token: String, options: AverCheckCreateRequest, completion: @escaping (AverCheckCreateResponse?, Error?) -> ()){
        let params: [String:Any] =
            ["groupId": options.groupId,
             "thirdPartyIdentifier": options.thirdPartyIdentifier,
             "email": options.email,
             "returnUrl": options.returnUrl,
             "language": options.language,
             "skipPersonalAccessCode": options.skipPersonalAccessCode,
             "overrideThirdPartyIdentifier": options.overrideThirdPartyIdentifier]
        
        self.callService(token: token, endpoint: "/check/create", method: HttpMethod.post, params: params, completion: { (data, error) in
            if(error != nil){
                completion(nil, error)
            }
             
            do {
                if(data == nil){
                    return
                }
                guard let responseString = String(data: data!, encoding: .utf8) else { return }
                print(responseString)
                let res = try JSONDecoder().decode(AverCheckCreateResponse.self, from: data!)
                completion(res, nil)
            }
            catch{
                print(error)
                completion(nil, error)
            }
        })
    }
    
    public func getCheckById(token: String, id: String, completion: @escaping (AverCheckDetailResponse?, Error?) -> ()){
        self.callService(token: token, endpoint: "/check/" + id, method: HttpMethod.get, params: nil, completion: { (data, err) in
            if(err != nil){
                completion(nil, err)
            }
             
            do {
                if(data == nil){
                    return
                }
                guard let responseString = String(data: data!, encoding: .utf8) else { return }
                print(responseString)
                let res = try JSONDecoder().decode(AverCheckDetailResponse.self, from: data!)
                completion(res, nil)
            }
            catch{
                print(error)
                completion(nil, error)
            }
        })
    }
    
    public func getCheckByThirdPartyIdentifier(token: String, thirdPartyIdentifier: String, all: Bool, completion: @escaping (AverCheckDetailResponse?, Error?) -> ()){
        var endpoint = "/check/getbythirdpartyidentifier/" + thirdPartyIdentifier
        if(all){
            endpoint = endpoint + "?all=true"
        }
        
        self.callService(token: token, endpoint: endpoint, method: HttpMethod.get, params: nil, completion: { (data, error) in
            if(error != nil){
                completion(nil, error)
            }
             
            do {
                if(data == nil){
                    return
                }
                guard let responseString = String(data: data!, encoding: .utf8) else { return }
                print(responseString)
                let res = try JSONDecoder().decode(AverCheckDetailResponse.self, from: data!)
                completion(res, nil)
            }
            catch{
                print(error)
                completion(nil, error)
            }
        })
    }
    
    public func getCheckResults(token: String, id: String, completion: @escaping (AverCheckDetailResponse?, Error?) -> ()){
        self.callService(token: token, endpoint: "/check/" + id + "/results", method: HttpMethod.get, params: nil, completion: { (data, error) in
            if(error != nil){
                completion(nil, error)
            }
             
            do {
                if(data == nil){
                    return
                }
                guard let responseString = String(data: data!, encoding: .utf8) else { return }
                print(responseString)
                let res = try JSONDecoder().decode(AverCheckDetailResponse.self, from: data!)
                completion(res, nil)
            }
            catch{
                print(error)
                completion(nil, error)
            }
        })
    }
    
    public func createCheckAccessLink(token: String, id: String, language: String = "en", returnUrl: String = "", completion: @escaping (AverCheckAccessLinkResponse?, Error?) -> ()){
        let params: [String:Any] = ["language": language, "returnUrl": returnUrl]
        self.callService(token: token, endpoint: "/check/" + id + "/accesslink", method: HttpMethod.post, params: params, completion: { (data, error) in
            if(error != nil){
                completion(nil, error)
            }
             
            do {
                if(data == nil){
                    return
                }
                guard let responseString = String(data: data!, encoding: .utf8) else { return }
                print(responseString)
                let res = try JSONDecoder().decode(AverCheckAccessLinkResponse.self, from: data!)
                completion(res, nil)
            }
            catch{
                print(error)
                completion(nil, error)
            }
        })
    }
    
    public func encodeKey(key: String, secret: String) -> String? {
        let str = key + ":" + secret
        let utf8str = str.data(using: .utf8)
        if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
            return(base64Encoded)
        }
        return nil
    }
    
    private func callService(token: String, endpoint:String, method: HttpMethod, params: Any?, completion: @escaping (Data?, Error?) -> ()) {
        guard let url = URL(string: self.baseUrl + endpoint) else { return }
        var request = URLRequest(url: url)
        var tokenType = "Basic"
        if(endpoint != "/auth/token"){
            tokenType = "Bearer"
        }
        
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue(tokenType + " " + token, forHTTPHeaderField: "Authorization")
        if(method == HttpMethod.post){
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted) // pass dictionary to data object and set it as request body
            }
            catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error)  in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            let code = httpResponse.statusCode
            
            if(code == 500){
                completion(nil, AverApiError.serverError)
            }
            else if(code == 401){
                completion(nil, AverApiError.unauthorized)
            }
            else if(code != 200){
                completion(nil, NSError(domain:"averapi", code:httpResponse.statusCode, userInfo:nil))
            }
            else{
                completion(data, error)
            }
        }).resume()
    }
}
