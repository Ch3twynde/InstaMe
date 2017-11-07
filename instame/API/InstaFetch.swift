//
//  InstaFetch.swift
//  instame
//
//  Created by Miles Alden on 11/6/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import Foundation
import UIKit

typealias FetchSuccess = (Any) -> Void
typealias FetchError = (String) -> Void

open class InstaFetch {
    
    var successCallback :FetchSuccess?
    var errorCallback : FetchError?
    
    init () {}
    
    
    func success(closure:@escaping FetchSuccess) -> Self {
        self.successCallback = closure
        return self
    }
    
    func error(closure:@escaping FetchError) {
        self.errorCallback = closure
    }
    
    
    /**
     Post some url async and invoke success / failure callbacks
     upon completion.
     @param url URL object to fetch
     */
    open func post ( _ url : URL ) -> InstaFetch {
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: req) { (data : Data?, res : URLResponse?, error : Error?) in
            
            guard error == nil
                else {
                    print ("Some error occurred : \(error!)")
                    if let errorCallback = self.errorCallback {
                        errorCallback( String(describing:error!) )
                    }
                    return
            }
            
            guard let d = data
                else {
                    print ("Data was not received.")
                    if let errorCallback = self.errorCallback {
                        errorCallback( "Data was not received." )
                    }
                    return
            }
            
            // Convert json to collection
            let jsonString = String( data : d, encoding : .utf8 )!
            guard let jsonObj = self.collection(fromJson: jsonString)
                else {
                    print("Failed to serialize json to object.")
                    if let errorCallback = self.errorCallback {
                        errorCallback( "Failed to serialize json to object." )
                    }
                    return
            }
            
            // Invoke callback
            if let success = self.successCallback {
                success ( jsonObj )
            }
            
            }.resume()
        
        return self
    }
    
    /**
     Del some url async and invoke success / failure callbacks
     upon completion.
     @param url URL object to fetch
     */
    open func delete ( _ url : URL ) -> InstaFetch {
        
        var req = URLRequest(url: url)
        req.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: req) { (data : Data?, res : URLResponse?, error : Error?) in
            
            guard error == nil
                else {
                    print ("Some error occurred : \(error!)")
                    if let errorCallback = self.errorCallback {
                        errorCallback( String(describing:error!) )
                    }
                    return
            }
            
            guard let d = data
                else {
                    print ("Data was not received.")
                    if let errorCallback = self.errorCallback {
                        errorCallback( "Data was not received." )
                    }
                    return
            }
            
            // Convert json to collection
            let jsonString = String( data : d, encoding : .utf8 )!
            guard let jsonObj = self.collection(fromJson: jsonString)
                else {
                    print("Failed to serialize json to object.")
                    if let errorCallback = self.errorCallback {
                        errorCallback( "Failed to serialize json to object." )
                    }
                    return
            }
            
            // Invoke callback
            if let success = self.successCallback {
                success ( jsonObj )
            }
            
            }.resume()
        
        return self
    }
    
    
    /**
     Fetch some url async and invoke success / failure callbacks
     upon completion.
     @param url URL object to fetch
     */
    open func fetch ( _ url : URL ) -> InstaFetch {
        
        URLSession.shared.dataTask(with: url) { (data : Data?, res : URLResponse?, error : Error?) in
            
            guard error == nil
                else {
                    print ("Some error occurred : \(error!)")
                    if let errorCallback = self.errorCallback {
                        errorCallback( String(describing:error!) )
                    }
                    return
            }
            
            guard let d = data
                else {
                    print ("Data was not received.")
                    if let errorCallback = self.errorCallback {
                        errorCallback( "Data was not received." )
                    }
                    return
            }
            
            // Convert response data to text
            guard let text = String(data : d, encoding : .utf8)
                else {
                    print("Failed to create text from data")
                    if let errorCallback = self.errorCallback {
                        errorCallback( "Failed to create text from data." )
                    }
                    return
            }
            
            // Invoke callback
            if let success = self.successCallback {
                success ( text )
            }
            
        }.resume()
        
        return self
    }
    
    
    /**
     Fetch some url async and invoke success / failure callbacks
     upon completion.
     Expects an image as response
     @param url URL object to fetch
     */
    open func fetchImage ( _ url : URL ) -> InstaFetch {
        
        URLSession.shared.dataTask(with: url) { (data : Data?, res : URLResponse?, error : Error?) in
            
            guard error == nil
                else {
                    print ("Some error occurred : \(error!)")
                    if let errorCallback = self.errorCallback {
                        errorCallback( String(describing:error!) )
                    }
                    return
            }
            
            guard let d = data
                else {
                    print ("Data was not received.")
                    if let errorCallback = self.errorCallback {
                        errorCallback( "Data was not received." )
                    }
                    return
            }
            
            // Convert json to collection
            let responseData = d
            guard let image = UIImage(data:d)
                else {
                    print("Failed to create image from data.")
                    if let errorCallback = self.errorCallback {
                        errorCallback( "Failed to create image from data." )
                    }
                    return
            }
            
            // Invoke callback
            if let success = self.successCallback {
                success ( image )
            }
            
        }.resume()
        
        return self
    }
    
    
    /**
     Fetch some url async and invoke success / failure callbacks
     upon completion.
     Expected response to be json
     @param url URL object to fetch
     */
    open func jsonFetch ( _ url : URL ) -> InstaFetch {
     
        URLSession.shared.dataTask(with: url) { (data : Data?, res : URLResponse?, error : Error?) in
            
            guard error == nil
                else {
                    print ("Some error occurred : \(error!)")
                    if let errorCallback = self.errorCallback {
                        errorCallback( String(describing:error!) )
                    }
                    return
            }
            
            guard let d = data
                else {
                    print ("Data was not received.")
                    if let errorCallback = self.errorCallback {
                        errorCallback( "Data was not received." )
                    }
                    return
            }
            
            // Convert json to collection
            let jsonString = String( data : d, encoding : .utf8 )!
            guard let jsonObj = self.collection(fromJson: jsonString)
                else {
                    print("Failed to serialize json to object.")
                    if let errorCallback = self.errorCallback {
                        errorCallback( "Failed to serialize json to object." )
                    }
                    return
            }
            
            // Invoke callback
            if let success = self.successCallback {
                success ( jsonObj )
            }
            
        }.resume()
        
        return self
    }
    
    open func collection ( fromJson json : String ) -> [String:Any]? {
        
        // Json string, convert
        guard let jsonData = json.data(using: .utf8)
            else {
                print("String could not be converted to Data object. Could not create collection.")
                return nil
        }
        
        
        do {
            
            // Serialize data
            guard let serialized = try JSONSerialization.jsonObject(with: jsonData, options: [] ) as? [String:Any]
                else {
                    print("User json could not be represented as expected type : [String:Any]")
                    return nil
            }
            
            return serialized
            
        } catch let error {
            
            print("Could not create collection elements from json object : \(error)")
        }
        
        // Failed
        return nil
    }
}
