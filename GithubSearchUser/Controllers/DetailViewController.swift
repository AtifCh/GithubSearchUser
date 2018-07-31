//
//  DetailViewController.swift
//  GithubSearchUser
//
//  Created by Kaleem on 7/31/18.
//  Copyright © 2018 Kaleem. All rights reserved.
//

import UIKit

//Custom Cell Class
class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
}

class DetailViewController: UIViewController {

    //Array of type GithubItems get from SearchViewController
    var githubItems:[GithubItem]?
    
    @IBOutlet var detailTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem?.title = "Back"
        navigationItem.title = "Detail"
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.githubItems?.count)!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let imgUrl : String!
        imgUrl = self.githubItems![indexPath.row].avatarUrl
        
        _ = (cell as! UserTableViewCell).userImageView.downloadImageFrom(link: imgUrl, contentMode: UIViewContentMode.scaleAspectFill)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        let item = self.githubItems![indexPath.row]
        cell.userNameLabel.text = item.login
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = self.githubItems![indexPath.row]
        let followersVC = self.storyboard?.instantiateViewController(withIdentifier: "FollowersViewController") as! FollowersViewController
        followersVC.username = item.login
        self.navigationController?.pushViewController(followersVC, animated: true)
    }
    
    
}
