//
//  TermsFeedPresenter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/18/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol TermsFeedPresentationLogic {
    
    func presentTermsFeedInfo(response: TermsFeedInfo.SetupInfo.Response)
}

class TermsFeedPresenter {
    
    weak var viewController: TermsFeedDisplayLogic?
}

// MARK: - Terms Feed Presentation Logic
extension TermsFeedPresenter: TermsFeedPresentationLogic {
    
    func presentTermsFeedInfo(response: TermsFeedInfo.SetupInfo.Response) {
        
        let displayedTermsFeedInfo = TermsFeedInfo.SetupInfo.ViewModel.DisplayedTermsFeedInfo(title: response.mode.title, infoMessage: response.value)
        let viewModel = TermsFeedInfo.SetupInfo.ViewModel(displayedTermsFeedInfo: displayedTermsFeedInfo, error: response.error)
        
        if response.error == nil {
            
            viewController?.displayTermsFeedInfoSuccess(viewModel: viewModel)
        } else {
         
            viewController?.displayTermsFeedInfoError(viewModel: viewModel)
        }
    }
}
