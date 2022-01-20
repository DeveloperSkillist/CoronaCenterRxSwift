//
//  CenterNetwork.swift
//  FindCoronaCenterRxSwift
//
//  Created by skillist on 2022/01/19.
//

import RxSwift
import Foundation

class CenterNetwork {
    private let session: URLSession
    let api = CenterAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCenters() -> Single<Result<CenterAPIResponse, URLError>> {
        guard let url = api.getCenterListComponents().url else {
            return .just(.failure(URLError(.badURL)))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Infuser \(APIKey.key)", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let centerAPIResponse = try JSONDecoder().decode(CenterAPIResponse.self, from: data)
                    return .success(centerAPIResponse)
                } catch {
                    return .failure(URLError(.cannotParseResponse))
                }
            }
            .catch { _ in
                .just(.failure(URLError(.cannotLoadFromNetwork)))
            }
            .asSingle()
    }
}
