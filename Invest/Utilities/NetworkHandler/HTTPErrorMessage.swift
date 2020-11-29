//
//  HTTPErrorMessage.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

struct HTTPErrorMessage {
    static let internalError = "Something went wrong! Please try again later."
    static let badRequest = "Bad Request"
    static let resourceNotFound = "API Not found"
    static let inputError = "Please check the input provided"
    static let decoding = "An error occurred while decoding data"
    static let encoding = "Cannot encode given object into Data"
    static let timeout = "Request timed out"
    static let noData = "No content/data available"
    static let status = "Status code error"
    static let noResult = "No result found"
}
