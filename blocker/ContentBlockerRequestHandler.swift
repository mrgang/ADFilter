//
//  ContentBlockerRequestHandler.swift
//  blocker
//
//  Created by 李刚 on 2018/8/9.
//  Copyright © 2018年 sunsheen. All rights reserved.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {

    lazy var secureAppGroupPersistentStoreURL : URL = {
        let fileManager = FileManager.default
        let groupDirectory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.sunsheen.noad")!
        return groupDirectory.appendingPathComponent("blockerList.json")
    }()
    
    func beginRequest(with context: NSExtensionContext) {        
        let attachment = NSItemProvider(contentsOf: secureAppGroupPersistentStoreURL)!
        let item = NSExtensionItem()
        item.attachments = [attachment]
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
    
}
