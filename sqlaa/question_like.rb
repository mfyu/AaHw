require_relative 'questions_database'
require_relative 'question'
require_relative 'user'
require_relative 'reply'
require_relative 'question_follow'

class QuestionLike
    attr_accessor :user_id, :question_id
    attr_reader :id 

    def initialize(options)
        @id, @user_id, @question_id = options.values_at('id','user_id','question_id')
    end

    def self.likers_for_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT * FROM users
        JOIN question_likes ON users.id = question_likes.user_id
        WHERE question_id = ?
        SQL

        data.map {|datum| User.new(datum)}
    end

    def self.num_likes_for_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT COUNT(question_id) FROM users
        JOIN question_likes ON users.id = question_likes.user_id
        WHERE question_id = ?
        SQL
        data.first["COUNT(question_id)"]
    end

    def self.liked_questions_for_user_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT * FROM questions
        JOIN question_likes ON questions.id = question_likes.question_id
        WHERE user_id = ?
        SQL

        data.map {|datum| Question.new(datum)}
    end

    def self.most_liked_questions(n)
        data = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT * FROM question_likes
        JOIN questions ON question_likes.question_id = questions.id
        GROUP BY question_id
        ORDER BY COUNT(question_id) DESC
        LIMIT ?
        SQL

        data.map {|datum| Question.new(datum)}
    end

end