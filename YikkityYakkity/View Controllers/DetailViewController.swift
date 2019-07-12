//
//  DetailViewController.swift
//  YikkityYakkity
//
//  Created by Cody on 4/11/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    var post: Post? {
        didSet {
            loadViewIfNeeded()
            guard let post = post else { return }
            postTextLabel.text = "\(post.text) \n - \(post.author)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
