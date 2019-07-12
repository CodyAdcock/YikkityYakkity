//
//  PostListTableViewController.swift
//  YikkityYakkity
//
//  Created by Cody on 4/11/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPost()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? PostTableViewCell

        let post = PostController.shared.posts[indexPath.row]
        cell?.post = post
        
        // nil coalesce a uitableview cell
        return cell ?? UITableViewCell()
    }


    //MARK: = Bar Button Items
    @IBAction func createNewPostButtonTapped(_ sender: Any) {
        presentSimpleAlert(title: "Add a new Post!", message: "")
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        
    }
    
    func presentSimpleAlert(title: String, message: String) {
        // Instatiating our Alert Controller, passing in our parameters for title and message
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // add textfields -OR- define with a name var messageTextField 
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Add Message here..."
            
        }
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Your alias here"
        }
        
        // Add a post Action that grabs our text from our textFields, and passes those values into our createPost function
        let postAction = UIAlertAction(title: "Post", style: .default) { (_) in
            guard let bodyText = alertController.textFields?[0].text,
            let authorText = alertController.textFields?[1].text,
            !bodyText.isEmpty,
            !authorText.isEmpty
                else { return }
         
            PostController.shared.createPost(text: bodyText, author: authorText, completion: { (_) in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        
        // Add our cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // Add the action to our alertController
        alertController.addAction(postAction)
        alertController.addAction(cancelAction)
        // Present the alertController View
        self.present(alertController, animated: true )
        
        }
        
    }
    
    
    func fetchPost() {
    PostController.shared.fetchAllPosts { (_) in
    DispatchQueue.main.async {
    self.tableView.reloadData()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

