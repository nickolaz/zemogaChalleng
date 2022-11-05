import SwiftUI

struct PostDetailView: View {
    @Binding var post : FavoritePostModel
    @EnvironmentObject var allPost : PostViewModel
    
    func checkFavorite() {
        post.isFavorite = !post.isFavorite
        if post.isFavorite {
            allPost.addFavorites(post: post)
        } else {
            allPost.removeFavorite(post: post)
        }
    }

    var body: some View {
        ScrollView{
            VStack{
                Text("Title:")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(post.title).font(.title3)
                Text("Description:")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(post.body).font(.title3)
                Divider()
                AuthorView()
                Divider()
                CommentsView()
            }.onAppear(perform: {
                allPost.getUserInfo(userId: post.userId)
                allPost.getCommentInfo(postId: post.id)
            })
        }.navigationBarTitle("Post Detail")
            .toolbar(content: {
                Button(action: checkFavorite, label: {
                    Image(systemName: post.isFavorite ? "star.fill":"star").foregroundColor(.yellow)
                })
            })
            .padding(.horizontal)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    @State static var post : FavoritePostModel = FavoritePostModel(userId: 1, id: 1, title: "Example Post", body: "This is a example post",isFavorite: false)
    static var previews: some View {
        PostDetailView(post: $post)
    }
}
