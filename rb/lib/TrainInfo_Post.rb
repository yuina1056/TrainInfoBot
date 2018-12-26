require 'net/http'
require 'uri'
require 'json'

class TrainInfo_Post
    def get_json
        uri = URI.parse('https://rti-giken.jp/fhc/api/train_tetsudo/delay.json')
        json = Net::HTTP.get(uri)
        JSON.parse(json)
    end
end
