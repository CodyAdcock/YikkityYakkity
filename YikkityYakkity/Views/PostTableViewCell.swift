//
//  PostTableViewCell.swift
//  YikkityYakkity
//
//  Created by Cody on 4/11/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // landing pad 
    var post: Post? {
     didSet {
        updateViews()
        }
    }
    
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var pointTotalLabel: UILabel!
    
    
    @IBAction func upvoteButtonTapped(_ sender: Any) {
        guard let post = post else { return }
        post.score += 1
        pointTotalLabel.text = "\(post.score)"
        
    }
    @IBAction func downvoteButtonTapped(_ sender: Any) {
        guard let post = post else { return }
        post.score -= 1
        pointTotalLabel.text = "\(post.score)"
        
    }
    func updateViews() {
        guard let post = post else { return }
        postTextLabel.text = "\(post.text) \n - \(post.author)"
        pointTotalLabel.text = "\(post.score)"
    }

