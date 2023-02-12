//
//  DateFormatter+Extension.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 12/02/23.
//

import Foundation

extension DateFormatter {
    static let coding: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //"yyyy-MM-dd'T'HH:mm:ss.SSSZ" // E.x."2023-02-09T16:22:24.5847086Z"
        return dateFormatter
    }()
}
