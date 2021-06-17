//
//  HostingController.swift
//  HeartyRecipe
//
//  Created by Intan Nurjanah on 03/06/21.
//

import SwiftUI

open class HostingController<Content>: UIHostingController<Content> where Content: View {
    // Create new variable to change `preferredStatusBarStyle` property of `UIHostingController`
    var statusBarStyle = UIStatusBarStyle.default
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        self.statusBarStyle
    }
    
    // A function we can call to change the style programmatically
    func changeStatusBarStyle(_ style: UIStatusBarStyle) {
        self.statusBarStyle = style
        // Required for view to update
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override init(rootView: Content) {
        super.init(rootView:rootView)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        // back button configuration
        self.navigationItem.hidesBackButton = true
        
    }
    
    @objc required dynamic public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
