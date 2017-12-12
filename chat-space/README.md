## usersテーブル

|Column|Type|Options|
|------|----|------|
|name|string|null: false,add_index|

### association
- has_many :messages
- has_many :groups, through: :members
- has_many :members

## groupsテーブル

|Column|Type|Options|
|------|----|------|
|name|string|null: false|

### association

- has_many :messages
- has_many :users, through: members
- has_many :members

## messagesテーブル
|Column|Type|Options|
|------|----|------|
|body|text||
|image|string||
|user_id|string|null: false|foreign_key: true|
|group_id|string|null: false|foreign_key: true|

### association
- belongs_to :user
- belongs_to :group

## group_usersテーブル
|Column|Type|Option|
|------|----|------|
|user_id|integer|null: false,foreign_key: true|
|group_id|integer|null: false,foreign_key: true|

### association
- belongs_to :user
- belongs_to :group
