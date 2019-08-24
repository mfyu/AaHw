# == Schema Information
#
# Table name: polls
#
#  id      :bigint           not null, primary key
#  title   :string
#  user_id :integer
#

class Poll < ApplicationRecord
    belongs_to(:author, class_name: 'User', primary_key: :id, foreign_key: :user_id)
end
