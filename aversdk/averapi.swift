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
        let encodedKey = self.encodeKey(key: key, secret: secret)
        return self.callService(token: encodedKey!, endpoint: "/auth/token", method: HttpMethod.get, params: nil, modelType: AverAuthResponse.self) as Result<AverAuthResponse?,Error>
    }
    
    public func refreshAuthToken(token: String) -> Result<AverAuthResponse?, Error> {
        let params: [String:Any] = ["token": token]
        return self.callService(token: token, endpoint: "/auth/refresh/", method: HttpMethod.post, params: params, modelType: AverAuthResponse.self) as Result<AverAuthResponse?,Error>
    }
    
    public func createCheck(token: String, options: AverCheckCreateRequest) -> Result<AverCheckCreateResponse?,Error> {
        let params: [String:Any] =
            ["groupId": options.groupId,
             "thirdPartyIdentifier": options.thirdPartyIdentifier,
             "email": options.email,
             "returnUrl": options.returnUrl,
             "language": options.language,
             "skipPersonalAccessCode": options.skipPersonalAccessCode,
             "overrideThirdPartyIdentifier": options.overrideThirdPartyIdentifier]
        
        return self.callService(token: token, endpoint: "/check/create", method: HttpMethod.post, params: params, modelType: AverCheckCreateResponse.self) as Result<AverCheckCreateResponse?,Error>
    }
    
    public func getCheckById(token: String, id: String) -> Result<AverCheckDetailResponse?, Error> {
        return self.callService(token: token, endpoint: "/check/" + id, method: HttpMethod.get, params: nil, modelType: AverCheckDetailResponse.self) as Result<AverCheckDetailResponse?, Error>
    }
    
    public func getCheckByThirdPartyIdentifier(token: String, thirdPartyIdentifier: String)  -> Result<AverCheckDetailResponse?, Error> {
        return self.callService(token: token, endpoint: "/check/getbythirdpartyidentifier/" + thirdPartyIdentifier, method: HttpMethod.get, params: nil, modelType: AverCheckDetailResponse.self) as Result<AverCheckDetailResponse?,Error>
    }
    
    public func getCheckResults(token: String, id: String)  -> Result<AverCheckDetailResponse?, Error> {
        return self.callService(token: token, endpoint: "/check/" + id + "/results", method: HttpMethod.get, params: nil, modelType: AverCheckDetailResponse.self) as Result<AverCheckDetailResponse?, Error>
    }
    
    public func getCheckAccessLink(token: String, id: String, language: String = "en", returnUrl: String = "") -> Result<AverCheckAccessLinkResponse?, Error> {
        let params: [String:Any] = ["language": language, "returnUrl": returnUrl]
        return self.callService(token: token, endpoint: "/check/" + id + "/accesslink", method: HttpMethod.post, params: params, modelType: AverCheckAccessLinkResponse.self) as Result<AverCheckAccessLinkResponse?, Error>
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
                        result = .failure(NSError(domain:"averapi", code:httpResponse.statusCode, userInfo:nil))
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
