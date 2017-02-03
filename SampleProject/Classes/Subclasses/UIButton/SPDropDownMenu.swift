//
//  SPDropDownMenu.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 24/01/2017.
//  Copyright © 2017 <#Project Name#>. All rights reserved.
//

import Foundation
import UIKit


enum SPDropDownMenuScrollIndicatorStyle: Int {
    case defaultScroll
    case black
    case white
}
enum SPDropDownMenuDirection: Int {
    case down
    case up
}


class SPDropDownMenuItem: NSObject {
    /**
     *  Main text of the menu item.
     */
    var title: String = ""
    /**
     *  Accompanying text below the main text. Optional.
     */
    var subtitle: String?
    /**
     *  Accompanying  image on the left of the main text. Optional
     */
    var image: UIImage?
    /**
     *  Convenience constructors. Will only show the main text.
     */
    
    
    func initialize(title: String) -> SPDropDownMenuItem {
        
        let item = SPDropDownMenuItem()
        item.title = title
        return item
    }
    
    func initialize(title: String, subtitle: String, image: UIImage?) -> SPDropDownMenuItem {
        
        let item = SPDropDownMenuItem()
        item.title = title
        item.subtitle = subtitle
        item.image = image
        return item
    }
}

typealias SPDropDownMenuCompletionBlock = (_ dropDownMenu: SPDropDownMenu, _ indexes: [IndexPath]) -> Void ;

class SPDropDownMenu: UIView, UITableViewDataSource, UITableViewDelegate {
    weak var targetView: UIView?
    var menuTableView: UITableView?
    var callback : SPDropDownMenuCompletionBlock!
    /**
     *  An array of SPDropDownMenuItems to show in the drop down menu.
     */
    
    var menuItems : [SPDropDownMenuItem]?
    var menuSelectedItems : [NSNumber]?
    
    var isShouldAllowMultipleSelection: Bool = false
    
    
    static let kCellIdentifier: String = "SPDropDownCellIdentifier"
    
    func reloadTable() {
        menuTableView?.reloadData()
    }
    // MARK: - Init methods
    /**
     *  Use the designated initializer to construct a drop down menu.
     *
     *  @param view      The view under which to show the drop down.
     *  @param menuItems An array of SPDropDownMenuItems to show in the drop down menu.
     *
     *  @return Returns an instance of SPDropDownMenu.
     */
    init(_ view: UIView, menuItems: [SPDropDownMenuItem]?, andMenuSelectedItems menuSelectedItems: [NSNumber]?, shouldAllowMultipleSelection: Bool) {
        super.init(frame: CGRect.zero)
        
        self.targetView = view
        self.menuItems = menuItems!
        self.menuSelectedItems = menuSelectedItems!
        self.isShouldAllowMultipleSelection = shouldAllowMultipleSelection
        self.setup()

    }
//    /**
//     *  Disallow usage of "init" to force the user to use the designated initializer.
//     */
//    
//    init() {
//        super.init()
//    }
    /**
     *  Disallow usage of "initWithCoder:" to force the user to use the designated initializer.
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /**
     *  Disallow usage of "initWithFrame:" to force the user to use the designated initializer.
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Setup
    func setup() {
        self.setupDefaults()
        self.setupUI()
        self.addTable()
    }
    
    func setupDefaults() {
        self.menuColor = UIColor.clear.withAlphaComponent(0.8)
        self.itemColor = UIColor.white
        self.itemFont = UIFont.systemFont(ofSize: 14.0)
        self.itemHeight = 40.0
        self.indicatorStyle = .defaultScroll
    }
    
    func setupUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 3.0
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.6).cgColor
        self.layer.borderWidth = 1.0
        self.backgroundColor = menuColor
    }
    func addTable() {
        if (menuTableView != nil) {
            return
        }
        self.menuTableView = UITableView(frame: self.bounds, style: .plain)
        self.menuTableView?.dataSource = self
        self.menuTableView?.delegate = self
        self.menuTableView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.menuTableView?.separatorStyle = .none
        self.menuTableView?.backgroundColor = UIColor.clear
        self.menuTableView?.indicatorStyle = .white
        self.menuTableView?.keyboardDismissMode = .onDrag
        
        self.menuTableView?.allowsMultipleSelection = isShouldAllowMultipleSelection
        self.addSubview(menuTableView!)
    }
    
    /**
     *  Background color of the drop down menu.
     */
    
