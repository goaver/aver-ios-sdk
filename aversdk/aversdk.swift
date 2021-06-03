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
    }
    
    public func auth(key: String, secret: String) -> Result<String?, Error> {
        let result: Result<String?, Error>
        let res = self.api.getAuthToken(key: key, secret: secret)
        switch res {
            case .success(let auth):
                print("aversdk:auth:" + auth!.token)
                self.token = auth!.token
                result = .success(auth!.token)
            case .failure(let error):
                result = .failure(error)
        }
        return result
    }
    
    private func refreshAuth() -> Result<String?,Error> {
        let result: Result<String?, Error>
        result = .success(self.token!)
        //TODO: publish test API to prod for this to work
        //let res = self.api.refreshAuthToken(token: self.token!)
        //switch res {
        //    case .success(let auth):
        //        print("Auth refresh: " + auth!.token)
        //        result = .success(auth!.token)
        //    case .failure(let error):
        //        result = .failure(error)
        //}
        return result
    }
    
    public func createCheck(options: AverCheckCreateRequest) throws -> Result<AverCheckCreateResponse?, Error> {
        let refresh = self.refreshAuth()
        let token = try refresh.get()

        return self.api.createCheck(token: token!, options: options)
    }
    
    public func getCheckAccessLink(id: String) throws -> Result<AverCheckAccessLinkResponse?, Error> {
        let refresh = self.refreshAuth()
        let token = try refresh.get()

        return self.api.getCheckAccessLink(token: token!, id: id)
    }
    
    public func getCheckById(id: String) throws -> Result<AverCheckDetailResponse?, Error> {
        let refresh = self.refreshAuth()
        let token = try refresh.get()

        return self.api.getCheckById(token: token!, id: id)
    }
    
    public func getCheckByThirdPartyIdentifier(id: String) throws -> Result<AverCheckDetailResponse?, Error> {
        let refresh = self.refreshAuth()
        let token = try refresh.get()

        return self.api.getCheckByThirdPartyIdentifier(token: token!, id: id)
    }
    
    public func getCheckResults(id: String) throws -> Result<AverCheckDetailResponse?, Error> {
        let refresh = self.refreshAuth()
        let token = try refresh.get()

        return self.api.getCheckResults(token: token!, id: id)
    }
    
    public func createWatchlistSearch(options: AverWatchlistSearchRequest) throws -> Result<AverWatchlistSearchResponse?, Error>{
        let refresh = self.refreshAuth()
        let token = try refresh.get()

        return self.api.createWatchlistSearch(token: token!, options: options)
    }
    
    public func getWatchlistSearchById(id: String) throws -> Result<AverWatchlistSearchResults?, Error>{
        let refresh = self.refreshAuth()
        let token = try refresh.get()

        return self.api.getWatchlistSearchById(token: token!, id: id)
    }
    
    public func getWatchlistSearchByCheckId(id: String) throws -> Result<AverWatchlistSearchResults?, Error> {
        let refresh = self.refreshAuth()
        let token = try refresh.get()

        return self.api.getWatchlistSearchByCheckId(token: token!, id: id)
    }
    
    public func getWatchlistSearchResults(id: String) throws -> Result<AverWatchlistSearchResults?, Error> {
        let refresh = self.refreshAuth()
        let token = try refresh.get()

        return self.api.getWatchlistSearchResults(token: token!, id: id)
    }
}
