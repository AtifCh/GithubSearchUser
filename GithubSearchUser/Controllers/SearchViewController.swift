//
//  SearchViewController.swift
//  GithubSearchUser
//
//  Created by Kaleem on 7/31/18.
//  Copyright © 2018 Kaleem. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //Array of type GithubItems to store Items data after parsing JSON
    var items:[GithubItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Github Search Users by Username / Email"
        activityIndicator.isHidden = true
        searchBarView.delegate = self
    }
    
    // Resign Keyboard
    
    @IBAction func resignKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // This method updates GithubData based on the text in the Search Box
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        searchBarView.isLoading = true
        getGithubUsersData(searchBar.text!)
    }
    
    
    // This method fetch GithubData based on the text in the Search Box through search API
    func getGithubUsersData(_ searchText:String){
        //Implementing URLSession
        let urlString = "https://api.github.com/search/users?q=\(searchText)"
//        let urlString = "https://api.github.com/users/octocat/follower"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                
            }
            
            guard let data = data else {
                Alerts.showOKAlertWithMessage("No record found.", andTitle: .Error)
                self.searchBarView.isLoading = false
                return
                
            }
            //Implement JSON decoding and parsing
            do {
                
                //Decode retrived data with JSONDecoder and assing type of GithubData object
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    // appropriate error handling
                    self.searchBarView.isLoading = false
                    return
                }
                //Get back to the main queue
                DispatchQueue.main.async {
                    self.searchBarView.isLoading = false
                    print(json)
                    let githubData = GithubData.init(fromDictionary: json)
                    print(githubData)
                    self.items = githubData.items
                    self.activityIndicator.stopAnimating()
                    if (self.items?.count)! > 0{
                        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                        detailVC.githubItems = self.items
                        self.navigationController?.pushViewController(detailVC, animated: true)
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