    private var _menuColor: UIColor?
    var menuColor: UIColor? {
        get {
            return _menuColor
        }
        set {
            _menuColor = newValue
            self.backgroundColor = _menuColor
        }
    }
    

    /**
     *  Text color of the menu items.
     */
    private var _itemColor: UIColor?
    var itemColor: UIColor? {
        get {
            return _itemColor
        }
        set {
            _itemColor = newValue
            reloadTable()
        }
    }
    
    /**
     *  Font of the menu items.
     */
    
    private var _itemFont: UIFont?
    var itemFont: UIFont? {
        get {
            return _itemFont
        }
        set {
            _itemFont = newValue
            reloadTable()
        }
    }
    
    /**
     *  Height of individual menu items.
     */
    
    private var _itemHeight: Float?
    var itemHeight: Float? {
        get {
            return _itemHeight
        }
        set {
            _itemHeight = newValue
            reloadTable()
        }
    }
    
    /**
     *  Hide the drop down menu when an item is selected.
     */
    var isHidesOnSelection: Bool = false
    /**
     *  Show the drop down menu below or above the specified view.
     */
    var direction : SPDropDownMenuDirection?
    
    /**
     *  Type of scroll indicator for the scroll view.
     */
    var indicatorStyle : SPDropDownMenuScrollIndicatorStyle?
//    {
//        set {
//            self.menuTableView.indicatorStyle = (self.indicatorStyle as UIScrollViewIndicatorStyle);
//        }
//        get {
//            return self.indicatorStyle
//        }
//    }
    
    
    // MARK: - Show-hide
    
    /**
     *  Show the drop down menu under the specified view.
     *
     *  @param callback Returns the drop down menu object, the selection and the index at which it belongs in the array.
     */
    func showMenu(withCompletion callback: @escaping SPDropDownMenuCompletionBlock) {
        self.callback = callback
        
        let x: Float = Float(targetView!.frame.origin.x)
        let width: Float = Float(targetView!.frame.size.width)
        let count : Float = Float(menuItems!.count)
        var height : Float = itemHeight!  * count
        if (menuItems?.count)! > 5 {
            height = Float(itemHeight! * 5)
        }
        var y: Float = 0.0
        if direction == SPDropDownMenuDirection.down {
            y = Float(targetView!.frame.origin.y) + Float(targetView!.frame.size.height)
        }
        else {
            y = Float(targetView!.frame.origin.y) - Float(height)
        }
        let rect : CGRect = CGRect(x: Int(x), y: Int(y), width: Int(width), height: Int(height))//x: x, y: y, width: width, height: height
        self.frame = rect
        targetView!.superview?.addSubview(self)
    }
    /**
     *  Hides the drop down from the screen.
     */
    
