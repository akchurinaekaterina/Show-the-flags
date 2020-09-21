//
//  DetailViewController.swift
//  Show the flags
//
//  Created by Ekaterina Akchurina on 21.09.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imagename: String?
    @IBOutlet weak var flagImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imagename = imagename {
            title = imagename
            flagImage.image = UIImage(named: imagename)
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
