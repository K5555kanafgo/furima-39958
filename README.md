# テーブル設計

## users テーブル

| Column               | Type   | Options                   |
| -----------------    | ------ | ------------------------- |
| nickname             | string | null: false               |
| email                | string | null: false, unique: true |
| password             | string | null: false               |
| password_confirmation| string | null: false               |
| user_name1           | string | null: false               |
| user_name2           | string | null: false               |
| position             | string | null: false               |

has_many
items
comments

## items テーブル

| Column     | Type       | Options                       |
| ---------  | ---------- | ----------------------------- |
| title      | string     | null: false                   |
| explanation| text       | null: false                   |
| category   | text       | null: false                   |
| situation  | text       | null: false                   |
| load       | text       | null: false                   |
| region     | text       | null: false                   |
| days       | text       | null: false                   |
| price      | text       | null: false                   |
| user       | references | null: false, foreign_key:true |
| purchase   | references | null: false, foreign_key:true |

belong_to
user
purchase

has_many
comments

## purchases テーブル

| Column     | Type       | Options                       |
| ---------  | ---------- | ----------------------------- |
| title      | string     | null: false                   |
| category   | text       | null: false                   |
| situation  | text       | null: false                   |
| load       | text       | null: false                   |
| region     | text       | null: false                   |
| days       | text       | null: false                   |

has_one
item