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
|family_name|string|null: false|
|first_name|string|null: false|
|furigana_family|string|null: false|
|furigana_first|string|null: false|
|birthday|date|null: false|
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
- belongs_to :prefecture
- has_one :payment
- has_many :goods
- has_many :likes
- has_many :goods_likes, through: :likes, source: :good
- has_many :comments
- has_many :goods_comments, through: :comments, source: :good
- has_many :trannsactions
- has_many :goods_transactions, through: :transactions, source: :good

## goodsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|explanation|text|null: false|
|first_category_id|integer|null: false, foreign_key: true|
|second_category_id|integer|null: false, foreign_key: true|
|third_category_id|integer|null: false, foreign_key: true|
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
- belongs_to :first_category
- belongs_to :second_category
- belongs_to :third_category 
- belongs_to :size
- belongs_to :brand
- belongs_to :condition
- belongs_to :derivery_cost
- belongs_to :derivery_day
- belongs_to :transaction_status
- belongs_to :prefecture
- has_one :transaction
- has_one :user, through: :transactions
- has_one :payment, through: :transactions
- has_many :images
- has_many :likes
- has_many :users_likes, through: :likes, source: :user
- has_many :comments
- has_many :users_comments, through: :comments, source: :user

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

## prefecturesテーブル
|Column|Type|Options|
|------|----|-------|
|prefecture|string|null: false, unique: true|
### Association
- has_many :users
- has_many :goods

## first_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false unique: true|
### Association
- has_many :goods
- has_many :brands
- has_many :second_categories

## second_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false unique: true|
|first_category_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :first_category
- has_many :goods
- has_many :third_categories

## third_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false unique: true|
|second_category_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :second_category
- has_many :goods

## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size|string|null: false unique: true|
### Association
- has_many :goods

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false unique: true|
|first_category_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :first_category
- has_many :goods

## conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|condition|string|null: false unique: true|
### Association
- has_many :goods

## derivery_costテーブル
|Column|Type|Options|
|------|----|-------|
|derivery_cost|string|null: false unique: true|
### Association
- has_many :goods

## derivery_dayテーブル
|Column|Type|Options|
|------|----|-------|
|derivery_day|string|null: false unique: true|
### Association
- has_many :goods

## transaction_statusテーブル
|Column|Type|Options|
|------|----|-------|
|transaction_status|string|null: false unique: true|
### Association
- has_many :goods

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
