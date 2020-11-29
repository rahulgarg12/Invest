//
//  HTTPError.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

enum HTTPError: Error {
    
    case error(Error)
    
    case localizedDescription(String)
    
    // generic
    case success
    case malfunction
    case badRequest
    case resourceNotFound
    case inputError
    case decoding
    case encoding
    case timeout
    case noData
    case status
    case noResult
    
    var error: Error? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
    
    public var localizedDescription: String {
        return description.localizedCapitalized
    }
    
    public var description: String {
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .localizedDescription(let message):
            return message
            
        // generics
        case .malfunction:
            return HTTPErrorMessage.internalError
        case .badRequest:
            return HTTPErrorMessage.badRequest
        case .resourceNotFound:
            return HTTPErrorMessage.resourceNotFound
        case .inputError:
            return HTTPErrorMessage.inputError
        case .decoding:
            return HTTPErrorMessage.decoding
        case .encoding:
            return HTTPErrorMessage.encoding
        case .timeout:
            return HTTPErrorMessage.timeout
        case .noData:
            return HTTPErrorMessage.noData
        case .status:
            return HTTPErrorMessage.status
        case .noResult:
            return HTTPErrorMessage.noResult
        default:
            return HTTPErrorMessage.internalError
        }
    }
}

