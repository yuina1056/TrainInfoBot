require 'net/http'
require 'uri'
require 'json'
require 'slack'


@TrainName = ""
@TrainCompany = ""

class TrainInfo_Post
  def json_get
    uri = URI.parse('https://rti-giken.jp/fhc/api/train_tetsudo/delay.json')
    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

  def slack_post(channel,message)
    Slack.configure do |config|
      config.token = ENV["SLACK_TOKEN"]
    end
    Slack.chat_postMessage(channel: channel, text: message)
  end
end

traininfo = TrainInfo_Post.new
puts traininfo.slack_post("#general","testMessage")
