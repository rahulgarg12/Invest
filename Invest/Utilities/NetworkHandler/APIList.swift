//
//  APIList.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

struct APIList {
    private static let baseURL = "https://finnhub.io/api/v1"
    
    static let forexRates = "\(APIList.baseURL)/forex/rates?base=USD"
}
