//
//  DetailsPageVc.swift
//  AppListsWithPagination
//
//  Created by VC on 27/05/24.
//

import UIKit

class DetailsPageVc: BaseVC {
    
    @IBOutlet var VwCustom: DetailsPageVw!
    
    var mainSelectedPostDetailsData : HomeFeedsListData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.VwCustom.setController(controller: self)
        
        //
        updateMainQueue {
            self.VwCustom.designSetups()
        }//update_Main_Queue End,,,,,
        //
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
