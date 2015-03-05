class PostsController < ApplicationController
  before_action :find_post, only:[:edit, :show, :update, :destroy]
  POST_TYPE = {
    :general => "所務公告",
    :conference => "學術公告",
    :alumni => "所友會公告"
  }

  def index
    @posts = Post.all

  end
  def new
    @post = Post.new
    @post_type = JSON.parse(JSON[POST_TYPE])
  end
  def create
    @post = Post.new(post_params)
    @post.save

    redirect_to :action => :index
    flash[:notice] = "成功新增公告 #{@post.title}"
  end
  def show
  end
  def edit
    @post_type = JSON.parse(JSON[POST_TYPE])
  end
  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title,:description,:post_type,:end_date,:download_link)
  end
  def find_post
    @post = Post.find(params[:id])
  end
end
