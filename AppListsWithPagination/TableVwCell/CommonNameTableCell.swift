//
//  CommonNameTableCell.swift
//  Piechips
//
//  Created by Kupendiran Alagarsamy on 18/05/22.
//

import UIKit

class CommonNameTableCell: BaseTableVwCell {
    
    @IBOutlet weak var vw_ContentView: UIView!
    @IBOutlet weak var vw_MainView: UIView!
    
    @IBOutlet weak var lbl_CommonName: UILabel!
    
    @IBOutlet weak var constraintMainView_leading: NSLayoutConstraint!
    @IBOutlet weak var constraintMainView_trailing: NSLayoutConstraint!
    @IBOutlet weak var constraintMainView_top: NSLayoutConstraint!
    @IBOutlet weak var constraintMainView_bottom: NSLayoutConstraint!
    
    @IBOutlet weak var constraintCommonNameLbl_leading: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lbl_CommonName.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}





extension CommonNameTableCell {
    
    func viaSearchCircleTopicsVc_setUpCellwith(givenData: TopicsListData) {
        
        self.lbl_CommonName.text = givenData.Category_Name
        
    }
    
}



extension CommonNameTableCell {
    
    func viaPersonProfileVc_Info_setUpCellwith(givenData: PeoplesListData, indexPath: IndexPath, name:String) {
        
        if name == "Info" {
            self.constraintCommonNameLbl_leading.constant = 10
            
            let user_info = dataValidation(data: givenData.user_about_info as AnyObject)
            self.lbl_CommonName.text = user_info + "\n"
            self.lbl_CommonName.font = UIFont(name: Constants.FontTypes.Inter.Regular, size: 13)
            
            self.lbl_CommonName.lineBreakMode = .byWordWrapping
            self.lbl_CommonName.numberOfLines = 0
        }
        
    }
    
}



extension CommonNameTableCell {
    
    func viaChipProfile_ChipDetails_setUpCellwith(givenData: ChipsListData, Page: String) {
        let s_ChipAbout = dataValidation(data: givenData.chip_about as AnyObject)
        let b_isAboutExpandOrNot = givenData.isAboutExpandOrNot
        
        self.constraintMainView_leading.constant = 10
        
        self.lbl_CommonName.text = s_ChipAbout
        self.lbl_CommonName.font = UIFont(name: Constants.FontTypes.Inter.Regular, size: 13.0)
        
        if b_isAboutExpandOrNot == 0 {
            self.lbl_CommonName.numberOfLines = 3
            self.lbl_CommonName.lineBreakMode = .byTruncatingTail
        } else {
            self.lbl_CommonName.numberOfLines = 0
            self.lbl_CommonName.lineBreakMode = .byWordWrapping
        }
        
    }
    
}

