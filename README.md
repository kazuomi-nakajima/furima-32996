# テーブル設計

## Users テーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| first_name          | string | null: false               |
| last_name           | string | null: false               |
| furigana_first_name | string | null: false               |
| furigana_last_name  | string | null: false               |
| birth_date          | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## Items テーブル

| Column             | Type     | Options           |
| ------------------ | -------- | ----------------- |
| name               | string   | null: false       |
| description        | text     | null: false       |
| price              | integer  | null: false       |
| category_id        | integer  | null: false       |
| state_id           | integer  | null: false       |
| burden_id          | integer  | null: false       |
| prefecture_id      | integer  | null: false       |
| delivery_period_id | integer  | null: false       |
| user               | refences | foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_one_attached :image
- belongs_to_active_hash :category
- belongs_to_active_hash :state
- belongs_to_active_hash :burden
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :delivery_period

## Orders テーブル

| Column | Type     | Options           |
| ------ | -------- | ----------------- |
| user   | refences | foreign_key: true |
| item   | refences | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :ordersource

## OrderSources テーブル

| Column         | Type     | Options           |
| -------------- | -------- | ----------------- |
| postal_code    | string   | null: false       |
| prefecture_id  | integer  | null: false       |
| municipalities | string   | null: false       |
| address        | string   | null: false       |
| phone_number   | integer  | null: false       |
| building_name  | string   |                   |
| order          | refences | foreign_key: true |

### Association

- belongs_to :order
- belongs_to_active_hash :prefecture
