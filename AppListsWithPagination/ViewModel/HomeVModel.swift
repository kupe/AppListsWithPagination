//
//  HomeVModel.swift
//  AppListsWithPagination
//
//  Created by VC on 27/05/24.
//

import UIKit

class HomeVModel: NSObject {
    
    var controller: HomeVc!
    func setViewModel(controller: HomeVc) {
        self.controller = controller
    }
    
    
    //MARK: ******************************Variables and Outlets declaration here Start******************************
    var mainPostsListsModel: HomeFeedsModel?
    
    //MARK: ******************************Variables and Outlets declaration here End******************************
    
    
    
    //Get Home Feeds Lists Process call
    func Get_HomeFeedsLists_Process(PageNo: String, DataLength: String, SearchKeyword: String) {
        if checkNetwork() {
            //LoadMore_Activity_Indicator_4,,,,,
            if PageNo == "0" {
                showProgress(currentView: self.controller.view)
            }
            
            let ApiURL = Constants.API.URL_POSTS_GET_ALL_POSTS
            
            self.Get_HomeFeedsLists_API_Process(ApiURL: ApiURL, PageNo: PageNo, DataLength: DataLength, SearchKeyword: SearchKeyword) { (isSuccess, message, response) in
                
                //LoadMore_Activity_Indicator_5,,,,,
                if PageNo != "0" {
                    DispatchQueue.main.async { [weak self] in
                        self?.controller.activityIndicator.stop()
                    }
                }
                
                
                if isSuccess {
                    DispatchQueue.main.async {
                        hideProgress(currentView: self.controller.view)
                        
                        //=================================================================
                        //=================================================================
                        if let items = response { // as? [[String: Any]]
                            //
                            let count = items.count
                            print("Lists_Count===>>\(count)")
                            self.controller.i_PostsListsTotalCountAns = Int(count) ?? 0
                            if count == 0 {
                                
                            } else {
                                //
                                if let previousListModel = self.mainPostsListsModel {
                                    let currentListModel = HomeFeedsModel(response: response)
                                    
                                    if currentListModel.mainData?.count == 0 {
                                        let pageCount:Int? = (Int(self.controller.s_ApiDataCallPageNumber) ?? 0) - 1
                                        self.controller.s_ApiDataCallPageNumber = dataValidation(data: pageCount as AnyObject)
                                    }
                                    
                                    self.mainPostsListsModel?.mainData = previousListModel.mainData! + currentListModel.mainData!
                                } else {
                                    self.mainPostsListsModel = HomeFeedsModel(response: response)
                                }
                                //
                            }
                            
                        }
                        //=================================================================
                        //=================================================================
                        
                        updateMainQueue {
                            self.controller.VwCustom.mainTableVw.reloadData()
                        }//update_Main_Queue End,,,,,
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        hideProgress(currentView: self.controller.view)
                        self.controller.showAlert(title: "", message: message)
                    }
                }
            }
            
        } else {
            self.controller.showAlert(title: "", message: Constants.GeneralConstants.NetworkStatus)
        }
    }
    
    
    //Get Home Feeds Lists Api Process
    func Get_HomeFeedsLists_API_Process(ApiURL: String, PageNo: String, DataLength: String, SearchKeyword: String, completionHandler: @escaping(_ success: Bool, _ message: String, _ Response: [[String: Any]]?) ->Void) {
        
        let accessToken = dataValidation(data: Constants.userdefaults.value(forKey: Constants.Keys.Access_token) as AnyObject)
        
        let urlString = joint_Given2Texts_Fns(mainText: ApiURL, text1: PageNo, text2: DataLength, text3: SearchKeyword)
        let finalURL = dataValidation(data: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) as AnyObject)
        print("Get_PostsListsAPI: finalURL===>>", finalURL)
        
        ConnectionHandler.shared.getAPI(url1: finalURL, accessToken: accessToken) { (response, error, statusCode) in
            guard let response = response else {
                print("Error response : \(String(describing: error?.localizedDescription)) ---- Error:\(String(describing: error))")
                return
            }
            
            if statusCode==403 {
                //SceneDelegate.originalSceneDelegate.loginPageVc_Fns()
                return
            }
            
            if response.count > 0 {
                //print("Response:===>> \(String(describing: response))")
                completionHandler(true, "success", response)
            } else {
                //
                let pageCount:Int? = (Int(self.controller.s_ApiDataCallPageNumber) ?? 0) - 1
                self.controller.s_ApiDataCallPageNumber = dataValidation(data: pageCount as AnyObject)
                
                completionHandler(true, "Something went wrong. Please try again!", response)
            }
            
        }
        
    }
    
}

