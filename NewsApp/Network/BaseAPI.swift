//
//  BaseAPI.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import Foundation
import Alamofire

class BaseAPI {

    static let shared = BaseAPI()

    let baseURL: String = "https://newsapi.org/v2/"
  //let APIKey: String = "4c093a7a33b54fa2afac38ae8358c15e"
    let APIKey: String = "90f78b5e459f4557a6d285161db89387"

    private func networkIsReachable() ->  Bool {
        let networkManager = NetworkReachabilityManager()
        let result = networkManager?.isReachable
        return result~
    }

    private func getURLPath(apiType: URLType, searchedText: String?, page: Int) -> URL? {
        switch apiType {
        case .topHeadlines:
            return URL(string: baseURL + "top-headlines?country=tr" + "&page=\(page)" + "&apiKey=\(APIKey)")
        case .searchedNews:
            let str = baseURL + "everything?q=\(searchedText~)" + "&sortBy=publishedAt" + "&page=\(page)" + "&apiKey=\(APIKey)"
            let urlString = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            return URL(string: urlString)
        }
    }

    func request<S: Codable>(methodType: HTTPMethod,
                             apiType: URLType,
                             searchedText: String? = nil,
                             page: Int? = 1,
                             succeed: @escaping (S) -> Void,
                             failed: @escaping (serviceErrors) -> Void) {

        if networkIsReachable() {
            guard let url = getURLPath(apiType: apiType, searchedText: searchedText, page: page ?? 1) else {
                failed(.urlError)
                return
            }
            AF.request(url, method: methodType).responseDecodable(of: S.self) { response in
                if let error = response.error {
                    print("Webservice Error " + "\(error)")
                    failed(.apiError)
                } else {
                    if let value = response.value {
                        succeed(value)
                    } else {
                        failed(.valueError)
                    }
                }
            }
        } else {
            failed(.internetError)
            return
        }
    }
}
