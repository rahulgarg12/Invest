//
//  TrendingViewModel.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import Foundation

final class TrendingViewModel {
    //MARK: - Properties
    var trending = [TrendingQuote]()
    
    //MARK: - Helper Methods
    func getTrendingRates(successHandler: @escaping (TrendingModel) -> (),
                       errorHandler: @escaping (HTTPError) -> ()) {
        
        NetworkHandler().request(urlString: APIList.forexRates,
                                 method: .get,
                                 successHandler: successHandler,
                                 errorHandler: errorHandler)
    }
}

