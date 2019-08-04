//
//  SettingDiscoverEntranceViewController.swift
//  WeChatSwift
//
//  Created by xu.shuifeng on 2019/8/2.
//  Copyright © 2019 alexiscn. All rights reserved.
//

import AsyncDisplayKit

class SettingDiscoverEntranceViewController: ASViewController<ASTableNode> {
    
    private var dataSource: [DiscoverModel] = []
    
    init() {
        super.init(node: ASTableNode(style: .plain))
        node.dataSource = self
        node.delegate = self
        dataSource = MockFactory.shared.discoverEntrance().flatMap { return $0.models }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        node.backgroundColor = Colors.DEFAULT_BACKGROUND_COLOR
        node.view.separatorStyle = .none
        navigationItem.title = "发现页管理"
    }
}

// MARK: - ASTableDelegate & ASTableDataSource
extension SettingDiscoverEntranceViewController: ASTableDelegate, ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let discover = dataSource[indexPath.row]
        let isLastCell = indexPath.row == dataSource.count - 1
        let block: ASCellNodeBlock = {
            return SettingDiscoverEntranceCellNode(discover: discover, isLastCell: isLastCell)
        }
        return block
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 1, width: view.bounds.width, height: 37))
        let headerLabel = UILabel()
        headerLabel.numberOfLines = 0
        headerLabel.text = "打开 / 关闭发现页的入口"
        headerLabel.textColor = Colors.DEFAULT_TEXT_GRAY_COLOR
        headerLabel.font = UIFont.systemFont(ofSize: 14)
        headerLabel.frame = CGRect(x: 16, y: 16, width: headerView.bounds.width - 32, height: 17)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 46))
        let footerLabel = UILabel()
        footerLabel.numberOfLines = 0
        footerLabel.text = "关闭后，仅隐藏“发现”中该功能的入口，不会清空任何历史数据。"
        footerLabel.textColor = Colors.DEFAULT_TEXT_GRAY_COLOR
        footerLabel.font = UIFont.systemFont(ofSize: 14)
        footerLabel.frame = CGRect(x: 16, y: 4, width: footerView.bounds.width - 32, height: 34)
        footerView.addSubview(footerLabel)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 46
    }
}