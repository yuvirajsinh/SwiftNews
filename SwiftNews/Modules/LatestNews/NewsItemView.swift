//
//  NewsItemView.swift
//  SwiftNews
//
//  Created by Yuvrajsinh Jadeja on 09/02/23.
//

import SwiftUI

struct NewsItemView: View {
    let article: Article
    let favouteAction: (_ id: URL) -> Void

    private var favouriteIcon: String {
        return article.isFavourite ? "heart.fill" : "heart"
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.surface

            VStack(alignment: .leading, spacing: 10.0) {
                AsyncImage(url: article.urlToImage) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ZStack {
                        Color.gray
                        Image(systemName: "photo")
                            .frame(width: 80.0, height: 80.0)
                    }
                }
                VStack(alignment: .leading, spacing: 16.0) {
                    HStack {
                        Text(article.publishedAt, formatter: formatter())
                            .font(.subheadline)
                        .foregroundColor(Color.gray)
                        Spacer()
                        Text(article.author ?? "")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                    }
                    Text(article.title)
                        .font(.custom("Times New Roman", size: 20.0, relativeTo: .title))
                        .bold()
                    Text(article.description ?? "")
                        .font(.custom("Times New Roman", size: 20.0, relativeTo: .title2))
                }
                .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
            }

            HStack {
                Spacer()
                Button(action: {
                    favouteAction(article.url)
                }, label: {
                    Image(systemName: favouriteIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                        .shadow(color: .black.opacity(0.7), radius: 4.0)
                })
                .buttonStyle(PlainButtonStyle())
                .padding([.top, .trailing], 20.0)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .shadow(color: .black.opacity(0.3), radius: 10.0, x: 0.0, y: 8.0)
    }

    private func formatter() -> Formatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }

}

#if DEBUG
struct NewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewsItemView(article: NewsArticle.example, favouteAction: { _ in
        })
    }
}
#endif
