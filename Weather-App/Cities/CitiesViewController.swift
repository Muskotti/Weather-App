//
//  CitiesViewController.swift
//  Weather-App
//
//  Created by Toni Vänttinen on 08/10/2019.
//  Copyright © 2019 Toni Vänttinen. All rights reserved.
//

import UIKit

class CitiesViewController: UITableViewController {
    
    var stuff = ["Use GPS", "Helsinki", "Tampere", "Turku","Add a new citie"]
    var cur : ViewController?
    var fore: ForecastViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(stuff[indexPath.row] == "Add a new citie") {
            let citiAdd = UIAlertController(title: "Add a new citie", message: nil, preferredStyle: .alert)
            citiAdd.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
                self.stuff.insert(citiAdd.textFields![0].text!, at: self.stuff.count - 1)
                self.tableView.reloadData()
            }))
            citiAdd.addTextField(configurationHandler: {(textfield) in
                textfield.placeholder = "Citie name"
            })
            self.present(citiAdd, animated: true, completion: nil)
        } else {
            self.cur?.setLocationCiti(citi: stuff[indexPath.row])
            self.fore?.setTableCiti(citi: stuff[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stuff.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesTableID", for: indexPath)
        cell.textLabel?.text = self.stuff[indexPath.row]
        return cell
    }
    
    func giveClasses(cur: ViewController, fore: ForecastViewController) {
        self.cur = cur
        self.fore = fore
    }
}
