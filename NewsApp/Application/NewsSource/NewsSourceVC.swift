//
//  NewsSourceVC.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import UIKit
import WebKit

class NewsSourceVC: UIViewController, WKNavigationDelegate {

    var url: String?

    @IBOutlet weak var webKit: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        openWeb()
    }

    func openWeb() {

        guard let urlString = url,
              let url = URL(string: urlString) else { return }
        webKit.load(URLRequest(url: url))
        webKit.allowsBackForwardNavigationGestures = true
    }

    func setScreen() {

        webKit.navigationDelegate = self
        self.navigationItem.title = "News Source"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "",
                                                                                              style: .plain,
                                                                                              target: nil,
                                                                                              action: nil)
    }
}
