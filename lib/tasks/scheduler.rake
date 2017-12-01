desc "This task is called by the Heroku scheduler add-on"
task :clear_stale => :environment do
  puts "Clearing stale homes..."
  Home.clear_stale
  puts "done."
end
