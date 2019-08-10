# == Schema Information
#
# Table name: houses
#
#  id      :bigint           not null, primary key
#  address :string
#

class House < ApplicationRecord
    validates :address, presence: true

    has_many(
    :residents,
    class_name: :Person,
    foreign_key: :house_id,
    primary_key: :id)

    # def ppl
    #     Person.where({house_id: self.id})
    # end
end

