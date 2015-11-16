//
//  ViewController.swift
//  CollectionEnums
//
//
//  Created by Ariel Elkin on 09/11/15.
//  Copyright © 2015 Project A Ventures. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewLayout())

    /// Represents the collection view's
    /// sections.
    private enum Section: Int {
        case UserDetails
        case Orders
        case AccountSettings

        static func count() -> Int {
            return Section.AccountSettings.rawValue + 1
        }

        /// The reuse identifier string associated
        /// with this section
        var reuseIdentifier: String {
            switch self {
            case .UserDetails:
                return "UserDetails"
            case .Orders:
                return "Orders"
            case .AccountSettings:
                return "AccountSettings"
            }
        }

        /// The `UICollectionViewCell` subclass associated
        /// with this section
        var cellClass: UICollectionViewCell.Type {
            switch self {
            case .UserDetails:
                return UserDetailsCell.self
            case .Orders:
                return OrderCell.self
            case .AccountSettings:
                return AccountSettingsCell.self
            }
        }
    }

    /// Represents the items in `Section.Orders`
    private enum OrdersItem: Int {
        case HeaderUpcomingOrders
        case Order
        case AllParcels

        init(rawValue: Int, count: Int) {
            if rawValue == 0 {
                self = .HeaderUpcomingOrders
            }
            else if rawValue > count {
                self = .AllParcels
            }
            else {
                self = .Order
            }
        }
    }


    /// Represents the type of items in
    /// Section.AccountSettings
    private enum AccountSettingsItem: Int {
        case DefaultPayment
        case DefaultAddress
        case NotificationSettings
    }

    override func loadView() {
        view = UIView()

        // setup the collection view:
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout

        collectionView.backgroundColor = UIColor.grayColor()

        // Look! No hardcoded nothing!
        collectionView.registerClass(Section.UserDetails.cellClass, forCellWithReuseIdentifier: Section.UserDetails.reuseIdentifier)
        collectionView.registerClass(Section.Orders.cellClass, forCellWithReuseIdentifier: Section.Orders.reuseIdentifier)
        collectionView.registerClass(Section.AccountSettings.cellClass, forCellWithReuseIdentifier: Section.AccountSettings.reuseIdentifier)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)

        // No Storyboards.
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|", options: [], metrics: nil, views: ["collectionView": collectionView])
        NSLayoutConstraint.activateConstraints(constraints)
        constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[collectionView]|", options: [], metrics: nil, views: ["collectionView": collectionView])
        NSLayoutConstraint.activateConstraints(constraints)
    }
}

//MARK:
//MARK: UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        guard let section = Section(rawValue: indexPath.section) else {
            assertionFailure()
            return UICollectionViewCell()
        }

        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(section.reuseIdentifier, forIndexPath: indexPath)

        switch section {

        case .UserDetails:
            cell = cell as! UserDetailsCell
            return cell

        case .Orders:
            cell = cell as! OrderCell
            return cell

        case .AccountSettings:
            cell = cell as! AccountSettingsCell
            return cell
        }
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return Section.count()
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        guard let section = Section(rawValue: section) else {
            assertionFailure()
            return 0
        }

        switch section {

        case .Orders:
            return 10

        default:
            return 1
        }
    }
}




//MARK:
//MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        guard let section = Section(rawValue: indexPath.section) else {
            assertionFailure()
            return
        }

        switch section {

        case .UserDetails:
            print("Tapped on user details!")

        default:
            //ignore taps on these sections.
            break
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        guard let section = Section(rawValue: indexPath.section) else {
            assertionFailure()
            return CGSizeZero
        }

        let width = UIScreen.mainScreen().bounds.size.width

        switch section {

        case .UserDetails:
            return CGSize(width: width, height: 200)

        case .Orders:
            return CGSize(width: width, height: 100)

        case .AccountSettings:
            return CGSize(width: width, height: 300)
        }
    }
}

//MARK:
//MARK: UICollectionViewCells
class UserDetailsCell: UICollectionViewCell {
    override init(frame: CGRect)  {
        super.init(frame: frame)
        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 2
        backgroundColor = UIColor.greenColor()
    }

    //We're not using IB, so implementing this is not required.
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

class OrderCell: UICollectionViewCell {
    override init(frame: CGRect)  {
        super.init(frame: frame)
        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 2
        backgroundColor = UIColor.blueColor()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}


class AccountSettingsCell: UICollectionViewCell {
    override init(frame: CGRect)  {
        super.init(frame: frame)
        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 2
        backgroundColor = UIColor.purpleColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
