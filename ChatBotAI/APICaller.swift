//
//  APICaller.swift
//  ChatBotAI
//
//  Created by Youssef Bhl on 20/12/2022.
//

import Foundation
import OpenAISwift

final class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    private var client: OpenAISwift?
    
    @frozen enum Constants {
        static let key = "sk-cofV4PqhKxtmH6yD8XgqT3B1bkFJpMoT67 cOP5RXOgMUWL"
    }
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void) {
            client?.sendCompletion(with: input, completionHandler: { result in
                switch result {
                case .success(let model):
                    let output = model.choices.first?.text ?? ""
                    completion(.success(output))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
    }
    
}
