# -*- encoding: UTF-8 -*-
require 'net/http'
require 'uri'
require 'json'
require 'date'
require 'slack-ruby-client'
require 'dotenv'

@train_company = '名古屋鉄道'
@channel_name = 'C9LGQ06LT'

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
    datetime = Time.now
    time = datetime.hour.to_s + '時' + datetime.min.to_s + '分現在、'
    message = time.to_s + train_company.to_s + 'の遅延情報はありません。'
    judge_object.each do |item|
      if item['company'].eql?(train_company)
        message = '<@U8U7H4KE0|yuina> ' + time.to_s + train_company.to_s + 'が遅延しています。詳細はこちら→http://top.meitetsu.co.jp/em/'
      end
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
    client.chat_postMessage(channel: channel, text: message)
  end
end

def lambda_handler(event:, context:)
  traininfo = Traininfopost.new
  traininfo.slack_post(
    'C9LGQ06LT', traininfo.delay_judge(traininfo.json_get, '名古屋鉄道')
  )
  # TODO: implement
  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end

traininfo = Traininfopost.new
traininfo.slack_post(
  @channel_name, traininfo.delay_judge(traininfo.json_get, @train_company)
)
