//
//  RequestService.swift
//  CodingTest_Infosys
//
//  Created by Niranjan on 03/07/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//
import Foundation

 enum NetworkError: Error {
    case domainError
    case decodingError
}
final class RequestService {
       let movieUrl = AppConstants.serverPath+AppConstants.factsPath
       let defaultSession = URLSession(configuration: .default)
       var dataTask: URLSessionDataTask?
       var errorMessage = ""
    func loadData(completion: @escaping (Result<FeedsModel, ErrorResult>) -> Void) {
         dataTask?.cancel()
        guard let url = URL(string: movieUrl) else { return }
        let request = RequestFactory.request(method: .GET, url: url)
              let task = defaultSession.dataTask(with: request) { (data, _, error) in
                  if let error = error {
                    self.errorMessage += AppConstants.dataError + error.localizedDescription
                    completion(.failure(.network(string: AppConstants.requestError + error.localizedDescription)))
                      return
                  } else {
                    if let data = data {
                    let value = FeedsModel.parseObject(data: data)
                    completion(value) }
                }
           }
        task.resume()
    }
}
