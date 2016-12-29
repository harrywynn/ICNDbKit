//
//  ICNDbKit.swift
//
//  Copyright (c) 2016 Harry J Wynn IV
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public class ICNDbKit {
    public typealias ChuckNorrisJokes = (_ array: Array<Dictionary<String, AnyObject>>?) -> Void
    public typealias ChuckNorrisList = (_ array: Array<String>?) -> Void
    public typealias ChuckNorrisNumber = (_ int: Int?) -> Void
    
    
    /**
     Fetches an `Array` of random jokes.
     - parameter completion:  The completion handler, returns an an `Array` of jokes
     */
    public static func fetchRandomJoke(completion: @escaping ChuckNorrisJokes) {
        fetchRandomJoke(count: nil, categories: nil, firstName: nil, lastName: nil, completion: completion)
    }
    
    /**
     Fetches an `Array` of random jokes.
     - parameter count: the number of jokes to fetch
     - parameter completion:  The completion handler, returns an an `Array` of jokes
     */
    public static func fetchRandomJoke(count: Int?, completion: @escaping ChuckNorrisJokes) {
        fetchRandomJoke(count: count, categories: nil, firstName: nil, lastName: nil, completion: completion)
    }
    
    /**
     Fetches an `Array` of random jokes.
     - parameter count: the number of jokes to fetch
     - parameter categories: categories to restrict the jokes
     - parameter completion:  The completion handler, returns an an `Array` of jokes
     */
    public static func fetchRandomJoke(count: Int?, categories: Array<String>?, completion: @escaping ChuckNorrisJokes) {
        fetchRandomJoke(count: count, categories: categories, firstName: nil, lastName: nil, completion: completion)
    }
    
    /**
     Fetches an `Array` of random jokes.
     - parameter count: the number of jokes to fetch
     - parameter categories: categories to restrict the jokes
     - parameter firstName: string to replace the first name in the jokes
     - parameter lastName: string to replace the last name in the jokes
     - parameter completion:  The completion handler, returns an an `Array` of jokes
     */
    public static func fetchRandomJoke(count: Int?, categories: Array<String>?, firstName: String?, lastName: String?, completion: @escaping ChuckNorrisJokes) {
        var get = "http://api.icndb.com/jokes/random"

        // get more than 1 joke
        if (count != nil && count! > 1) {
            get += "/\(count!)"
        }
        
        // appending query string
        if (categories != nil || firstName != nil || lastName != nil) {
            get += "?"
        }
        
        // limit it to certain categories
        if (categories != nil) {
            get += "limitTo=[\(categories!.joined())]&"
        }

        // replace first name (Chuck) in joke
        if (firstName != nil) {
            get += "firstName=\(firstName!)&"
        }
        
        // replace last name (Norris) in joke
        if (lastName != nil) {
            get += "lastName=\(lastName!)&"
        }
        
        
        let request = NSMutableURLRequest(url:NSURL(string: get) as! URL)
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            let res = response as! HTTPURLResponse
            
            // check for success
            if (error == nil && res.statusCode == 200) {
                do {
                    // load as json
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, AnyObject>
                    
                    // more than one joke will already be an array
                    if let jokes = jsonObject["value"] as? Array<Dictionary<String, AnyObject>> {
                        completion(jokes)
                    } else {
                        // single joke comes back as just a dictionary, so put in an array
                        var jokes = Array<Dictionary<String, AnyObject>>()
                        jokes.append(jsonObject["value"] as! Dictionary<String, AnyObject>)
                        completion(jokes)
                    }
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        });
        
        dataTask.resume()
    }
    
    /**
     Fetches all of the available joke categories.
     - parameter id: the joke to fetch
     - parameter completion:  The completion handler, returns an an `Array` of jokes
     */
    public static func fetchJoke(id: Int, completion: @escaping ChuckNorrisJokes) {
        let get = "http://api.icndb.com/jokes/\(id)"
        
        let request = NSMutableURLRequest(url:NSURL(string: get) as! URL)
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            let res = response as! HTTPURLResponse
            
            // check for success
            if (error == nil && res.statusCode == 200) {
                do {
                    // load as json
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, AnyObject>
                    var jokes = Array<Dictionary<String, AnyObject>>()
                    jokes.append(jsonObject["value"] as! Dictionary<String, AnyObject>)
                    completion(jokes)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        });
        
        dataTask.resume()
    }
    
    /**
     Fetches the total number of available jokes.
     - parameter completion:  The completion handler, returns an `Int` with the count
     */
    public static func fetchJokeCount(completion: @escaping ChuckNorrisNumber) {
        let get = "http://api.icndb.com/jokes/count"
        
        let request = NSMutableURLRequest(url:NSURL(string: get) as! URL)
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            let res = response as! HTTPURLResponse
            
            // check for success
            if (error == nil && res.statusCode == 200) {
                do {
                    // load as json
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, AnyObject>
                    let count = jsonObject["value"] as! Int
                    completion(count)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        });
        
        dataTask.resume()
    }

    /**
     Fetches all of the available joke categories.
     - parameter completion:  The completion handler, returns an `Array` of categories
     */
    public static func fetchJokeCategories(completion: @escaping ChuckNorrisList) {
        let get = "http://api.icndb.com/categories"
        
        let request = NSMutableURLRequest(url:NSURL(string: get) as! URL)
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            let res = response as! HTTPURLResponse
            
            // check for success
            if (error == nil && res.statusCode == 200) {
                do {
                    // load as json
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, AnyObject>
                    let categories = jsonObject["value"] as! Array<String>
                    completion(categories)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        });
        
        dataTask.resume()
    }
}
