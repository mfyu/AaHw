# == Schema Information
#
# Table name: users
#
#  id       :bigint           not null, primary key
#  username :string
#

class User < ApplicationRecord
    validates :username, uniqueness: true

    has_many(:responses, class_name: 'Response', foreign_key: :user_id, primary_key: :id)

    has_many(:authored_polls, class_name: 'Poll', foreign_key: :user_id, primary_key: :id)
end
