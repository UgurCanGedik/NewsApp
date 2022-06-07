//
//  ErrorEnum.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import Foundation

enum serviceErrors: CustomStringConvertible {

    case internetError
    case urlError
    case apiError
    case valueError
    case defaultError

    var description : String {

        switch self {
        case .internetError:
            print("Internet connection error. Check connection and try again")
            return "Internet connection error. Check connection and try again"
        case .urlError:
            print("Url creation error. Contact with developer")
            return "Url creation error. Contact with developer"
        case .apiError:
            print("Service error. Contact with developer")
            return "Service error. Contact with developer"
        case .valueError:
            print("Value error. Contact with developer")
            return "Value error. Contact with developer"
        case .defaultError:
            print("An error occured. Please try again later")
            return "An error occured. Please try again later"
        }
    }
}
