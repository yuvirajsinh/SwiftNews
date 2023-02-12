//
//  LatestNewsView.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 11/02/23.
//

import SwiftUI

struct LatestNewsView: View {
    @StateObject private var viewModel: LatestNewsViewModel = LatestNewsViewModel()

    private var favouriteIcon: String {
        switch viewModel.viewState {
        case .latestNews:
            return "heart"
        case .favourite:
            return "heart.fill"
        }
    }

    private var navTitle: String {
        switch viewModel.viewState {
        case .latestNews:
            return "Latest News"
        case .favourite:
            return "Favourites"
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles, id: \.url) { article in
                    ZStack {
                        NewsItemView(article: article, favouteAction: favouriteClicked(with:))
                        NavigationLink(destination: {
                            if let url = article.url {
                                SafariView(url: url.absoluteString)
                            }
                        }, label: {
                            EmptyView()
                        })
                        /// Helps to hide disclosure
                        .frame(width: 0.0)
                        .opacity(0.0)
                    }
                    .listRowSeparator(.hidden)
                    .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 20.0, trailing: 0.0))
                }
            }
            .listStyle(.plain)
            .toolbar {
                if viewModel.isLoading {
                    ToolbarItem(placement: .navigationBarLeading) {
                        ProgressView()
                    }
                }
                ToolbarItem {
                    Button(action: showFavourite) {
                        Label("Favourite", systemImage: favouriteIcon)
                    }
                }
            }
            .navigationTitle(navTitle)
        }
        .onAppear {
            UITableViewCell.appearance().selectionStyle = .none
            viewModel.fetchData()
        }
    }

    private func showFavourite() {
        viewModel.toggleFavourites()
    }

    private func favouriteClicked(with url: URL) {
        viewModel.toogleFavourite(forAartileWith: url)
    }
}

#if DEBUG
struct LatestNewsView_Previews: PreviewProvider {
    static var previews: some View {
        LatestNewsView()
    }
}
#endif
