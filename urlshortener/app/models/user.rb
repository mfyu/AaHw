# == Schema Information
#
# Table name: users
#
#  id    :bigint           not null, primary key
#  email :string
#

class User < ApplicationRecord
    validates :email, presence: true
    validates :email, uniqueness: true
    has_many(:visits,class_name: :Visit, foreign_key: :user_id, primary_key: :id)

    has_many(:submitted_urls,class_name: :ShortenedUrl, foreign_key: :user_id, primary_key: :id)

    

    has_many :visited_urls, through: :visits, source: :visited_url


end
