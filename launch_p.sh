#resque part
#kill -9 `cat tmp/pids/resque.pid`
#rake resque:work QUEUE='*' PIDFILE='tmp/pids/resque.pid' BACKGROUND=yes


#RACK_ENV=none RAILS_ENV=production unicorn -c config/unicorn.rb
bundle exec unicorn -D -E production -c config/unicorn.rb


#[ -d shared ] || mkdir shared
#[ -d shared/log ] || mkdir shared/log
#[ -d shared/pids ] || mkdir shared/pids
