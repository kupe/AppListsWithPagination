//
//  HomeVw.swift
//  AppListsWithPagination
//
//  Created by VC on 27/05/24.
//

import UIKit

class HomeVw: BaseView {
    
    var controller : HomeVc!
    func setController(controller : HomeVc) -> Void {
        self.controller = controller
        
        
    }
    
    
    
    func designSetups() {
        
    }
    
    
    @IBOutlet weak var mainTableVw: UITableView! {
        didSet {
            //MARK: UITableView setups
            mainTableVw.register(UINib(nibName: Constants.Storyboard.ReuseID.TABLECELL_COMMONNAME, bundle: nil), forCellReuseIdentifier: Constants.Storyboard.ReuseID.TABLECELL_COMMONNAME)
            updateMainQueue {
                self.mainTableVw.delegate = self
                self.mainTableVw.dataSource = self
            }//update_Main_Queue End,,,,,
            
            //iOS 15: Remove empty space before cells in UITableView
            if #available(iOS 15.0, *) {
                UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
                UITableView.appearance().sectionFooterHeight = CGFloat(0)
            }
            
        }
    }
    //MARK: ******************************Variables and Outlets declaration here End******************************
    
    
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


extension HomeVw : UITableViewDelegate, UITableViewDataSource {
    
    func scrollToHeader() {
        self.mainTableVw.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    func scrollToTop(){
        //self.mainTableVw.setContentOffset(CGPoint(x: 0,  y: UIApplication.shared.statusBarFrame.height ), animated: true)
    }
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.mainTableVw.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    func reloadTableViewSelectedRows(SelectedSection: Int, SelectedRow: Int, tableView: UITableView) {
        //let row = <your array name>.index(of: <name passing in>)
        let reloadPath = IndexPath(row: SelectedRow, section: SelectedSection)
        tableView.reloadRows(at: [reloadPath], with: .none)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.viewModel.mainPostsListsModel?.mainData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.controller.viewModel.mainPostsListsModel?.mainData?.count != 0 {
            return 120
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let givenMainData = self.controller.viewModel.mainPostsListsModel?.mainData
        
        if givenMainData?.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.ReuseID.TABLECELL_COMMONNAME, for: indexPath) as! CommonNameTableCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            if let givenData = self.controller.viewModel.mainPostsListsModel?.mainData?[indexPath.row] {
                cell.viaHomeVc_Info_setUpCellwith(givenData: givenData, indexPath: indexPath)
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("clicked indexpath is==>> \(indexPath.row)")
        //
        let givenData = self.controller.viewModel.mainPostsListsModel?.mainData?[indexPath.row]
        
        //=============================
        let nextPageVc = instantiateVC(storyboardName: Constants.Storyboard.Name.MAIN, storyboardId: "DetailsPageVc") as! DetailsPageVc
        nextPageVc.mainSelectedPostDetailsData = givenData
        self.controller.navigationController?.pushViewController(nextPageVc, animated: false)
        //=============================
    }
    
}


//MARK: ScrollView delegate methods
extension HomeVw : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    }
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    }
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //Bottom Refresh
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //LoadMore_Activity_Indicator_3,,,,,
        self.controller.activityIndicator.start {
            DispatchQueue.global(qos: .utility).async {
                
                //===================================================
                //
                let pageCount:Int? = (Int(self.controller.s_ApiDataCallPageNumber) ?? 0) + 1
                self.controller.s_ApiDataCallPageNumber = dataValidation(data: pageCount as AnyObject)
                
                //
                self.controller.PostListsAPIS_CALL_Fns()
                //
                //===================================================
                
                /*for i in 0..<3 {
                    print("!!!!!!!!! \(i)")
                    sleep(1)
                }*/
                
                /*DispatchQueue.main.async { [weak self] in
                    self?.controller.activityIndicator.stop()
                }*/
            }
        }//activity_Indicator start action End,,,,,
        
    }
    
}
