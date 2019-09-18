//
//  NetworkCore.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 08/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import ObjectMapper
import RxSwift
import SwiftyJSON

final class NetworkCore<T: ImmutableMappable> {
    fileprivate let endPoint: String
    fileprivate let scheduler: MainScheduler
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = MainScheduler.instance
    }
    
    // MARK: - Get
    func getItems(_ path: String, parameters: [String: Any] = [:], headers: [String: String]? = [:]) -> Observable<[T]> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeSimpleArrayRequest(method:.get, url: url, parameters: parameters, headers: headers)
    }
    
    func getItems(_ path: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<[T]>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeArrayMetadataRequest(method: .get, url: url, parameters: parameters, headers: headers)
    }
    func getItem(_ path: String, nxtUrl: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<[T]>> {
        let _query = nxtUrl.split(separator: "?")[1].description
        var url = "\(endPoint)/\(path)?\(_query)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeArrayMetadataRequest(method: .get, url: url, parameters: parameters, headers: headers)
    }
    func getItemsJson(_ path: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<[String: Any]>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeJsonRequest(method: .get, url: url, parameters: parameters, headers: headers)
    }
    
    func getItem(_ path: String, itemId: String, parameters: [String: String], headers: [String: String]? = [:]) -> Observable<T> {
        var url = "\(endPoint)/\(path)/\(itemId)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeSimpleRequest(method: .get, url: url, parameters: parameters, headers: headers)
    }
    
    func getItem(_ path: String, parameters: [String: String], headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeMetadataRequest(method: .get, url: url, parameters: parameters, headers: headers)
    }
    
    func getItems(_ path: String, query: String, headers: [String: String]? = [:]) -> Observable<Metadata<[T]>> {
        var url = "\(endPoint)/\(path)?\(query)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeArrayMetadataRequest(method: .get, url: url, parameters: nil, headers: headers)
    }
    
    func getStringItems(_ path: String, headers: [String: String]? = [:]) -> Observable<Metadata<[String]>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeArrayStringMetadataRequest(method: .get, url: url, parameters: [:], headers: headers)
    }
    func getStringItem(_ path: String, headers: [String: String]? = [:]) -> Observable<Metadata<String>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeStringMetadataRequest(method: .get, url: url, parameters: [:], headers: headers)
    }
    func getIntItem(_ path: String, headers: [String: String]? = [:]) -> Observable<Metadata<Int>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeIntMetadataRequest(method: .get, url: url, parameters: [:], headers: headers)
    }
    func getItem(_ path: String, query: String, headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        var url = "\(endPoint)/\(path)?\(query)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeMetadataRequest(method: .get, url: url, parameters: nil, headers: headers)
    }
    func getItem(_ path: String, headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeMetadataRequest(method: .get, url: url, parameters: nil, headers: headers)
    }
    
    // MARK: - Post
    func postItem(_ path: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<T> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeSimpleRequest(method: .patch, url: url, parameters: parameters, headers: headers)
    }
    func postItem(_ path: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeMetadataRequest(method: .post, url: url, parameters: parameters, encoding: JSONEncoding(options: .prettyPrinted), headers: headers)
    }
    func postStringItem(_ path: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<String>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeStringMetadataRequest(method: .post, url: url, parameters: parameters, encoding: JSONEncoding(options: .prettyPrinted), headers: headers)
    }
    
    func postItemJson(_ path: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<[String: Any]>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeJsonRequest(method: .post, url: url, parameters: parameters, headers: headers)
    }
    
    func patchItem(_ path: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<T> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeSimpleRequest(method: .patch, url: url, parameters: parameters, headers: headers)
    }
    
    func patchItem(_ path: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeMetadataRequest(method: .patch, url: url, parameters: parameters, headers: headers)
    }
    
    func patchItemJson(_ path: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<[String: Any]>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeJsonRequest(method: .patch, url: url, parameters: parameters, headers: headers)
    }
    
    // MARK: - Update
    func updateItem(_ path: String, itemId: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<T> {
        var url = "\(endPoint)/\(path)/\(itemId)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeSimpleRequest(method: .put, url: url, parameters: parameters, headers: headers)
    }
    
    func updateItem(_ path: String, itemId: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        var url = "\(endPoint)/\(path)/\(itemId)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeMetadataRequest(method: .put, url: url, parameters: parameters, encoding: JSONEncoding(options: .prettyPrinted), headers: headers)
    }
    
    func updateItem(_ path: String, itemId: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<[String: Any]>> {
        var url = "\(endPoint)/\(path)/\(itemId)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeJsonRequest(method: .put, url: url, parameters: parameters, headers: headers)
    }
    func updateItem(_ path: String, parameters: [String: Any], headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeMetadataRequest(method: .put, url: url, parameters: parameters, encoding: JSONEncoding(options: .prettyPrinted),  headers: headers)
    }
    
    // MARK: - Delete
    func deleteItem(_ path: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        var url = "\(endPoint)/\(path)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeMetadataRequest(method: .delete, url: url, parameters: parameters, headers: headers)
    }
    
    func deleteItem(_ path: String, itemId: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        var url = "\(endPoint)/\(path)/\(itemId)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeMetadataRequest(method: .delete, url: url, parameters: parameters, headers: headers)
    }
    
    func deleteItem(_ path: String, itemId: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<T> {
        var url = "\(endPoint)/\(path)/\(itemId)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeSimpleRequest(method: .delete, url: url, parameters: parameters, headers: headers)
    }
    
    func deleteItemJson(_ path: String, itemId: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<Metadata<[String: Any]>> {
        var url = "\(endPoint)/\(path)/\(itemId)"
        url = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url
        return makeJsonRequest(method: .delete, url: url, parameters: parameters, headers: headers)
    }
}

extension NetworkCore {
    fileprivate func makeSimpleRequest(method: HTTPMethod, url: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<T> {
        return RxAlamofire.requestData(method, url,
                                       parameters: parameters,
                                       headers: headers)
            .debug()
            .observeOn(scheduler)
            .map(processData)
    }
    fileprivate func makeSimpleArrayRequest(method: HTTPMethod, url: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<[T]> {
        return RxAlamofire.requestData(method, url,
                                       parameters: parameters,
                                       headers: headers)
            .debug()
            .observeOn(scheduler)
            .map(processDataArr)
    }
    fileprivate func makeMetadataRequest(method: HTTPMethod, url: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        return RxAlamofire.requestData(method, url,
                                       parameters: parameters,
                                       headers: headers)
            .debug()
            .observeOn(scheduler)
            .map(processDataWithMetadata)
    }
    fileprivate func makeArrayMetadataRequest(method: HTTPMethod, url: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<Metadata<[T]>> {
        return RxAlamofire.requestData(method, url,
                                       parameters: parameters,
                                       headers: headers)
            .debug()
            .observeOn(scheduler)
            .map(processDataWithMetadataArr)
    }
    fileprivate func makeArrayStringMetadataRequest(method: HTTPMethod, url: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<Metadata<[String]>> {
        return RxAlamofire.requestData(method, url,
                                       parameters: parameters,
                                       headers: headers)
            .debug()
            .observeOn(scheduler)
            .map(processDataWithMetaStringArr)
    }
    fileprivate func makeStringMetadataRequest(method: HTTPMethod, url: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<Metadata<String>> {
        return RxAlamofire.requestData(method, url,
                                       parameters: parameters,
                                       headers: headers)
            .debug()
            .observeOn(scheduler)
            .map(processDataWithMetaString)
    }
    fileprivate func makeStringMetadataRequest(method: HTTPMethod, url: String, parameters: [String: Any]?, encoding: ParameterEncoding, headers: [String: String]? = [:]) -> Observable<Metadata<String>> {
        return RxAlamofire.requestData(method, url,
                                       parameters: parameters,
                                       encoding: encoding,
                                       headers: headers)
            .debug()
            .observeOn(scheduler)
            .map(processDataWithMetaString)
    }
    fileprivate func makeIntMetadataRequest(method: HTTPMethod, url: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<Metadata<Int>> {
        return RxAlamofire.requestData(method, url,
                                       parameters: parameters,
                                       headers: headers)
            .debug()
            .observeOn(scheduler)
            .map(processDataWithMetaInt)
    }
    fileprivate func makeJsonRequest(method: HTTPMethod, url: String, parameters: [String: Any]?, headers: [String: String]? = [:]) -> Observable<Metadata<[String: Any]>> {
        return RxAlamofire.requestData(method, url,
                                       parameters: parameters,
                                       headers: headers)
            .debug()
            .observeOn(scheduler)
            .map(processDataAnyMetaJSON)
    }
    fileprivate func makeMetadataRequest(method: HTTPMethod, url: String, parameters: [String: Any]?, encoding: ParameterEncoding, headers: [String: String]? = [:]) -> Observable<Metadata<T>> {
        return RxAlamofire.requestData(method, url,
                                       parameters: parameters,
                                       encoding: encoding,
                                       headers: headers)
            .debug()
            .observeOn(scheduler)
            .map(processDataWithMetadata)
    }
}

extension NetworkCore {
    fileprivate func processData(response: HTTPURLResponse, data: Data) throws -> T {
        debugPrint(try JSON(data: data))
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        if response.statusCode >= 304 {
            throw NSError(
                domain: (response.url?.absoluteString ?? ""),
                code: response.statusCode,
                userInfo: [NSLocalizedDescriptionKey: (json["error"] as? [String: String])?.first?.value ?? json]
            )
        }
        let jsonData = try JSONSerialization.data(withJSONObject: json["data"] ?? json, options: [])
        guard let jsonSingle = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        return  try Mapper<T>().map(JSON: jsonSingle)
    }
    fileprivate func processDataArr(response: HTTPURLResponse, data: Data) throws -> [T] {
        debugPrint(try JSON(data: data))
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        if response.statusCode >= 304 {
            throw NSError(
                domain: (response.url?.absoluteString ?? ""),
                code: response.statusCode,
                userInfo: [NSLocalizedDescriptionKey: (json["error"] as? [String: String])?.first?.value ?? json]
            )
        }
        let arrData = try JSONSerialization.data(withJSONObject: json["data"] ?? json, options: [])
        guard let arrJSON = try JSONSerialization.jsonObject(with: arrData, options: []) as? [[String: Any]] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        return try Mapper<T>().mapArray(JSONArray: arrJSON)
    }
    fileprivate func processDataWithMetadata(response: HTTPURLResponse, data: Data) throws -> Metadata<T> {
        debugPrint(try JSON(data: data))
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        if response.statusCode >= 304 {
            throw NSError(
                domain: (response.url?.absoluteString ?? ""),
                code: response.statusCode,
                userInfo: [NSLocalizedDescriptionKey: (json["error"] as? [String: String])?.first?.value ?? json]
            )
        }
        var details = try Mapper<Metadata<T>>().map(JSON: json)
        if details.results == nil, let jsonData = json["results"] as? [String: Any] {
            details.results = Mapper<T>().map(JSON: jsonData)
        }
        return details
    }
    fileprivate func processDataWithMetadataArr(response: HTTPURLResponse, data: Data) throws -> Metadata<[T]> {
        debugPrint(try JSON(data: data))
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        if response.statusCode >= 304 {
            throw NSError(
                domain: (response.url?.absoluteString ?? ""),
                code: response.statusCode,
                userInfo: [NSLocalizedDescriptionKey: (json["error"] as? [String: String])?.first?.value ?? json]
            )
        }
        var details = try Mapper<Metadata<[T]>>().map(JSON: json)
        let arrData = try JSONSerialization.data(withJSONObject: json["results"] ?? json, options: [])
        guard let arrJSON = try JSONSerialization.jsonObject(with: arrData, options: []) as? [[String: Any]] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        details.results = try Mapper<T>().mapArray(JSONArray: arrJSON)
        return details
    }
    fileprivate func processDataWithMetaStringArr(response: HTTPURLResponse, data: Data) throws -> Metadata<[String]> {
        debugPrint(try JSON(data: data))
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        if response.statusCode >= 304 {
            throw NSError(
                domain: (response.url?.absoluteString ?? ""),
                code: response.statusCode,
                userInfo: [NSLocalizedDescriptionKey: (json["error"] as? [String: String])?.first?.value ?? json]
            )
        }
        let details = try Mapper<Metadata<[String]>>().map(JSON: json)
        return details
    }
    fileprivate func processDataWithMetaString(response: HTTPURLResponse, data: Data) throws -> Metadata<String> {
        debugPrint(try JSON(data: data))
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        if response.statusCode >= 304 {
            throw NSError(
                domain: (response.url?.absoluteString ?? ""),
                code: response.statusCode,
                userInfo: [NSLocalizedDescriptionKey: (json["error"] as? [String: String])?.first?.value ?? json]
            )
        }
        let details = try Mapper<Metadata<String>>().map(JSON: json)
        return details
    }
    fileprivate func processDataWithMetaInt(response: HTTPURLResponse, data: Data) throws -> Metadata<Int> {
        debugPrint(try JSON(data: data))
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        if response.statusCode >= 304 {
            throw NSError(
                domain: (response.url?.absoluteString ?? ""),
                code: response.statusCode,
                userInfo: [NSLocalizedDescriptionKey: (json["error"] as? [String: String])?.first?.value ?? json]
            )
        }
        let details = try Mapper<Metadata<Int>>().map(JSON: json)
        return details
    }
    fileprivate func processDataAnyMetaJSON(response: HTTPURLResponse, data: Data) throws -> Metadata<[String: Any]> {
        debugPrint(try JSON(data: data))
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
            )
        }
        if response.statusCode >= 304 {
            throw NSError(
                domain: (response.url?.absoluteString ?? ""),
                code: response.statusCode,
                userInfo: [NSLocalizedDescriptionKey: (json["error"] as? [String: String])?.first?.value ?? json]
            )
        }
        return try Mapper<Metadata<[String: Any]>>().map(JSON: json)
    }
}
