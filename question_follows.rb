require 'Singleton'
require 'SQLite3'
class Question_follows
    attr_accessor :id, :questions_id, :users_id
    def self.all
        data = QuestionsDataBase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                question_follows;
        SQL
        data.map {|datum| Question_follows.new(datum)}
    end
    def self.followers_for_question_id(question_id)
        data = QuestionsDataBase.instance.execute(<<-SQL,question_id)
            SELECT users.* 
            FROM question_follows 
            JOIN users ON question_follows.users_id = users.id 
            WHERE questions_id = ?;
        SQL
    end
    def self.followed_questions_for_user_id(user_id)
        data = QuestionsDataBase.instance.execute(<<-SQL,user_id)
           SELECT questions.* 
           FROM question_follows 
           JOIN questions ON question_follows.questions_id = questions.id 
           WHERE question_follows.users_id = ?;
        SQL
       data.map {|datum| Question.new(datum)}
    end
    def self.most_followed_questions(n)
        data = QuestionsDataBase.instance.execute(<<-SQL, n)
            SELECT questions.* 
            FROM question_follows
            JOIN questions ON questions.id = question_follows.questions_id
            GROUP BY questions.id
            ORDER BY COUNT(questions_id) DESC
            LIMIT(?);
        SQL
        data.map {|datum| Question.new(datum)}
    end
    def initialize(options)
        @id = options['id']
        @questions_id = options['questions_id']
        @users_id= options['users_id']    
    end
    
    
end

