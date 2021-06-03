//
//  api.swift
//  aversdk
//

import Foundation

internal class AverApi {
    private var baseUrl: String
    private enum HttpMethod {
        case get
        case post
    }
    
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    
    public func getAuthToken(key: String, secret: String) -> Result<AverAuthResponse?, Error> {
        print("averapi:getAuthToken")
        let encodedKey = self.encodeKey(key: key, secret: secret)
        return self.callService(token: encodedKey!, endpoint: "/auth/token", method: HttpMethod.get, params: nil, modelType: AverAuthResponse.self) as Result<AverAuthResponse?,Error>
    }
    
    public func refreshAuthToken(token: String) -> Result<AverAuthResponse?, Error> {
        print("averapi:refreshAuthToken")
        let params: [String:Any] = ["token": token]
        return self.callService(token: token, endpoint: "/auth/refresh/", method: HttpMethod.post, params: params, modelType: AverAuthResponse.self) as Result<AverAuthResponse?,Error>
    }
    
    public func createCheck(token: String, options: AverCheckCreateRequest) -> Result<AverCheckCreateResponse?,Error> {
        print("averapi:createCheck")
        let params: [String:Any] = [
            "groupId": options.groupId,
            "thirdPartyIdentifier": options.thirdPartyIdentifier,
            "email": options.email,
            "returnUrl": options.returnUrl,
            "language": options.language.rawValue,
            "skipPersonalAccessCode": options.skipPersonalAccessCode,
            "overrideThirdPartyIdentifier": options.overrideThirdPartyIdentifier
        ]
        
        return self.callService(token: token, endpoint: "/check/create", method: HttpMethod.post, params: params, modelType: AverCheckCreateResponse.self) as Result<AverCheckCreateResponse?,Error>
    }

    public func getCheckById(token: String, id: String) -> Result<AverCheckDetailResponse?, Error> {
        print("averapi:getCheckById:" + id)
        return self.callService(token: token, endpoint: "/check/" + id, method: HttpMethod.get, params: nil, modelType: AverCheckDetailResponse.self) as Result<AverCheckDetailResponse?, Error>
    }
    
    public func getCheckByThirdPartyIdentifier(token: String, id: String)  -> Result<AverCheckDetailResponse?, Error> {
        print("averapi:getCheckByThirdPartyIdentifier:" + id)
        return self.callService(token: token, endpoint: "/check/getbythirdpartyidentifier/" + id, method: HttpMethod.get, params: nil, modelType: AverCheckDetailResponse.self) as Result<AverCheckDetailResponse?,Error>
    }
    
    public func getCheckResults(token: String, id: String)  -> Result<AverCheckDetailResponse?, Error> {
        print("averapi:getCheckResults:" + id)
        return self.callService(token: token, endpoint: "/check/" + id + "/results", method: HttpMethod.get, params: nil, modelType: AverCheckDetailResponse.self) as Result<AverCheckDetailResponse?, Error>
    }
    
    public func getCheckAccessLink(token: String, id: String, language: String = "en", returnUrl: String = "") -> Result<AverCheckAccessLinkResponse?, Error> {
        print("averapi:getCheckAccessLink:" + id)
        let params: [String:Any] = ["language": language, "returnUrl": returnUrl]
        return self.callService(token: token, endpoint: "/check/" + id + "/accesslink", method: HttpMethod.post, params: params, modelType: AverCheckAccessLinkResponse.self) as Result<AverCheckAccessLinkResponse?, Error>
    }
    
    public func createWatchlistSearch(token: String, options: AverWatchlistSearchRequest) -> Result<AverWatchlistSearchResponse?,Error> {
        print("averapi:createWatchlistSearch")
        var categories: [String]? = []
        if(options.categories != nil){
            for category in options.categories! {
                categories?.append(category.rawValue)
            }
        }
        
        let params: [String:Any] = [
            "groupId": options.groupId as Any,
            "firstName": options.firstName as Any,
            "middleName": options.middleName as Any,
            "lastName": options.lastName as Any,
            "businessName": options.businessName as Any,
            "country": options.country as Any,
            "stateOrProvince": options.stateOrProvince as Any,
            "fileContent": options.fileContent as Any,
            "fileName": options.fileName as Any,
            "categories": categories as Any
        ]
        
        return self.callService(token: token, endpoint: "/watchlist/search", method: HttpMethod.post, params: params, modelType: AverWatchlistSearchResponse.self) as Result<AverWatchlistSearchResponse?,Error>
    }
    
    public func getWatchlistSearchById(token: String, id: String)  -> Result<AverWatchlistSearchResults?, Error> {
        print("averapi:getWatchlistSearchById:" + id)
        return self.callService(token: token, endpoint: "/watchlist/" + id, method: HttpMethod.get, params: nil, modelType: AverWatchlistSearchResults.self) as Result<AverWatchlistSearchResults?, Error>
    }
    
    public func getWatchlistSearchByCheckId(token: String, id: String)  -> Result<AverWatchlistSearchResults?, Error> {
        print("averapi:getWatchlistSearchByCheckId:" + id)
        return self.callService(token: token, endpoint: "/watchlist/getbycheckid/" + id, method: HttpMethod.get, params: nil, modelType: AverWatchlistSearchResults.self) as Result<AverWatchlistSearchResults?, Error>
    }
    
    public func getWatchlistSearchResults(token: String, id: String)  -> Result<AverWatchlistSearchResults?, Error> {
        print("averapi:getWatchlistSearchResults:" + id)
        return self.callService(token: token, endpoint: "/watchlist/" + id + "/results", method: HttpMethod.get, params: nil, modelType: AverWatchlistSearchResults.self) as Result<AverWatchlistSearchResults?, Error>
    }
    
    private func callService<T:Decodable>(token: String, endpoint:String, method: HttpMethod, params: Any?, modelType: T.Type) -> Result<T?,Error> {
        var result: Result<T?, Error>!
        
        guard let url = URL(string: self.baseUrl + endpoint) else { return .failure(AverApiError.urlError) }
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
                request.httpBody = try JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted)
            }
            catch let error {
                print(error.localizedDescription)
                result = .failure(error)
                return result
            }
        }
    
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            let code = httpResponse.statusCode
            if let data = data {
                do{
                    let str = String(decoding: data, as: UTF8.self)
                    print("averapi:response:" + str)
                    let obj = try JSONDecoder().decode(modelType, from: data)
                    result = .success(obj)
                }
                catch{
                    if(code == 500){
                        result = .failure(AverApiError.serverError)
                    }
                    else if(code == 401){
                        result = .failure(AverApiError.unauthorized)
                    }
                    else if(code != 200){
                        result = .failure(NSError(domain:"averapi", code:httpResponse.statusCode))
                    }
                    else{
                        result = .failure(error)
                    }
                }
            }
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
    
    private func encodeKey(key: String, secret: String) -> String? {
        let str = key + ":" + secret
        let utf8str = str.data(using: .utf8)
        if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
            return(base64Encoded)
        }
        return nil
    }
}
