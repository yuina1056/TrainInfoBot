require 'net/http'
require 'uri'
require 'json'
require 'slack-ruby-client'
require 'dotenv'

train_company = '名古屋鉄道'

# Slackに電車遅延情報をポストする。
class Traininfopost
  # JSONを取得

  def json_get
    uri = URI.parse('https://rti-giken.jp/fhc/api/train_tetsudo/delay.json')
    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

  # 電車遅延が発生しているか判定する

  def delay_judge(judge_object, train_company)
    message = 'no_deley'
    judge_object.each do |item|
      message = 'deley' if item['company'].eql?(train_company)
    end
    message
  end

  # Slackにポストする
  def slack_post(channel, message)
    Slack.configure do |config|
      Dotenv.load
      config.token = ENV['SLACK_TOKEN']
    end
    client = Slack::Web::Client.new
    p client.auth_test
    client.chat_postMessage(channel: channel, text: message, as_user: true) 
  end
end

def lambda_handler(event:, context:)
  traininfo = Traininfopost.new
  traininfo.slack_post(
    '#general', traininfo.delay_judge(traininfo.json_get, train_company)
  )
    # TODO: implement
  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end

traininfo = Traininfopost.new
traininfo.slack_post(
  'C9LGQ06LT', traininfo.delay_judge(traininfo.json_get, train_company)
)
