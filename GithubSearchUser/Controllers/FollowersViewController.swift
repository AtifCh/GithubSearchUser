//
//  FollowersViewController.swift
//  GithubSearchUser
//
//  Created by Kaleem on 7/31/18.
//  Copyright © 2018 Kaleem. All rights reserved.
//

import UIKit

//Custom Cell Class
class FollowerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
}

class FollowersViewController: UIViewController {

    var username : String!
    var userFollowersData :[GithubUserFoloowers] = []
    @IBOutlet var followersTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem?.title = "Back"
        navigationItem.title = "Followers"
        getGithubUserFollowersData(username)
    }
    
    // This method fetch GithubData based on the text in the Search Box through search API
    func getGithubUserFollowersData(_ searchText:String){
        //Implementing URLSession
        let urlString = "https://api.github.com/users/\(searchText)/followers"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                
            }
            
            guard let data = data else {
                
                return
                
            }
            //Implement JSON decoding and parsing
            do {
                
                //Decode retrived data with JSONDecoder and assing type of followersData object
                let followersData = try JSONDecoder().decode([GithubUserFoloowers].self, from: data)
                //Get back to the main queue
                DispatchQueue.main.async {
                    //let followersData = GithubUserFoloowers.init(fromDictionary: json)
                    self.userFollowersData = followersData
                    if self.userFollowersData.count > 0{
                        self.followersTableView.delegate = self
                        self.followersTableView.dataSource = self
                        self.followersTableView.reloadData()
                    }else{
                        Alerts.showOKAlertWithMessage("No record found.", andTitle: .Error)
                    }
                    
                    
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        //End implementing URLSession
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

extension FollowersViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.userFollowersData.count)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let imgUrl : String!
        imgUrl = self.userFollowersData[indexPath.row].avatarUrl
        
        _ = (cell as! FollowerTableViewCell).userImageView.downloadImageFrom(link: imgUrl, contentMode: UIViewContentMode.scaleAspectFill)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerCell", for: indexPath) as! FollowerTableViewCell
        let follower = self.userFollowersData[indexPath.row]
        cell.userNameLabel.text = follower.login
        
        return cell
    }
    
    
}

