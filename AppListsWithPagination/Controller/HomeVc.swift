//
//  HomeVc.swift
//  AppListsWithPagination
//
//  Created by VC on 27/05/24.
//

import UIKit

class HomeVc: BaseVC {
    
    @IBOutlet var VwCustom: HomeVw!
    var viewModel = HomeVModel()
    
    //LoadMore_Activity_Indicator_1,,,,,
    var activityIndicator: LoadMoreActivityIndicator!
    
    //
    var s_ApiDataCallPageNumber = "0"
    var i_PostsListsTotalCountAns = 0
    var s_searchKeywordAns = ""
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //LoadMore_Activity_Indicator_2,,,,,
        updateMainQueue {
            self.activityIndicator = LoadMoreActivityIndicator(scrollView: self.VwCustom.mainTableVw, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 40)
            //self.activityIndicator.isHidden = true
            
            self.VwCustom.designSetups()
            
        }//update_Main_Queue End,,,,,
        
        
        //Call Api's code
        //updateMainQueue {
        self.getAllPostLists_ApiCall_Fns()
        //}//update_Main_Queue End,,,,,
        //
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.VwCustom.setController(controller: self)
        self.viewModel.setViewModel(controller: self)
        
        //
        self.VwCustom.designSetups()
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


extension HomeVc {
    
    func getAllPostLists_ApiCall_Fns() {
        //
        self.viewModel.mainPostsListsModel = nil
        self.VwCustom.mainTableVw.reloadData()
        //
        
        s_ApiDataCallPageNumber = "1"
        
        //API CALL
        self.PostListsAPIS_CALL_Fns()
    }
    func PostListsAPIS_CALL_Fns() {
        updateMainQueue {
            //API Call code
            self.viewModel.Get_HomeFeedsLists_Process(PageNo: self.s_ApiDataCallPageNumber, DataLength: Constants.API.LIMIT_COMMON_PAGE_LENGTH, SearchKeyword: self.s_searchKeywordAns)
        }//update_Main_Queue End,,,,,
    }
    
}
