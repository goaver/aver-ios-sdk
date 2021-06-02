//
//  aversdk.swift
//  aversdk
//
//  Created by Gubanotorious on 5/28/21.
//

import Foundation

public class AverSdk {
    private var api: AverApi
    private var token: String?
    
    init(baseUrl: String? = "https://app.goaver.com/api") {
        self.api = AverApi(baseUrl: baseUrl!)
        self.token = "12412412412"
    }
    
    public func auth(key: String, secret: String, completion: @escaping (String?, Error?) -> ()){
        self.api.getAuthToken(key: key, secret: secret, completion: { (res, err) in
            self.token = res
            completion(res, err)
        })
    }
    
    private func refreshAuth(completion: @escaping (String?, Error?) -> ()){
        self.api.refreshAuthToken(token: self.token!) { res, err in
            if(res != nil){
                self.token = res
                completion(res, nil)
            }
            else if(err == nil && res == nil){
                completion(res, AverAuthError.invalidCredentials)
            }
        }
    }
    
    public func createCheck(options: AverCheckCreateRequest, completion: @escaping (AverCheckCreateResponse?, Error?) -> ()){
        self.refreshAuth() { res, err in
            if(err != nil){
                completion(nil, err)
            }
        }
        
        self.api.createCheck(token: self.token!, options: options) { res, err in
            completion(res, err)
        }
    }
    
    public func createCheckAccessLink(id: String, completion: @escaping (AverCheckAccessLinkResponse?, Error?) -> ()){
        self.refreshAuth() { res, err in
            if(err != nil){
                completion(nil, err)
            }
        }
        
        self.api.createCheckAccessLink(token: self.token!, id: id) { res, err in
            completion(res, err)
        }
    }
    
    public func getCheckById(id: String, completion: @escaping (AverCheckDetailResponse?, Error?) -> ()){
        self.refreshAuth() { res, err in
            if(err != nil){
                completion(nil, err)
            }
        }
        
        self.api.getCheckById(token: self.token!, id: id) { res, err in
            completion(res, err)
        }
    }
    
    public func getCheckByThirdPartyIdentifier(thirdPartyIdentifier: String, all: Bool? = true, completion: @escaping (AverCheckDetailResponse?, Error?) -> ()){
        self.refreshAuth() { res, err in
            if(err != nil){
                completion(nil, err)
            }
        }
        
        self.api.getCheckByThirdPartyIdentifier(token: self.token!, thirdPartyIdentifier: thirdPartyIdentifier, all: all!) { res, err in
            completion(res, err)
        }
    }
    
    public func getCheckResults(id: String, completion: @escaping (AverCheckDetailResponse?, Error?) -> ()){
        self.refreshAuth() { res, err in
            if(err != nil){
                completion(nil, err)
            }
        }
        
        self.api.getCheckResults(token: self.token!, id: id) { res, err in
            completion(res, err)
        }
    }
}
