desc "Refresh existing articles"

task :refresh_text => :environment do
  puts "Refreshing text"
  TextRefreshWorker.new.perform
  puts "Done"
end
