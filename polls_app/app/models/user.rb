class User < ApplicationRecord
    validates :username, uniqueness: true

    :belongs_to(:poll, class_name: 'Poll', primary_key: :id, foreign_key: :user_id)
end