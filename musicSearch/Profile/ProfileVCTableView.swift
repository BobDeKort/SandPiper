//
//  ProfileVCTableView.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/12/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") as! SearchHistorySongTableViewCell
        
        return cell
    }
}
