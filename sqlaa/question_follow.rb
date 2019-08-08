require_relative 'questions_database'
require_relative 'question'
require_relative 'user'
require_relative 'reply'
class QuestionFollow
    attr_accessor :user_id, :question_id
    attr_reader :id 

    def initialize(options)
        @id, @user_id, @question_id = options.values_at('id','user_id','question_id')
    end
    
    def self.followers_for_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT * from users
        JOIN question_follows ON  users.id = question_follows.user_id
        WHERE question_id = ?
        SQL

        data.map {|datum| User.new(datum)}
    end

    def self.followed_questions_for_user_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT * from questions
        JOIN question_follows ON  questions.id = question_follows.question_id
        WHERE user_id = ?
        SQL

        data.map {|datum| Question.new(datum)}
    end


    def self.most_followed_questions(n)
        data = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT * from question_follows
        JOIN questions ON question_follows.question_id=questions.id
        GROUP BY question_id
        ORDER BY COUNT(question_id) desc
        LIMIT ?
        SQL

        data.map {|datum| Question.new(datum)}
        
    end

    #def self.likers_for_question_id(question_id)

    

end