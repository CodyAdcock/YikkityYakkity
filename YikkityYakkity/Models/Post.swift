//
//  Post.swift
//  YikkityYakkity
//
//  Created by Cody on 4/11/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import Foundation
import CloudKit

class Post {
    
    let text: String
    let author: String
    let timestamp: Date
    var score: Int
    
    // cloudKit properties
    let ckRecordID: CKRecord.ID
    
    // memberwise init, initialize ckRecord in initializer
    init(text: String, author: String, timestamp: Date = Date(), score: Int = 0, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        
        self.text = text
        self.author = author
        self.timestamp = timestamp
        self.score = score
        self.ckRecordID = ckRecordID
    }
    
    // falliable convenience initializer (CKRecord -> Model)
    // unwrap properties and type cast them as string
    // Create a post object from a CKRecord
    convenience init?(ckRecord: CKRecord) {
        // Unwrap properties from the Key/Value pairs and type cast them, grab the value of the key to be a string, otherwise will return an Any? type
        guard let text = ckRecord[PostConstants.textKey] as? String,
            let author = ckRecord[PostConstants.authorKey] as? String,
            let timestamp = ckRecord[PostConstants.timestampKey] as? Date,
            let score = ckRecord[PostConstants.scoreKey] as? Int
            // return with a value, or nil...because init requires something or nil
            else { return nil }
        
        // assign values and initialize them
        // can call self.init - convenience
        // Initialize a post with the unwrapped properties 
        self.init(text: text, author: author, timestamp: timestamp, score: score, ckRecordID: ckRecord.recordID)
    }
}

// extend CKRecord
extension CKRecord {
    
    convenience init(post: Post) {
        // create a CKRecord with our type, and the record identifier
        self.init(recordType: PostConstants.typeKey, recordID: post.ckRecordID)
        
        // set the values for keys for CKRecord
        self.setValue(post.text, forKey: PostConstants.textKey)
        self.setValue(post.author, forKey: PostConstants.authorKey)
        self.setValue(post.timestamp, forKey: PostConstants.timestampKey)
        self.setValue(post.score, forKey: PostConstants.scoreKey)
    }
    
}

// assign Keys to string name
struct PostConstants {
    static let typeKey = "Post"
    fileprivate static let textKey = "text"
    fileprivate static let authorKey = "author"
    fileprivate static let timestampKey = "timestamp"
    fileprivate static let scoreKey = "score"
}
