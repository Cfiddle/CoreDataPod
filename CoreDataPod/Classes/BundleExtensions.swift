//
//  BundleExtensions.swift
//  CoreDataPod
//
//  Created by Charles Fiedler on 10/10/18.
//  Copyright © 2018 MKD. All rights reserved.
//

import Foundation

extension Bundle {
    
    // Load bundle within the Skyward framework if we're running in that
    // context, i.e. a pod
    public class func forPodFramework(for aClass: Swift.AnyClass) -> Bundle {
        let bundle = Bundle(for: aClass)
        guard
            let podBundleUrl = bundle.url(forResource: "CoreDataPod", withExtension: "bundle"),
            let podBundle = Bundle(url: podBundleUrl)
            else {
                return bundle
        }
        return podBundle
    }
    
    public class func forPodFramework(identifier: String) -> Bundle {
        let bundle = Bundle(identifier: identifier)
        guard
            let podBundleUrl = bundle?.url(forResource: "CoreDataPod", withExtension: "bundle"),
            let podBundle = Bundle(url: podBundleUrl)
            else {
                if let bundle = bundle {
                    return bundle
                }
                fatalError()
        }
        return podBundle
    }
}
