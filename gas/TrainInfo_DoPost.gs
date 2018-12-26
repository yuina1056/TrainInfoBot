var slackAccessToken = PropertiesService.getScriptProperties().getProperty('SlackAccessToken');

function doPost(e) {
  var slackApp = SlackApp.create(slackAccessToken);
  // 対象チャンネル
  var channelId = "#_info_train";
  var options = {
    // 投稿するユーザーの名前
    username: "TrainInfo",
    icon_emoji: "：train：",
  }
  
  //電車遅延情報をJSON形式で取得
  var json = JSON.parse(UrlFetchApp.fetch("https://rti-giken.jp/fhc/api/train_tetsudo/delay.json").getContentText());
 
  var name="名古屋本線";
  var company="名古屋鉄道";
  
  // 投稿するメッセージ
  var currentDate = new Date();
  var date = Utilities.formatDate( currentDate, 'Asia/Tokyo', 'M月d日 HH時mm分');
  var message = "◆電車遅延情報 (" + date + "現在)\n 電車遅延情報はありません。";
  
  for each(var obj in json){
 
    if(obj.name === name && obj.company === company){ 
      
      message ="<@U8U7H4KE0|yuina> \n ◆電車遅延情報 (" + date + "現在)\n" + company + name + "が遅延しています。\n詳細はこちら→ http://top.meitetsu.co.jp/em/";

    }
  }
  
  var res = {"text": message};
  return ContentService.createTextOutput(JSON.stringify(res)).setMimeType(ContentService.MimeType.JSON);
}