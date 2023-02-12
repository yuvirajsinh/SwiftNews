//
//  FileManager+Directory.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 11/02/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
