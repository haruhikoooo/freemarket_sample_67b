# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|
### Association
- has_one :payment, dependent: :destroy
- has_one :address, dependent: :destroy
- has_one :identification, dependent: :destroy
- has_many :goods, dependent: :destroy
- has_many :likes
- has_many :goods_likes, through: :likes, source: :good, dependent: :destroy
- has_many :comments
- has_many :goods_comments, through: :comments, source: :good, dependent: :destroy
- has_many :trannsactions
- has_many :goods_transactions, through: :transactions, source: :good, dependent: :destroy

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|destination_family_name|string|null: false|
|destination_first_name|string|null: false|
|destination_furinaga_family|string|null: false|
|destination_furinaga_first|string|null: false|
|zipcode|string|null: false|
|prefecture_id|integer|null: false, foreign_key: true|
|city|string|null: false|
|house_number|string|null: false|
|apartment_name|string||
|tel|string||
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture

## identificationsテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|furigana_family|string|null: false|
|furigana_first|string|null: false|
|birthday|date|null: false|
### Association
- belongs_to :user

## goodsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|explanation|text|null: false|
|category_id|integer|null: false, foreign_key: true|
|size_id|integer|null: false, foreign_key: true|
|brand_id|integer|foreign_key: true|
|condition|integer|null: false, foreign_key: true|
|prefecture_id|integer|null: false, foreign_key: true|
|derivery_day|integer|null: false, foreign_key: true|
|price|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|transaction_status_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :category
- belongs_to_active_hash :size
- belongs_to :brand
- belongs_to_active_hash :condition
- belongs_to_active_hash :derivery_cost
- belongs_to_active_hash :derivery_day
- belongs_to_active_hash :transaction_status
- belongs_to_active_hash :prefecture
- has_one :transaction
- has_one :user, through: :transactions, dependent: :destroy
- has_one :payment, through: :transactions, dependent: :destroy
- has_many :images, dependent: :destroy
- has_many :likes
- has_many :users_likes, through: :likes, source: :user, dependent: :destroy
- has_many :comments
- has_many :users_comments, through: :comments, source: :user, dependent: :destroy

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|good_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :good

## transactionsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|good_id|integer|null: false, foreign_key: true|
|payment_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :good
- belongs_to :user
- belongs_to :payment

## paymentsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|string|null: false, unique: true|
|expiration_date_month|string|null: false|
|expiration_date_year|string|null: false|
|security_code|string|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- has_many :transactions

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|good_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :good

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|good_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :good

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false unique: true|
|ancestry|string|null: false unique: true|
### Association
- has_many :goods
- has_many :brands

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false unique: true|
|category_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :category
- has_many :goods

## active_hash
- prefecture
- size
- condition
- derivery_cost
- derivery_day
- transaction_status


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
