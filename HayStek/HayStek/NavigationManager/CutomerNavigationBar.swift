//
//  CutomerNavigationBar.swift
//  HayStek
//
//  Created by Bharat Shilavat on 09/04/25.
//

import Foundation
import UIKit

protocol DelegateCustomNavigationBar : NSObject {
    func buttonSettingOrBackClicked()
    func buttonOptionOrShareClicked()
    func buttonLikeClicked()
}
class CutomerNavigationBar: UIView {
    
    @IBOutlet weak var stackRightButtons: UIStackView!
    @IBOutlet weak var stackCenterLabel: UIStackView!
    @IBOutlet weak var centerTitleLabel: UILabel!
    @IBOutlet weak var centerSubTitleLabel: UILabel!
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var buttonHomeOrBack: UIButton!
    @IBOutlet weak var secondRightButton: UIButton!
    @IBOutlet weak var firstRightButton: UIButton!
    @IBOutlet weak var viewMainNavigation: UIView!

    
    var delegate : DelegateCustomNavigationBar?
    var textColor: UIColor?{
        didSet {
            self.leftTitleLabel.textColor = textColor
        }
    }
    
    override var backgroundColor: UIColor?{
        
        didSet {
            if let statusBar = UIApplication.shared.statusBarUIView{
                statusBar.backgroundColor = backgroundColor
                
                switch backgroundColor {
                case UIColor.white:
                    print("navigationBar backgroundColor white")
                    self.viewController()?.navigationController?.navigationBar.barStyle = .default
                    break
                case AppEnums.AppColor.primary:
                    print("navigationBar backgroundColor appConfigureColor")
                    if #available(iOS 13.0, *) {
                        overrideUserInterfaceStyle = .dark
                    } else {
                        if let topController = UIApplication.topViewController(), (topController.navigationController != nil) {
                            topController.navigationController?.navigationBar.barStyle = .blackTranslucent
                        }
                    }

                    break
                default:
                    self.viewController()?.navigationController?.navigationBar.barStyle = .default
                    print("navigationBar backgroundColor white")
                }
                
                
            }
        }
    }
    
    class func addCustomNavigationBarOnVC(vcToAddNavigation: UIViewController,
                                           screenName: AppEnums.ScreenName,
                                           isLargeNavigationBar: Bool = false) -> CutomerNavigationBar {
        guard let navigationBar = UINib(nibName: "CutomerNavigationBar", bundle: Bundle(for: CutomerNavigationBar.self))
                .instantiate(withOwner: nil, options: nil)
                .first as? CutomerNavigationBar else {
            fatalError("CutomerNavigationBar.xib could not be loaded!")
        }

        
        vcToAddNavigation.navigationController?.navigationBar.isHidden = true
        vcToAddNavigation.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        navigationBar.stackCenterLabel.isHidden = true
        navigationBar.stackRightButtons.isHidden = false
        navigationBar.centerTitleLabel.text = ""
        navigationBar.centerSubTitleLabel.text = ""
        
        //Default setup
        navigationBar.buttonHomeOrBack.isHidden = true
        navigationBar.stackCenterLabel.isHidden = true
        navigationBar.firstRightButton.isHidden = true
        navigationBar.leftTitleLabel.isHidden = true
        navigationBar.secondRightButton.isHidden = true
        
        // Set screen-specific logic here
        switch screenName {

        case .HomeViewController:
           
            navigationBar.firstRightButton.setImage(UIImage(systemName: "bell.badge.fill"), for: .normal)
            navigationBar.secondRightButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)

        case .ProductDetailViewController:
            navigationBar.stackCenterLabel.isHidden = true
            navigationBar.stackRightButtons.isHidden = false
            
            navigationBar.firstRightButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
            navigationBar.secondRightButton.setImage(UIImage(systemName: "heart"), for: .normal)

        case .CatalogueViewController:
            navigationBar.stackCenterLabel.isHidden = true
            navigationBar.stackRightButtons.isHidden = true

        case .CartViewController:
            navigationBar.stackCenterLabel.isHidden = false
            navigationBar.stackRightButtons.isHidden = true
            navigationBar.centerTitleLabel.text = "92 High Street, London"
            navigationBar.centerSubTitleLabel.text = ""

        case .FavoritesViewController:
            navigationBar.stackCenterLabel.isHidden = true
            navigationBar.stackRightButtons.isHidden = false
            navigationBar.firstRightButton.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal) // Filter icon
            navigationBar.secondRightButton.isHidden = true

        case .ProfileViewController:
            navigationBar.stackCenterLabel.isHidden = true
            navigationBar.stackRightButtons.isHidden = true
        }


        // Add the view
        vcToAddNavigation.view.addSubview(navigationBar)
        
        // Set frame automatically
        navigationBar.updateNavigationHeight(isLargeNavigationBar: isLargeNavigationBar)

        return navigationBar
    }

    func updateNavigationHeight(isLargeNavigationBar : Bool){
        if let statusBar = UIApplication.shared.statusBarUIView{
            
            
            let statusBarheight = statusBar.frame.height
            if isLargeNavigationBar == false {
                self.frame = CGRect(x: 0, y: Int(statusBarheight), width: Int(UIScreen.main.bounds.size.width), height: 56)
            }else {
                self.frame = CGRect(x: 0, y: Int(statusBarheight), width: Int(UIScreen.main.bounds.size.width), height: 76)
            }
        }
    }
    
    @IBAction func firstRightButtonAction(_ sender: Any) {
        debugPrint("firstRightButtonAction")
    }
    
    
    @IBAction func leftBackhomeButtonAction(_ sender: Any) {
        debugPrint("leftBackhomeButtonAction")
    }
    
    
    @IBAction func secondRightButtonAction(_ sender: Any) {
        
    }
    
    
}
extension CutomerNavigationBar {
    
    class func statusBarHeight()->CGFloat{
        
        //        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return 0}
        //
        //        return  statusBar.bounds.size.height
        
        if let statusBar = UIApplication.shared.statusBarUIView{
            
            return statusBar.frame.height
        }
        return 0.0
    }
}

extension UIApplication {
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 386
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag
                
                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}
