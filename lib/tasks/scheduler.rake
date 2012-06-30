desc "Create twitter-json.txt"
  task :feeds => :environment do
   puts "Executing Cron at #{Time.now()} \n"
   cache = "#{Rails.root}/tmp/twitter_cache"
   Dir.mkdir(cache) unless Dir.exists?(cache)
   filename = "#{cache}"+"/twitter-json.txt"

   uri = URI("http://api.twitter.com/1/statuses/user_timeline/100kin10.json?count=3&include_rts=true&include_entities=true")
   data = Net::HTTP.get(uri)

   unless File.exists?(filename)
    File.new(filename, "w")
   end
   File.open(filename, "w") { |f| f.write data; f.close;}
 end
