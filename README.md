# TcgRecorder

A new Flutter application.

## DBテーブル

- ゲーム名テーブル

| 名前       | データ型   |  属性       | NULL | デフォルト値 | コメント | その他 |
|------------|-----------|-------------|------|-------------|----------|--------|
| game_id    | INTEGER   | PRIMARY KEY | no   | なし         | ID      | AUTO_INCREMENT |
| game       | TEXT      | UNIQUE      | no   | なし         | ゲーム名 |  　　|

- デッキテーブル

| 名前       | データ型   |  属性       | NULL | デフォルト値 | コメント         | その他 |
|------------|-----------|-------------|------|-------------|-----------------|--------|
| deck_id    | INTEGER   | PRIMARY KEY | no   | なし         | ID      | AUTO_INCREMENT |
| deck       | TEXT      | UNIQUE      | no   | なし         | デッキ名 |  　　|
| game_Id | INTEGER   |             | no   | なし        | ゲーム名ID |      |

- 記録テーブル

| 名前             | データ型   |  属性       | NULL | デフォルト値 | コメント        | その他 |
|------------------|-----------|-------------|------|------------|-----------------|--------|
| record_id        | INTEGER   | PRIMARY KEY | no   | なし        | ID             | AUTO_INCREMENT |
| date             | TEXT      |             | no   | なし        | 日付 　　       |  　　|
| game_id          | INTEGER   |             | no   | なし        | ゲーム名ID　　　 |      |
| tag_id           | INTEGER   |             | no   | なし        | タグID　　　  　 |      |
| my_deck_id       | INTEGER   |             | no   | なし        | 使用デッキID　　 | deck_idで紐づけ 　　|
| opponent_deck_id | INTEGER   |             | no   | なし        | 相手のデッキID   | deck_idで紐づけ 　　|
| 1st_play         | INTEGER   |             | no   | なし        | 先攻後攻    　　 |  　　|
| win_or_lose1     | INTEGER   |             | no   | なし        | 勝敗1　　    　　|  　　|
| memo             | TEXT      |             | yes  | なし        | メモ 　　       |  　　|

- タグテーブル

| 名前    | データ型   |  属性       | NULL | デフォルト値 | コメント   | その他 |
|---------|-----------|-------------|------|------------|------------|--------|
| tag_Id  | INTEGER   | PRIMARY KEY | no   | なし        | ID        | AUTO_INCREMENT |
| tag     | TEXT      |             | no   | なし        | タグ名     |  　　|
| game_Id | INTEGER   |             | no   | なし        | ゲーム名ID |      |
