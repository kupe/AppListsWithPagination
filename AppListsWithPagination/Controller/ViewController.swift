//
//  ViewController.swift
//  AppListsWithPagination
//
//  Created by VC on 27/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    @IBAction func StartedButtonTapped(_ sender: Any) {
        let registerVC = instantiateVC(storyboardName: Constants.Storyboard.Name.MAIN, storyboardId: "HomeVc") as! HomeVc
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
