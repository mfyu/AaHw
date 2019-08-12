# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  shortened_url_id :integer
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Visit < ApplicationRecord
    validates :user_id, presence: true
    validates :shortened_url_id, presence: true

    def self.record_visit!(user, shortened_url)
        Visit.create!("shortened_url_id"=>shortened_url.id, "user_id"=>user.id)
    end

    belongs_to(:visitor, primary_key: :id, foreign_key: :user_id, class_name: :User)
    belongs_to(:visited_url, primary_key: :id, foreign_key: :shortened_url_id, class_name: :ShortenedUrl)
end
