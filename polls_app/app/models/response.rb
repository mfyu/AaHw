# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#

class Response < ApplicationRecord
    validate :not_duplicate_response, unless: -> {answer_choice.nil?}
    belongs_to(:answer_choice, class_name: 'AnswerChoice', foreign_key: :answer_choice_id, primary_key: :id)
    
    belongs_to(:respondent, class_name: 'User', foreign_key: :user_id, primary_key: :id)

    has_one(:question, through: :answer_choice, source: :question)

    def sibling_responses
        question.responses.where.not(id: self.id)
    end

    def respondent_already_answered?
        sibling_responses.exists?(user_id: self.user_id)
    end

    def respondent_is_not_poll_author
        poll_author_id = self.answer_choice.question.poll.user_id

        if (poll_author_id == user_id)
            errors[:user_id] << 'cannot be poll author'
        end
    end
end
