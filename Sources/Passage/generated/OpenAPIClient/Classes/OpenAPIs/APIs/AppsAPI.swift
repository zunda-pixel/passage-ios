//
// AppsAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class AppsAPI {

    /**
     Get App
     
     - parameter appId: (path) App ID 
     - returns: GetAppResponse
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func getApp(appId: String) async throws -> GetAppResponse {
        return try await getAppWithRequestBuilder(appId: appId).execute().body
    }

    /**
     Get App
     - GET /apps/{app_id}
     - Get information about an application.
     - parameter appId: (path) App ID 
     - returns: RequestBuilder<GetAppResponse> 
     */
    open class func getAppWithRequestBuilder(appId: String) -> RequestBuilder<GetAppResponse> {
        var localVariablePath = "/apps/{app_id}"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<GetAppResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: false)
    }
}