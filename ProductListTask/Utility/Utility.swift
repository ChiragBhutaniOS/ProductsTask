//
//  Utility.swift
//  ProductListTask
//
//  Created by Chirag Bhutani on 07/05/20.
//  Copyright © 2020 Chirag Bhutani. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class Utility: NSObject {
    
    static let sharedInstance = Utility()
    
    private override init() {}
    
    func showErrorWithMessage(message: String, style: BannerStyle = .warning) {
        let banner = NotificationBanner(title: message, style: style)
        banner.show()
    }
}
