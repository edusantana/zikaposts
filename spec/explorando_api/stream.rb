require "twitter"
require 'mongo'

client = Mongo::Client.new('mongodb://127.0.0.1:27017/zika')

zika_tweets = client[:tweets]

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
    t["created_at"] = object.created_at
    t["text"] = object.full_text
    t["geo"] = object.geo
#    t["coordinates"] = object.coordinates # nao existe na api
    t["metadata"] = object.metadata
    t["place"] = object.place.full_name if object.place?
    h = {}
    [:filter_level, :in_reply_to_screen_name, :lang, :source, :text, :favorite_count, :in_reply_to_status_id, :in_reply_to_user_id, :retweet_count].each do |key|
      #h[key] = object.send(key)
    end
    #puts h.to_json
    #puts "JSON"
    #puts object.to_h.to_json
    #puts JSON.pretty_generate(object.to_h)
    result = zika_tweets.insert_one(object.to_h)
    #puts result.n # returns 1, because one document was inserted


    #puts "HASH"
    #puts object.to_h


    # @return [String]
    # attr_reader :filter_level, :in_reply_to_screen_name, :lang, :source, :text
    # @return [Integer]
    #attr_reader :favorite_count, :in_reply_to_status_id, :in_reply_to_user_id,
    #            :retweet_count
    # Exemplo:
    # JSON
    # {"created_at":"Mon Sep 11 18:10:27 +0000 2017","id":907305351602737155,"id_str":"907305351602737155","text":"RT @HarryIWood: #LymeDisease is just one disease you can catch from ticks and insects #malaria #dengue #zika @radio5live\nhttps://t.co/omYPk…","source":"<a href=\"http://twitter.com/download/android\" rel=\"nofollow\">Twitter for Android</a>","truncated":false,"in_reply_to_status_id":null,"in_reply_to_status_id_str":null,"in_reply_to_user_id":null,"in_reply_to_user_id_str":null,"in_reply_to_screen_name":null,"user":{"id":1894506524,"id_str":"1894506524","name":"Sergyl LAFONT MD .","screen_name":"SergylB","location":"LYON","url":null,"description":"Infectious diseases Daily News !\n\n\n#Antibiotics#sepsis#microbiota#outbreaks#tuberculosis#STD#HIV#hepatitis#malaria#flu#yeasts#ehealth#foodsafety#probiotics#","translator_type":"none","protected":false,"verified":false,"followers_count":2105,"friends_count":4740,"listed_count":1647,"favourites_count":2859,"statuses_count":58796,"created_at":"Sun Sep 22 17:34:18 +0000 2013","utc_offset":-25200,"time_zone":"Pacific Time (US & Canada)","geo_enabled":false,"lang":"fr","contributors_enabled":false,"is_translator":false,"profile_background_color":"C0DEED","profile_background_image_url":"http://abs.twimg.com/images/themes/theme1/bg.png","profile_background_image_url_https":"https://abs.twimg.com/images/themes/theme1/bg.png","profile_background_tile":false,"profile_link_color":"1DA1F2","profile_sidebar_border_color":"C0DEED","profile_sidebar_fill_color":"DDEEF6","profile_text_color":"333333","profile_use_background_image":true,"profile_image_url":"http://pbs.twimg.com/profile_images/733295303143641088/oANvidO4_normal.jpg","profile_image_url_https":"https://pbs.twimg.com/profile_images/733295303143641088/oANvidO4_normal.jpg","profile_banner_url":"https://pbs.twimg.com/profile_banners/1894506524/1497509007","default_profile":true,"default_profile_image":false,"following":null,"follow_request_sent":null,"notifications":null},"geo":null,"coordinates":null,"place":null,"contributors":null,"retweeted_status":{"created_at":"Mon Sep 11 17:55:21 +0000 2017","id":907301551454261253,"id_str":"907301551454261253","text":"#LymeDisease is just one disease you can catch from ticks and insects #malaria #dengue #zika @radio5live\nhttps://t.co/omYPkVfYZE","source":"<a href=\"http://twitter.com/download/android\" rel=\"nofollow\">Twitter for Android</a>","truncated":false,"in_reply_to_status_id":null,"in_reply_to_status_id_str":null,"in_reply_to_user_id":null,"in_reply_to_user_id_str":null,"in_reply_to_screen_name":null,"user":{"id":2398305672,"id_str":"2398305672","name":"Harry Wood","screen_name":"HarryIWood","location":null,"url":null,"description":"Digital marketeer, ex-forester","translator_type":"none","protected":false,"verified":false,"followers_count":59,"friends_count":66,"listed_count":20,"favourites_count":6,"statuses_count":2192,"created_at":"Wed Mar 19 18:52:16 +0000 2014","utc_offset":3600,"time_zone":"London","geo_enabled":true,"lang":"en","contributors_enabled":false,"is_translator":false,"profile_background_color":"C0DEED","profile_background_image_url":"http://pbs.twimg.com/profile_background_images/447756871789576192/3bgjS8D1.jpeg","profile_background_image_url_https":"https://pbs.twimg.com/profile_background_images/447756871789576192/3bgjS8D1.jpeg","profile_background_tile":false,"profile_link_color":"0084B4","profile_sidebar_border_color":"FFFFFF","profile_sidebar_fill_color":"DDEEF6","profile_text_color":"333333","profile_use_background_image":true,"profile_image_url":"http://pbs.twimg.com/profile_images/446360262891675648/GxPlT5hn_normal.jpeg","profile_image_url_https":"https://pbs.twimg.com/profile_images/446360262891675648/GxPlT5hn_normal.jpeg","profile_banner_url":"https://pbs.twimg.com/profile_banners/2398305672/1395588716","default_profile":false,"default_profile_image":false,"following":null,"follow_request_sent":null,"notifications":null},"geo":null,"coordinates":null,"place":{"id":"48ddb0e520f4f404","url":"https://api.twitter.com/1.1/geo/id/48ddb0e520f4f404.json","place_type":"city","name":"Farnborough","full_name":"Farnborough, South East","country_code":"GB","country":"Royaume-Uni","bounding_box":{"type":"Polygon","coordinates":[[[-0.805418,51.266284],[-0.805418,51.3196],[-0.732525,51.3196],[-0.732525,51.266284]]]},"attributes":{}},"contributors":null,"is_quote_status":false,"quote_count":0,"reply_count":0,"retweet_count":1,"favorite_count":0,"entities":{"hashtags":[{"text":"LymeDisease","indices":[0,12]},{"text":"malaria","indices":[70,78]},{"text":"dengue","indices":[79,86]},{"text":"zika","indices":[87,92]}],"urls":[{"url":"https://t.co/omYPkVfYZE","expanded_url":"https://www.rentokil.com/insects/insect-borne-diseases/","display_url":"rentokil.com/insects/insect…","indices":[105,128]}],"user_mentions":[{"screen_name":"Radio5live","name":"Radio5live","id":461448413,"id_str":"461448413","indices":[93,104]}],"symbols":[]},"favorited":false,"retweeted":false,"possibly_sensitive":false,"filter_level":"low","lang":"en"},"is_quote_status":false,"quote_count":0,"reply_count":0,"retweet_count":0,"favorite_count":0,"entities":{"hashtags":[{"text":"LymeDisease","indices":[16,28]},{"text":"malaria","indices":[86,94]},{"text":"dengue","indices":[95,102]},{"text":"zika","indices":[103,108]}],"urls":[],"user_mentions":[{"screen_name":"HarryIWood","name":"Harry Wood","id":2398305672,"id_str":"2398305672","indices":[3,14]},{"screen_name":"Radio5live","name":"Radio5live","id":461448413,"id_str":"461448413","indices":[109,120]}],"symbols":[]},"favorited":false,"retweeted":false,"filter_level":"low","lang":"en","timestamp_ms":"1505153427397"}


  end
  #puts JSON.generate(t)
  #puts object.to_json
end
