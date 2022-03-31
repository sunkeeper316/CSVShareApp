//
//  ShareViewController.swift
//  CSVShare
//
//  Created by Sun Huang on 2022/3/30.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    private let appURL = "CSVShareApp://"
    private let groupName = "group.com.charder.CSVShareApp"
    
    override func viewDidLoad() {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        var items = [Any]()
        if let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem{
            print("\(extensionItem.attachments)")
            if let itemProvider = extensionItem.attachments?.first as? NSItemProvider {
                if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                    itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) -> Void in
                        if let shareURL = url as? NSURL {
                            // do what you want to do with shareURL
                            print("shareURL\(shareURL)")
                            do {
                                let itemData = try Data(contentsOf: shareURL as URL)
                                self.saveURLString(itemData)
                                
                            }catch let error {
                                print(error.localizedDescription)
                            }
                        }
                        let alert = UIAlertController(title: "警告", message: "開啟App", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { action in
                            self.openMainApp()
                        }
//                        let okAction = UIAlertAction(title: "OK", style: .default)
                        alert.addAction(okAction)
                        DispatchQueue.main.async {
                            self.present(alert, animated: true, completion: nil)
                        }
                        
//                        self.openMainApp()
                    })
                }
            }
        }
    }
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        var items = [Any]()
        if let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem{
            print("\(extensionItem.attachments)")
            if let itemProvider = extensionItem.attachments?.first as? NSItemProvider {
                if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                    itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) -> Void in
                        if let shareURL = url as? NSURL {
                            // do what you want to do with shareURL
                            print("shareURL\(shareURL)")
                            do {
                                let itemData = try Data(contentsOf: shareURL as URL)
                                self.saveURLString(itemData)
                                
                            }catch let error {
                                print(error.localizedDescription)
                            }
                            
                            
//                            if let urlstr = shareURL.absoluteString {
//
//                            }
                            
                        }
                        self.openMainApp()
//                        self.extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
                    })
                }
            }
        }
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    private func openMainApp() {
        self.extensionContext?.completeRequest(returningItems: nil, completionHandler: { _ in
            guard let url = URL(string: self.appURL) else { return }
            _ = self.openURL(url)
        })
    }
    
    @objc private func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }
    private func saveURLString(_ urlString: Any) {
        UserDefaults(suiteName: self.groupName)?.set(urlString, forKey: "file")
    }

}
