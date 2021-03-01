//
//  APIProvider.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 24/02/21.
//

import Foundation

protocol Provider: class {
    func request<T: Decodable>(for endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void)
}

final class APIProvider: Provider {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(for endpoint: APIEndpoint,
                               completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let url = try endpoint.makeUrl()

            session.dataTask(with: url) { (data, _, error) in
                guard let data = data else {
                    let newError = error == nil ? APIError.invalidData : error!
                    completion(.failure(newError))
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let model = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}


/*
 
 "photo":[
    {
        "id":"50977177098",
        "owner":"135511057@N03",
        "secret":"6ab460483e",
        "server":"65535",
        "farm":66,
        "title":"Alex Top & Panties @ The Grand Event",
        "ispublic":1,
        "isfriend":0,
        "isfamily":0
    },
    {
        "id":"50976874588",
        "owner":"188354212@N04",
        "secret":"cdc378c142",
        "server":"65535",
        "farm":66,
        "title":"~40~ \u028f\u1d0f\u1d1c'\u029f\u029f \u0274\u1d07\u1d20\u1d07\u0280 \u1d1b\u1d00\u1d0b\u1d07 \u1d1cs \u1d00\u029f\u026a\u1d20\u1d07",
        "ispublic":1,
        "isfriend":0,
        "isfamily":0
    },
    {
        "id":"50977652947",
        "owner":"188354212@N04",
        "secret":"057dbbab93",
        "server":"65535",
        "farm":66,
        "title":"~39~ \u0299\u1d07\u1d07\u0274 \u026a\u0274 \u1d1b\u029c\u1d07 \u0262\u1d00\u1d0d\u1d07 s\u026ax, s\u1d07\u1d20\u1d07\u0274, \u1d07\u026a\u0262\u029c\u1d1b, \u0274\u026a\u0274\u1d07 \u028f\u1d07\u1d00\u0280s",
        "ispublic":1,
        "isfriend":0,
        "isfamily":0
    },
    {
        "id":"50977400101",
        "owner":"146782440@N04",
        "secret":"a0a9f60d90",
        "server":"65535",
        "farm":66,
        "title":"For Lola,a great friend 03.07.18",
        "ispublic":1,
        "isfriend":0,
        "isfamily":0
    },
    {
        "id":"50977498092",
        "owner":"184307436@N07",
        "secret":"f46c62f352",
        "server":"65535",
        "farm":66,
        "title":"Copper Incognito",
        "ispublic":1,
        "isfriend":0,
        "isfamily":0
    },
    {
        "id":"50976382953",
        "owner":"157119750@N04",
        "secret":"60f51630b1",
        "server":"65535",
        "farm":66,
        "title":"When life gives you lemons... and oranges, make citrus sangria :D",
        "ispublic":1,
        "isfriend":0,
        "isfamily":0
    },
    {
        "id":"50977124117",
        "owner":"192233931@N08",
        "secret":"8b4480a6c5",
        "server":"65535",
        "farm":66,
        "title":"HEX HEX",
        "ispublic":1,
        "isfriend":0,
        "isfamily":0
    },
    {
        "id":"50977123707",
        "owner":"192233931@N08",
        "secret":"157e1ba498",
        "server":"65535",
        "farm":66,
        "title":"Schlafender Kater",
        "ispublic":1,
        "isfriend":0,
        "isfamily":0
    }]}
 
 
 
 
 */
