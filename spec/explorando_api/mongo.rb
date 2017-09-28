# Testando  como colocar dados no mongodb
# https://docs.mongodb.com/ruby-driver/master/quick-start/

require 'mongo'

client = Mongo::Client.new('mongodb://127.0.0.1:27017/zika')

collection = client[:people]

doc = { name: 'Steve', hobbies: [ 'hiking', 'tennis', 'fly fishing' ] }

result = collection.insert_one(doc)
result.n # returns 1, because one document was inserted
