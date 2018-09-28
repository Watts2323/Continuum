//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Xavier on 9/25/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var resultsArray: [SearchableRecord]?
    
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(postsChanged(_:)), name: PostController.PostsChangedNotification, object: nil)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultsArray = PostController.shared.posts
        tableView.reloadData()
    }
    
    @objc func postsChanged(_ notification: Notification) {
        tableView.reloadData()
    }
    
    func fetchAllPosts() {
        PostController.shared.fetchAllPostsFromCloudKit { (posts) in
            if posts != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.showAlertMessage(titleStr: "Error Fetching Posts", messageStr: "There was an error.")
            }
        }
    }
    
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isSearching ? resultsArray?.count ?? 0:
         PostController.shared.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        let dataSource = isSearching ? resultsArray : PostController.shared.posts
        let post = dataSource?[indexPath.row]
        cell?.post = post as? Post
        return cell ?? UITableViewCell()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let posts = PostController.shared.posts
        let filteredPosts = posts.filter { $0.matches(searchTerm: searchText) }.compactMap { $0 as SearchableRecord }
        resultsArray = filteredPosts
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        resultsArray = PostController.shared.posts
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostDetailVC"{
            let destinationVC = segue.destination as? PostDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let post = PostController.shared.posts[indexPath.row]
            destinationVC?.post = post
        }
    }
 

}
