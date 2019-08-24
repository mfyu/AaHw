# == Schema Information
#
# Table name: questions
#
#  id      :bigint           not null, primary key
#  text    :string
#  poll_id :integer
#

class Question < ApplicationRecord

    has_many(:answer_choices, class_name: 'AnswerChoice', foreign_key: :question_id, primary_key: :id)

    belongs_to(:poll, class_name: 'Poll', foreign_key: :poll_id, primary_key: :id)

    has_many :responses, through: :answer_choices, source: :responses

    def results
        answer_choices.select('answer_choices.text, COUNT(responses.id) AS num_responses')
        .left_outer_joins(:responses).group("answer_choices.id")
    end
end

puts results