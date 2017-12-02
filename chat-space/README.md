## usersテーブル

|Column|Type|Options|
|------|----|------|
|name|string|null: false,add_index|
|password|text|null: false|
|email|text|null: false|

### association
- has_many :messages
- has_many :groups, through: :members
- has_many :members

## groupテーブル

|Column|Type|Options|
|------|----|------|
|name|string|null: false|

### association

- has_many :messages
- has_many :users, through: members
- has_many :members

## messageテーブル
|Column|Type|Options|
|------|----|------|
|body|text||
|image|string||
|user_id|string|null: false|foreign_key: true|
|group_id|string|null: false|foreign_key: true|

### association
- belongs_to :user
- belongs_to :group

## membersテーブル
|Column|Type|Option|
|------|----|------|
|user_id|integer|null: false,foreign_key: true|
|group_id|integer|null: false,foreign_key: true|

### association
- belongs_to :user
- belongs_to :group
