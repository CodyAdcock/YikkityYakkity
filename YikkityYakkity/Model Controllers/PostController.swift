//
//  PostController.swift
//  YikkityYakkity
//
//  Created by Cody on 4/11/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import Foundation
import CloudKit

class PostController{
    
    // Shared instance
    static let shared = PostController()
    
    // source of truth
    var posts: [Post] = []
    
    // database declaration
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: - CRUD
    
    // Create
    func createPost(text: String, author: String, completion: @escaping (Post?) -> Void) {
        // Create a new Post
        let newPost = Post(text: text, author: author)
        
       // Create a CKRecord from our new post
        let newRecord = CKRecord(post: newPost)
        
        // saving our CKRecord to our public database
        publicDB.save(newRecord) { (record, error) in
           // handling our error
            if let error = error {
                print("Error in \(error.localizedDescription)")
                completion(nil)
                return
            }
            // Unwrapping the successfully saved record
            guard let record = record else { completion(nil) ; return }
            
            // Recreate post that was successfully saved
            guard let post = Post(ckRecord: record) else { completion(nil); return }
            
            //append our successfully saved post to source of truth
            self.posts.append(post)
            
            // finish function, completion 
            completion(post)
        }
    }
    // Read
    func fetchAllPosts(completion: @escaping ([Post]?) -> Void) {
       
        // query needs a predicate
        let predicate = NSPredicate(value: true)
        
        // create a query to fetch records
        let query = CKQuery(recordType: PostConstants.typeKey, predicate: predicate)
        
        // return with records -OR- and error
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let records = records else { completion(nil); return }
            
            // Turn records into posts
            // for loop
            // initializing an array of posts, same as [Post] = []
           /* var tempArray = [Post]()
            for record in records {
                guard let post = Post(ckRecord: record) else { completion(nil) ; return }
                tempArray.append(post)
            } */
            
            // Or Same as Above
            // Iterating through an array Records and initialzing Posts from the non-Nil values
            let posts: [Post] = records.compactMap( {Post(ckRecord: $0) } )
            // set source of truth for the posts we found, override what is already in [Post]
            self.posts = posts
            //complete with posts
            completion(posts)
        }
    }
}
