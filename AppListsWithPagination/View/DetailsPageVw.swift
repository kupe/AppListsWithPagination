//
//  DetailsPageVw.swift
//  AppListsWithPagination
//
//  Created by VC on 27/05/24.
//

import UIKit

class DetailsPageVw: BaseView {
    
    var controller : DetailsPageVc!
    func setController(controller : DetailsPageVc) -> Void {
        self.controller = controller
        
        
    }
    
    
    
    func designSetups() {
        
        self.lbl_Id.text = "Id : " + dataValidation(data: self.controller.mainSelectedPostDetailsData?.topic_id as AnyObject)
        self.lbl_UserId.text = "User Id : " + dataValidation(data: self.controller.mainSelectedPostDetailsData?.topic_user_id as AnyObject)
        
        self.lbl_MainTitle.text = "Title :\n" + dataValidation(data: self.controller.mainSelectedPostDetailsData?.topic_title as AnyObject)
        self.lbl_MainTitle.numberOfLines = 0
        self.lbl_MainTitle.lineBreakMode = .byWordWrapping
        
        self.lbl_Description.text = "Body :\n" + dataValidation(data: self.controller.mainSelectedPostDetailsData?.topic_body as AnyObject)
        self.lbl_Description.numberOfLines = 0
        self.lbl_Description.lineBreakMode = .byWordWrapping
        
    }
    
    
    @IBOutlet weak var lbl_Id: UILabel!
    @IBOutlet weak var lbl_UserId: UILabel!
    @IBOutlet weak var lbl_MainTitle: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    //MARK: Back action using navigation
    @IBAction func backIconBtn_Pressed(_ sender: UIButton) {
        self.controller.navigationController?.popViewController(animated: true)
    }
    
    
}


extension DetailsPageVw {
    
}
