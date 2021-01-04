# テーブル設計

## Users テーブル

| Column   | Type   | Options  |
| -------- | ------ | -------- |
| email    | string | not null |
| password | string | not null |
| name     | string | not null |

### Association

has_many :items
has_many :orders
has_one :profile

## Profiles テーブル

| Column          | Type     | Options           |
| --------------- | -------- | ----------------- |
| hira_first_name | string   | not null          |
| hira_last_name  | string   | not null          |
| kana_first_name | string   | not null          |
| kana_last_name  | string   | not null          |
| year_birth      | integer  | not null          |
| month_birth     | integer  | not null          |
| day_birth       | integer  | not null          |
| user_id         | refences | foreign_key: true |

### Association

has_one :user

## Items テーブル

| Column      | Type                 | Options           |
| ----------- | -------------------- | ----------------- |
| name        | string               | not null          |
| description | text                 | not null          |
| category    | string               | not null          |
| state       | string               | not null          |
| price       | integer              | not null          |
| image       | ActiveStorage で実装 | not null          |
| user_id     | refences             | foreign_key: true |

### Association

belongs_to :user
has_one :order
has_one :shipping
has_one_attached :image

## Shippings テーブル

| Column  | Type     | Options           |
| ------- | -------- | ----------------- |
| burden  | string   | not null          |
| region  | string   | not null          |
| days    | string   | not null          |
| item_id | refences | foreign_key: true |

### Association

has_one :item

## Orders テーブル

| Column        | Type     | Options           |
| ------------- | -------- | ----------------- |
| postal_code   | integer  | not null          |
| region        | string   | not null          |
| city          | string   | not null          |
| house_number  | string   | not null          |
| phone_number  | integer  | not null          |
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
| number          | integer  | not null          |
| exp_year        | integer  | not null          |
| exp_month       | integer  | not null          |
| security_number | integer  | not null          |
| order_id        | refences | foreign_key: true |

### Association

has_one :order
