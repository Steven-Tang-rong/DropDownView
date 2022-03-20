//
//  ViewController.swift
//  DropDownView_Demo
//
//  Created by StevenTang on 2022/3/16.
//

import UIKit

class ViewController: UIViewController {
    
    var dataSource: [String] = ["顯示項目1", "顯示項目2", "顯示項目3", "顯示項目4", "顯示項目5"]
    var dropDownButton = UIButton()
    let dropDownTableView = UITableView()
    let dropDownTransparentView = UIView()
    
    @IBOutlet weak var showButton: UIButton!
    @IBAction func showDropViewAction(_ sender: Any) {
        addTransparentView(frames: showButton.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownTableView.delegate = self
        dropDownTableView.dataSource = self
        dropDownTableView.isScrollEnabled = false
        dropDownTableView.register(DemoTableViewCell.self, forCellReuseIdentifier: "DemoCell")
        dropDownTableView.separatorStyle = .none
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene}).compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        dropDownTransparentView.frame = window?.frame ?? self.view.frame
        dropDownTransparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        dropDownTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y  + frames.height , width: frames.width + 80, height: 0)
        dropDownTableView.layer.cornerRadius = 10
        dropDownTableView.alpha = 0.8
        dropDownTableView.reloadData()
        
        self.view.addSubview(dropDownTransparentView)
        self.view.addSubview(dropDownTableView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeAddTransparentView))
        dropDownTransparentView.addGestureRecognizer(tapGesture)
        dropDownTransparentView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.dropDownTransparentView.alpha = 0.1
            self.dropDownTableView.frame = CGRect(x: frames.origin.x , y: frames.origin.y + frames.height + 5, width: frames.width + 80, height: CGFloat(self.dataSource.count * 60))
        }, completion: nil)
    }
    
    @objc func removeAddTransparentView() {
        let frames = showButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            self.dropDownTransparentView.alpha = 0
            self.dropDownTableView.frame = CGRect(x: frames.origin.x , y: frames.origin.y + frames.height + 5, width: frames.width + 80, height: 0)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoCell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