    func hide() {
        self.hideMenu()
    }
    
    
    func hideMenu() {
        if isShouldAllowMultipleSelection {
            
            self.isHidden = true
            
            if isHidesOnSelection {
                self.isHidden = true
            }
            menuSelectedItems?.removeAll()
            for path: IndexPath in (menuTableView?.indexPathsForSelectedRows!)! {
                menuSelectedItems?.append(NSNumber(value: path.row))
            }
            self.callback(self, (menuTableView?.indexPathsForSelectedRows!)!)
        }
        else {
            self.isHidden = true
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: SPDropDownMenu.kCellIdentifier)
        let item: SPDropDownMenuItem? = menuItems?[indexPath.row]
        let hasSubtitle: Bool? = ((item?.subtitle?.characters.count)! > 0)
        let hasImage: Bool? = (item?.image != nil)
        
        if cell == nil {
            let style: UITableViewCellStyle = hasSubtitle! ? .subtitle : .default
            cell = UITableViewCell(style: style, reuseIdentifier: SPDropDownMenu.kCellIdentifier)
        }
        cell?.textLabel?.textColor = itemColor
        cell?.textLabel?.font = itemFont
        cell?.backgroundColor = UIColor.white
        cell?.textLabel?.text = item?.title
        if hasSubtitle! {
            cell?.detailTextLabel?.text = item?.subtitle
            cell?.detailTextLabel?.textColor = itemColor
        }
        if isShouldAllowMultipleSelection {
            if (menuSelectedItems?.contains(NSNumber(value: indexPath.row)))! {
                cell?.isSelected = true
            }
            else {
                cell?.isSelected = false
            }
        }
        if hasImage! {
            cell?.imageView?.image = item?.image
        }
        return cell!
    }
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isShouldAllowMultipleSelection {
            menuTableView?.deselectRow(at: indexPath, animated: true)
            self.hide()
            let btn: UIButton? = (targetView as? UIButton)
            btn?.isSelected = false
            self.callback(self, [indexPath])
        }
    }
    private func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> Float {
        return itemHeight!
    }
}
/*
 usage
 
 func btnShowSingle_Press(sender: UIButton) {
 sender.isSelected = !sender.isSelected
 if sender.isSelected {
 var temp: [SPDropDownMenuItem] = []
 if self.dropDown == nil  {
 for item in self.menuItems {
 let idx: Int = self.menuItems.index(of: item )!
 let menuItem: SPDropDownMenuItem = SPDropDownMenuItem()
 menuItem.title = self.menuItems[idx]
 menuItem.subtitle = self.menuItems[idx]
 //                    SPDropDownMenuItem .initialize(self.menuItems[idx], subtitle: "Radiohead - In Rainbows (2007)", image: UIImage.imageNamed("in_rainbows"))
 temp.append(menuItem)
 }
 self.dropDown = SPDropDownMenu(sender, menuItems: temp, andMenuSelectedItems: [], shouldAllowMultipleSelection: false)
 self.dropDown.menuColor = UIColor(white: 0.2, alpha: 1.0)
 self.dropDown.itemColor = UIColor.black
 self.dropDown.itemHeight = 50.0
 self.dropDown.isHidesOnSelection = true
 //                self.dropDown.menuSelectedItems = []
 self.dropDown.direction = .down
 self.dropDown.indicatorStyle = .white
 } else {
 if self.dropDown.menuSelectedItems?.count == 0 {
 self.dropDown.menuSelectedItems = []
 }
 
 }
 dropDown.isHidden = false
 dropDown.showMenu(withCompletion: { (dropMenu, indexes) in
 for ss in indexes {
 print("\(self.menuItems[ss.row])")
 }
 })
 } else {
 dropDown.hideMenu()
 
 }
 }
 func btnShowMultiple_Press(sender: UIButton) {
 sender.isSelected = !sender.isSelected
 if sender.isSelected {
 var temp: [SPDropDownMenuItem] = []
 if self.dropDown1 == nil  {
 for item in self.menuItems {
 let idx: Int = self.menuItems.index(of: item )!
 let menuItem: SPDropDownMenuItem = SPDropDownMenuItem()
 menuItem.title = self.menuItems[idx]
 menuItem.subtitle = self.menuItems[idx]
 //                    SPDropDownMenuItem .initialize(self.menuItems[idx], subtitle: "Radiohead - In Rainbows (2007)", image: UIImage.imageNamed("in_rainbows"))
 temp.append(menuItem)
 }
 self.dropDown1 = SPDropDownMenu(sender, menuItems: temp, andMenuSelectedItems: [], shouldAllowMultipleSelection: true)
 self.dropDown1.menuColor = UIColor(white: 0.2, alpha: 1.0)
 self.dropDown1.itemColor = UIColor.black
 self.dropDown1.itemHeight = 50.0
 self.dropDown1.isHidesOnSelection = true
 //                self.dropDown.menuSelectedItems = []
 self.dropDown1.direction = .down
 self.dropDown1.indicatorStyle = .white
 } else {
 if self.dropDown1.menuSelectedItems?.count == 0 {
 self.dropDown1.menuSelectedItems = []
 }
 
 }
 dropDown1.isHidden = false
 dropDown1.showMenu(withCompletion: { (dropMenu, indexes) in
 for ss in indexes {
 print("\(self.menuItems[ss.row])")
 }
 })
 } else {
 dropDown1.hideMenu()
 
 }
 }
 
 */
