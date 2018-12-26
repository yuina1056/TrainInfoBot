require 'net/http'
require 'uri'
require 'json'

@TrainName = ""
@TrainCompany = ""

class TrainInfo_Post
    def get_json
        uri = URI.parse('https://rti-giken.jp/fhc/api/train_tetsudo/delay.json')
        json = Net::HTTP.get(uri)
        puts JSON.parse(json)
    end
    def json_judge(name,company)
        if name == @TrainName && company == @TrainCompany
            return true
        end
    end

end
