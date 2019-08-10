# == Schema Information
#
# Table name: people
#
#  id       :bigint           not null, primary key
#  name     :string
#  house_id :integer
#

class Person < ApplicationRecord
    #validates :name, presence: true

    belongs_to(:house, {class_name: :House, foreign_key: :house_id, primary_key: :id})
end
