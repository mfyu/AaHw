require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'
class User
    attr_accessor :fname, :lname
    attr_reader :id
    
    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def self.find_by_name(fname, lname)
        data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT * from users where fname = ? and lname = ?
        SQL
        
        User.new(data.first)
    end

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * from users where id=?
        SQL
        
        User.new(data.first)
    end

    def authored_questions
        Question.find_by_author_id(id)
    end

    def authored_replies
        Reply.find_by_user_id(id)
    end

    def to_s
        {"id"=>id, "fname"=>fname, "lname"=>lname}.to_s
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(id)
    end

    def liked_questions
        QuestionLike.likes_questions_for_user_id(id)
    end

    def average_karma
        num_likes.to_f/num_questions
    end

    def num_questions
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT COUNT(author_id) from questions where author_id=?
        SQL
        data.first['COUNT(author_id)']
    end

    def num_likes
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT COUNT(question_id) FROM users
        JOIN question_likes ON users.id = question_likes.user_id
        WHERE question_id IN (SELECT id from questions where questions.author_id = ?)
        SQL
        data.first['COUNT(question_id)']
    end

    def save
        if id
            QuestionsDatabase.instance.execute(<<-SQL, fname,lname, id)
            UPDATE users SET (fname, lname)=(?,?) 
            WHERE users.id = ?
            SQL
        else 
            QuestionsDatabase.instance.execute(<<-SQL, fname,lname)
            INSERT INTO users (fname, lname)
            VALUES (?,?)
            SQL
        end
    end
end


