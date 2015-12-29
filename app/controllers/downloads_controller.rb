class DownloadsController < ApplicationController
  require 'ntpumis_logger'
  before_action :authenticate_user!, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  before_action :find_download, only:[:edit, :update, :destroy]

  DOWNLOAD_TYPE={
    :enrollment => "招生簡介",
    :newspaper => "資管所通訊",
    :examination => "歷屆考題",
    :domestic => "常用表單",
    :fiveyear => "一貫修讀學、碩士學位"
  }

  def index
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @downloads_enrollment = []
    @downloads_newspaper = []
    @downloads_examination = []
    @downloads_domestic = []
    @downloads_fiveyear = []
    downloads = Download.order("created_at DESC").all
    downloads.each do |d|
      if d.file_type == "enrollment"
        @downloads_enrollment << d
      elsif  d.file_type == "newspaper"
        @downloads_newspaper << d
      elsif d.file_type == "examination"
        @downloads_examination << d
      elsif d.file_type == "domestic"
        @downloads_domestic << d
      elsif d.file_type == "fiveyear"
        @downloads_fiveyear << d
      end
    end
  end

  def new
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @download = Download.new
    @download_type = DOWNLOAD_TYPE.as_json
  end

  def create
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @download = Download.new(download_params)
    @download.save

    redirect_to :action => :index
    flash[:notice] = "成功新增連結 [#{DOWNLOAD_TYPE.as_json[@download.file_type]}] #{@download.title}"
  end

  def edit
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @download_type = DOWNLOAD_TYPE.as_json
  end

  def update
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @download.update(download_params)

    redirect_to :action => :index
    flash[:notice] = "成功更新連結  [#{DOWNLOAD_TYPE.as_json[@download.file_type]}] #{@download.title}"
  end

  def destroy
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    @download.destroy

    redirect_to :action => :index
    flash[:alert] = "成功刪除連結 #{@download.title}"
  end

  def list
    NTPUMIS_Logger.log(NTPUMIS_Logger::LOG_INFO, "#{self.controller_name}##{self.action_name}", nil)
    enrollment_arr = []
    newspaper_arr=[]
    examination_arr=[]
    domestic_arr=[]
    fiveyear_arr=[]
    downloads = Download.order('created_at').all
    downloads.each do |d|
      if d.file_type == "enrollment"
        enrollment_arr << d
      elsif d.file_type == "newspaper"
        newspaper_arr << d
      elsif d.file_type == "examination"
        examination_arr << d
      elsif d.file_type == "domestic"
        domestic_arr << d
      elsif d.file_type == "fiveyear"
        fiveyear_arr << d
      end
    end
    result={
          :enrollment => enrollment_arr,
          :newspaper => newspaper_arr,
          :examination => examination_arr,
          :domestic => domestic_arr,
          :fiveyear => fiveyear_arr
        }

    render :json => result
  end




  private
  def download_params
    params.require(:download).permit(:file_type, :title, :link)
  end
  def find_download
    @download = Download.find(params[:id])
  end
end
