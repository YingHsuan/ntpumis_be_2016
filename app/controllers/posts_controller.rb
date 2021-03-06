class PostsController < ApplicationController
  require 'ntpumis_logger'
  before_action :authenticate_user!, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  before_action :find_post, only:[:edit, :show, :update, :destroy]
  POST_TYPE = {
    :general => "所務公告",
    :conference => "學術公告",
    :alumni => "所友會公告"
  }

  def index
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @posts_general = Post.where("post_type = ?","general").order(created_at: :desc)
    @posts_conference = Post.where("post_type = ?","conference").order(created_at: :desc)
    @posts_alumni = Post.where("post_type = ?","alumni").order(created_at: :desc)
  end
  def new
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @post = Post.new
    @post_type = JSON.parse(JSON[POST_TYPE])
  end
  def create
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @post = Post.new(post_params)
    @post.save

    redirect_to :action => :index
    flash[:notice] = "成功新增公告 #{@post.title}"
  end
  def show
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @post_type = JSON.parse(JSON[POST_TYPE])
  end
  def update
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @post.update(post_params)

    redirect_to :action => :show, :id=>@post
    flash[:notice] = "成功更新公告 #{@post.title}"

  end
  def edit
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @post_type = JSON.parse(JSON[POST_TYPE])
  end
  def destroy
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @post.destroy
    redirect_to :action => :index
    flash[:alert] = "成功刪除公告 #{@post.title}"
  end

  #API
  def list
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    result = Array.new
    posts = Post.all.order('created_at DESC')
    posts.each do |post|
      result.push(
        {
          :id => post.id,
          :title => post.title,
          :description => post.description,
          :description_text => post.description.gsub(/<.*?>/, ""),
          :post_type => post.post_type,
          :end_date => post.end_date.nil? ? post.end_date : post.end_date.strftime("%Y/%m/%d"),
          :download_link => post.download_link,
          :created_at => post.created_at.strftime("%Y/%m/%d")

        }
      )
    end
    render :json => result
  end
  private
  def post_params
    params.require(:post).permit(:title,:description,:post_type,:end_date,:download_link)
  end
  def find_post
    @post = Post.find(params[:id])
  end
end
