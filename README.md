# テーブル設計

## Users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| email    | string | null: false |
| password | string | null: false |
| name     | string | null: false |

### Association

has_many :items
has_many :orders
has_one :profile

## Profiles テーブル

| Column          | Type     | Options           |
| --------------- | -------- | ----------------- |
| hira_first_name | string   | null: false       |
| hira_last_name  | string   | null: false       |
| kana_first_name | string   | null: false       |
| kana_last_name  | string   | null: false       |
| year_birth      | integer  | null: false       |
| month_birth     | integer  | null: false       |
| day_birth       | integer  | null: false       |
| user_id         | refences | foreign_key: true |

### Association

has_one :user

## Items テーブル

| Column      | Type                 | Options           |
| ----------- | -------------------- | ----------------- |
| name        | string               | null: false       |
| description | text                 | null: false       |
| category    | string               | null: false       |
| state       | string               | null: false       |
| price       | integer              | null: false       |
| image       | ActiveStorage で実装 | null: false       |
| user_id     | refences             | foreign_key: true |

### Association

belongs_to :user
has_one :order
has_one :shipping
has_one_attached :image

## Shippings テーブル

| Column  | Type     | Options           |
| ------- | -------- | ----------------- |
| burden  | string   | null: false       |
| region  | string   | null: false       |
| days    | string   | null: false       |
| item_id | refences | foreign_key: true |

### Association

has_one :item

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

belongs_to :user
has_one :item
has_one :creditcard

## CreditCards テーブル

| Column          | Type     | Options           |
| --------------- | -------- | ----------------- |
| number          | integer  | null: false       |
| exp_year        | integer  | null: false       |
| exp_month       | integer  | null: false       |
| security_number | integer  | null: false       |
| order_id        | refences | foreign_key: true |

### Association

has_one :order
