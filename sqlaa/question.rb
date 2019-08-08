require_relative 'questions_database'
require_relative 'user'
require_relative 'question_follow'
require_relative 'question_like'

class Question
    attr_accessor :title, :body, :author_id
    attr_reader :id
    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * from questions WHERE questions.id = ?
        SQL

        Question.new(data.last)
    end

    def self.find_by_author_id(author_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT * from questions where questions.author_id = ?
        SQL

        data.map {|datum| Question.new(datum)}
    end

    def to_s
        {"id"=>id,"title"=> title, "body"=>body, "author_id"=>author_id}.to_s
    end

    def author
        User.find_by_id(author_id)
    end

    def replies
        Reply.find_by_question_id(id)
    end

    def followers
        QuestionFollow.followers_for_question_id(id)
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def likers
        QuestionLike.likers_for_question_id(id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(id)
    end

    def self.most_liked(n)
        data = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT * FROM question_likes
        JOIN questions ON question_likes.question_id = questions.id
        GROUP BY question_id
        ORDER BY COUNT(question_id) DESC
        LIMIT ?
        SQL

        data.map {|datum| Question.new(datum)}
    end

    def save
        if id
            QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id, id)
            UPDATE questions SET (title, body, author_id)=(?,?,?) 
            WHERE questions.id = ?
            SQL
        else 
            QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id)
            INSERT INTO questions (title, body, author_id)
            VALUES (?,?,?)
            SQL
        end
    end

    

end

