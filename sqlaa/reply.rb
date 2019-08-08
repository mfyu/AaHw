require_relative 'questions_database'
require_relative 'question'
require_relative 'user'

class Reply
    attr_accessor :question_id, :parent_reply_id, :author_id, :body
    attr_reader :id

    def initialize(options)
        @id, @question_id, @parent_reply_id, @author_id, @body =  
        options.values_at('id','question_id','parent_reply_id','author_id','body')
    end

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * from replies where id=?
        SQL
        
        Reply.new(data.first)
    end

    def self.find_by_user_id(author_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT * from replies where author_id=?
        SQL
        
        Reply.new(data.first)
    end

    def self.find_by_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT * from replies where question_id=?
        SQL
        
        data.map {|datum| Reply.new(datum)}
    end

    def to_s
        {:id=>id, :question_id=>question_id, :parent_reply_id=>parent_reply_id, 
        :author_id=>author_id, :body=>body}.to_s
    end

    def author
        User.find_by_id(author_id)
    end

    def question
        Question.find_by_id(question_id)
    end

    def parent_reply
        raise 'No parent reply' unless parent_reply_id
        Reply.find_by_id(parent_reply_id)
    end

    def child_replies
        QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * FROM replies WHERE parent_reply_id = ?
        SQL
    end

    def save
        if id
            QuestionsDatabase.instance.execute(<<-SQL,question_id, parent_reply_id, author_id, body,id)
            UPDATE replies SET (question_id, parent_reply_id, author_id, body)=(?,?,?,?) 
            WHERE replies.id = ?
            SQL
        else 
            QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_reply_id, author_id, body)
            INSERT INTO users (question_id, parent_reply_id, author_id, body)
            VALUES (?,?,?,?)
            SQL
        end
    end

end

