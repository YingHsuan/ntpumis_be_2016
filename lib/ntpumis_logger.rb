class NTPUMIS_Logger

  LOG_DEBUG = 1   # 除錯用的訊息，Production環境會忽略
  LOG_INFO = 2    # 值得記錄的一般訊息
  LOG_WARN = 3    # 值得記錄的警告訊息
  LOG_ERROR = 4   # 錯誤訊息，但還不到網站無法執行的地步
  LOG_FATAL = 5   # 嚴重錯誤到網站無法執行的訊息

  def initialize
    @logger = Rails.logger
  end


  def self.log(level, program, msg = nil)
    @logger = Rails.logger

    if msg.nil?
      log_str = "#{program}"
    else
      log_str = "#{program}:: #{msg}"
    end

    case level
    when LOG_DEBUG
      @logger.debug log_str
      print_to_console(log_str)
    when LOG_INFO
      @logger.info log_str
      print_to_console(log_str)
    when LOG_WARN
      @logger.warn log_str
      print_to_console(log_str)
    when LOG_ERROR
      @logger.error log_str
      print_to_console(log_str)
    when LOG_FATAL
      @logger.fatal log_str
      print_to_console(log_str)
    else
      print_to_console(log_str)
    end

  end


  def self.print_to_console(msg)
    puts "[#{DateTime.now()}] #{msg.to_s}"
  end


end
