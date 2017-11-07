//
//  StringExtensions.swift
//  instame
//
//  Created by Miles Alden on 11/6/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import Foundation


// Make strings conform to ErrorType
extension String : Error {}
extension String {
    
    
    /**
     Sugar to calculate range
     @return NSRange for this string
     */
    public var range : NSRange {
        return NSRange(location: 0, length: self.characters.count);
    }
    
    /**
     Sugar for regular expression match on String objects.
     @param regex Regular expression string
     @return [String]
     */
    public func match ( _ regex : String ) -> [String] {
        
        do {
            
            let r : NSRegularExpression = try NSRegularExpression(pattern: regex, options: NSRegularExpression.Options.caseInsensitive)
            let matches : [NSTextCheckingResult] = r.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue:0), range: self.range);
            
            return matches.map { NSString(string:self).substring(with: $0.range)  }
            
        } catch let error {
            
            print("Could not run regex match : \(error)");
        }
        
        return [];
        
    }
    
    
}
