//
//  SafariView.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 10/02/23.
//

import WebKit
import SwiftUI

struct SafariView: UIViewRepresentable {
    let url: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView(frame: .zero)
    }

    func updateUIView(_ view: WKWebView, context: Context) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            view.load(request)
        }
    }
}
struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: "https://www.google.com")
    }
}
