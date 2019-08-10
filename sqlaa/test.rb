require_relative 'questions_database'
require_relative 'question'
require_relative 'user'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'

u = User.find_by_id(4)
#q = Question.new({"title"=>"Test Question", "body"=>"FUCL FCL FUCL", "author_id"=>4})
q = Question.find_by_id(5)


u.lname = "Yu"
u.save
print u