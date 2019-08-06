# テーブル
## userテーブル<br>
|Column|Type|
|:---|:---|
|id||
|user_name|string|
|password|string|
|email|string|

## Taskテーブル<br>
|Column|Type|
|:---|:---|
|id||
|user_id|integer|
|label_id|integer|
|task_name|string|
|deadline|datetime|
|priority|integer|
|status|string|
|content|text|

## Labelテーブル<br>
|Column|Type|
|:---|:---|
|id||
|task_id|integer|
|lavel_name|string|


## herokuデプロイ手順
１　herokuへデプロイ<br>
$ git push heroku master

２　データベースの移行<br>
$ heroku run rails db:migrate

３　アプリケーションにアクセス<br>
$ heroku config

４　アプリケーションを開く<br>
$ heroku open
