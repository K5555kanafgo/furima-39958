# テーブル設計 #

## users テーブル(ユーザー管理機能)

| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| first_name          | string | null: false               |
| family_name         | string | null: false               |
| read_first          | string | null: false               |
| read_family         | string | null: false               |
| birthday            | date   | null: false               |

### Association (users)
- has_many :items
- has_many :comments
- has_many :item_purchases


## items テーブル(商品情報機能)

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| explanation        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| situation_id       | integer    | null: false                    |
| load_id            | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| number_of_day_id   | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association (items)
- has_many    : comments
- belongs_to  : user
- has_one     : item_purchase
- active_hash : category_id
- active_hash : situation_id
- active_hash : load_id
- active_hash : prefecture_id
- active_hash : number_of_day_id


## item_purchases テーブル (商品購入機能)

| Column   | Type       | Options                        |
| ---------| -----------| -----------------------------  |
| user     | references | null: false, foreign_key: true |
| item     | references | null: false, foreign_key: true |

### Association (item-purchases)
- belongs_to : user
- belongs_to : item
- has_one    : buyer


## comments テーブル (コメント機能)
| Column    | Type        | Options                        |
| ----------| ------------| ------------------------------ |
| content   | string      | null: false                    |
| user      | references  | null: false, foreign_key: true |
| item      | references  | null: false, foreign_key: true |

### Association (comments)
- belongs_to : user
- belongs_to : item


## buyers テーブル (購入先機能)

| Column             | Type        | Options                        |
| -------------------| ----------- | ------------------------------ |
| post_code          | string      | null: false                    |
| prefecture_id      | integer     | null: false                    |
| town_name          | string      | null: false                    |
| number             | string      | null: false                    |
| telephone_number   | string      | null: false                    |
| building_name      | string      |                                |
| item_purchase      | references  | null: false, foreign_key: true |


### Association (buyers)
- belongs_to : item-purchase