# テーブル設計

## users テーブル(ユーザー管理機能)

| Column               | Type   | Options                   |
| -----------------    | ------ | ------------------------- |
| nickname             | string | null: false               |
| email                | string | null: false, unique: true |
| encrypted_password   | string | null: false               |
| first_name           | string | null: false               |
| family_name          | string | null: false               |
| read_first           | string | null: false               |
| read_family          | string | null: false               |

### Association (users)
- has_many :items
- has_many :comments
- has_many :item_purchase


## merchandises テーブル(商品情報機能)

| Column     | Type       | Options                       |
| ---------  | ---------- | ----------------------------- |
| title      | string     | null: false                   |
| explanation| text       | null: false                   |
| category   | integer    | null: false                   |
| situation  | integer    | null: false                   |
| load       | integer    | null: false                   |
| region     | integer    | null: false                   |
| days       | integer    | null: false                   |
| price      | integer    | null: false                   |
| user       | references | null: false, foreign_key:true |

### Association (items)
- has_many :comments
- belong_to :user
- active_hash : category
- active_hash : situation
- active_hash : load
- active_hash : region
- active_hash : days
- active_hash : price


## merchandise-purchases テーブル (商品購入機能)

| Column       | Type    | Options                        |
| -------------| --------| -----------------------------  |
| user         | integer | null: false, foreign_key: true |
| merchandise  | integer | null: false, foreign_key: true |
| buyer        | integer | null: false, foreign_key: true |

### Association (merchandise-purchases)
- belong_to :user
- belong_to :merchandise
- belong_to :buyer


## comments テーブル (コメント機能)
| Column      | Type       | Options                        |
| ----------  | ---------- | ------------------------------ |
| content     | string     | null: false                    |
| user        | integer    | null: false, foreign_key: true |
| merchandise | integer    | null: false, foreign_key: true |

### Association (comments)
- belong_to :user
- belong_to :merchandise


## buyers テーブル (購入先機能)

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| card_data            | string     | null: false                    |
| card_day             | string     | null: false                    |
| security_code        | string     | null: false                    |
| post_code            | string     | null: false                    |
| prefectures          | string     | null: false                    |
| building_name        | string     |                                |
| town_name            | string     | null: false                    |
| number               | string     | null: false                    |
| telephone_number     | string     | null: false                    |
| merchandise-purchase | integer    | null: false, foreign_key: true |
| merchandise          | integer    | null: false, foreign_key: true |

### Association (buyers)
- active_hash : merchandise-purchase
- has_one : buyer