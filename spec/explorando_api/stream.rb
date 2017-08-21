require "twitter"
require "json"

client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

#
#client.sample do |object|
#  puts object.text if object.is_a?(Twitter::Tweet)
#end

#topics = ["zika"]
topics = ["zika"]
client.filter(track: topics.join(",")) do |object|
  t = {}

  if object.is_a?(Twitter::Tweet) then
    t["text"] = object.full_text
    t["geo"] = object.geo
    t["metadata"] = object.metadata
    t["place"] = object.place.full_name if object.place?
  end
  puts JSON.generate(t)
end
