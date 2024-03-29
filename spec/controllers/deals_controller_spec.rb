describe DealsController do
  it "responds successfully with an HTTP 200 status code" do
    get :index
    expect(response).to be_success
    expect(response.status).to eq(200)
  end
  
  it "loads all of the posts into @posts" do
    post1, post2 = Post.create!, Post.create!
    get :index

    expect(assigns(:posts)).to match_array([post1, post2])
  end
end