# テーブル設計

## Users テーブル

| Column              | Type   | Options     |
| ------------------- | ------ | ----------- |
| nickname            | string | null: false |
| email               | string | null: false |
| encrypted_password  | string | null: false |
| first_name          | string | null: false |
| last_name           | string | null: false |
| furigana_first_name | string | null: false |
| furigana_last_name  | string | null: false |
| year_birth          | date   | null: false |
| month_birth         | date   | null: false |
| day_birth           | date   | null: false |

### Association

- has_many :items
- has_many :orders

## Items テーブル

| Column      | Type     | Options           |
| ----------- | -------- | ----------------- |
| name        | string   | null: false       |
| description | text     | null: false       |
| price       | integer  | null: false       |
| category_id | integer  | null: false       |
| state_id    | integer  | null: false       |
| burden_id   | integer  | null: false       |
| region_id   | integer  | null: false       |
| days_id     | integer  | null: false       |
| user_id     | refences | foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_one_attached :image
- belongs_to_active_hash :category
- belongs_to_active_hash :state
- belongs_to_active_hash :burden
- belongs_to_active_hash :region

## Orders テーブル

| Column        | Type     | Options           |
| ------------- | -------- | ----------------- |
| postal_code   | integer  | null: false       |
| region        | string   | null: false       |
| city          | string   | null: false       |
| house_number  | string   | null: false       |
| phone_number  | integer  | null: false       |
| building_name | string   |                   |
| user_id       | refences | foreign_key: true |
| item_id       | refences | foreign_key: true |

### Association

- belongs_to :user
- has_one :item
