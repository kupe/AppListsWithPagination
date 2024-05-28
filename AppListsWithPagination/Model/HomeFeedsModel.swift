//
//  HomeFeedsModel.swift
//  AppListsWithPagination
//
//  Created by VC on 27/05/24.
//

import Foundation

class HomeFeedsModel {
    
    var mainData: [HomeFeedsListData]?
    var mainDataCount: Int?
    
    init(response: [[String: Any]]?) {
        self.mainData = [HomeFeedsListData]()
        //let resultData = response as? [[String: Any]]
        //print("response===>>", response)
        if let items = response {
            for item in items {
                let itemValue = HomeFeedsListData(response: item)
                self.mainData?.append(itemValue)
            }//for End,,,,,
            
            mainDataCount = response?.count as? Int
            
        }//items if End,,,,,
        
    }
    
    
}


class HomeFeedsListData {
    //Topic Variables
    var topic_id: String?
    var topic_user_id: String?
    var topic_title: String?
    var topic_body: String?
    
    init(response: [String: Any]) {
        
        self.topic_id = dataValidation(data: response["id"] as AnyObject)
        self.topic_user_id = dataValidation(data: response["userId"] as AnyObject)
        let title = dataValidation(data: response["title"] as AnyObject)
        //let extraSpaceRemoveText_1 = title.replacingOccurrences(of: "\n", with: " ")
        self.topic_title = title //extraSpaceRemoveText_1
        
        let postDesc = dataValidation(data: response["body"] as AnyObject)
        //let extraSpaceRemoveText_2 = postDesc.replacingOccurrences(of: "\n", with: " ")
        self.topic_body = postDesc //extraSpaceRemoveText_2
        
    }
    
}
