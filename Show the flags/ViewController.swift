//
//  ViewController.swift
//  Show the flags
//
//  Created by Ekaterina Akchurina on 21.09.2020.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [String]()
    
    var countofLooking = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
        title = "Here are the flags"
        
        loadCount()
        // Do any additional setup after loading the view.
    }
    
    func loadImages(){
        DispatchQueue.global().async {
            let fm = FileManager.default
            if let path = Bundle.main.resourcePath {
                let items = try! fm.contentsOfDirectory(atPath: path)
                for item in items {
                    if item.hasSuffix("png") {
                        
                        self.countries.append(item)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        cell.textLabel?.text = "\(countries[indexPath.row]), seen: \(countofLooking[indexPath.row]) "
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            dc.imagename = countries[indexPath.row]
            saveCountForPicture(indexPath.row)
            tableView.reloadData()
            navigationController?.pushViewController(dc, animated: true)
        }
    }
    func loadCount(){
        let defaults = UserDefaults.standard
        if let loadNumbers = defaults.data(forKey: "seen") {
            let jsonDecoder = JSONDecoder()
            guard let loadedData = try? jsonDecoder.decode([Int].self, from: loadNumbers) else {fatalError("Unable to decode")}
            countofLooking = loadedData
        } else {
            for country in countries {
                countofLooking.append(0)
            }
        }
    }
    func saveCountForPicture (_ item: Int) {
        let defaults = UserDefaults.standard
        countofLooking[item] += 1
        let jsonEncoder = JSONEncoder()
        if let encoded = try? jsonEncoder.encode(countofLooking) {
            defaults.set(encoded, forKey: "seen")
        } else {
            fatalError("Unable to encode")
        }
    }

}

