require 'net/http'
require 'uri'
require 'json'

@TrainName = ""
@TrainCompany = ""

class TrainInfo_Post
  #JSON取得
  def get_json
    uri = URI.parse('https://rti-giken.jp/fhc/api/train_tetsudo/delay.json')
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
  end
  #JSONの中身判定
  def json_judge(json_obj)
    for objAllay in json_obj do
      if @TrainName == objAllay.name && @TrainCompany == objAllay.company
        return true
      end  
    end
  end
  #slackにポストする
  def slack_post
    
  end
end

traininfo = TrainInfo_Post.new
puts traininfo.get_json
