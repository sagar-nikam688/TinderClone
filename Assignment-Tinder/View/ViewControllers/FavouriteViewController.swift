//
//  FavouriteViewController.swift
//  Assignment-Tinder
//
//  Created by Admin on 22/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {
    @IBOutlet weak var listTableview: UITableView!
    var favPeoples: [PersonBO]? = []
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Favourites"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    func getData() {
        do {
            favPeoples?.removeAll()
            favPeoples = try userDefaults.getObject(forKey: "MyFavouriteList", castTo: [PersonBO].self)
            self.listTableview.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
}
extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPeoples?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.listTableview.dequeueReusableCell(withIdentifier: "FavTableViewCell", for: indexPath) as? FavTableViewCell else {
            return UITableViewCell()
        }
        guard let obj = self.favPeoples?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setUpCell(dataObject: obj)
        return cell
    }
}

