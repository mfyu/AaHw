# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint           not null, primary key
#  long_url  :string
#  short_url :string
#  user_id   :integer
#

class ShortenedUrl < ApplicationRecord
    require 'securerandom'
    validates :short_url, uniqueness: true

    def self.random_code
        code = SecureRandom.urlsafe_base64
        while ShortenedUrl.exists?(:short_url => code)
            code = SecureRandom.urlsafe_base64
        end
        code
    end

    def self.create_url(user, long_url)
        ShortenedUrl.create!({:long_url => long_url, :short_url => ShortenedUrl.random_code, :user_id=>user.id})
    end

    belongs_to(:submitter, foreign_key: :user_id, primary_key: :id, class_name: :User)
    has_many(:visits,class_name: :Visit, foreign_key: :shortened_url_id, primary_key: :id)

    has_many :visitors, ->{distinct},through: :visits, source: :visitor

    def num_clicks
        visits.count
    end

    def num_uniques
        #visits.where('created_at > ?',10.minutes.ago).select('user_id').distinct.count
        #visitors.distinct.count
        visitors.count
        
    end

    has_many(:tag_topics, class_name: :TagTopic, foreign_key: :shortened_url_id, primary_key: :id)
end
