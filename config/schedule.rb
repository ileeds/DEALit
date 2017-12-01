set :output, "#{path}/log/cron.log"
env :PATH, ENV['PATH']

every 1.day, :at => '4:30 am' do
  runner "Home.clear_stale"
end
