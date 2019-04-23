require 'Singleton'
require 'SQLite3'

class Reply
    attr_accessor :id, :questions_id, :parent_reply_id, :users_id, :body
    def self.all
        data = QuestionsDataBase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                replies;
        SQL
        data.map {|datum| Reply.new(datum)}
    end

     def self.find_by_user_id(users_id)
        data = QuestionsDataBase.instance.execute(<<-SQL, users_id)
            SELECT
                *
            FROM
                replies
            WHERE users_id = ?
        SQL
        data.map {|datum| Reply.new(datum)}
    end
    def self.find_by_question_id(questions_id)
        data = QuestionsDataBase.instance.execute(<<-SQL, questions_id)
            SELECT
                *
            FROM
                replies
            WHERE questions_id = ?
        SQL
        data.map {|datum| Reply.new(datum)}
    end

    def self.find_by_id(id)
        data = QuestionsDataBase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE id = ?
        SQL
        Reply.new(data.first)
    end

    def initialize(options)
        @id = options['id']
        @questions_id = options['questions_id']
        @parent_reply_id = options['parent_reply_id']   
        @users_id = options['users_id']
        @body = options['body']
    end

   def author
        User.find_by_id(users_id)
   end

   def question
        Question.find_by_id(questions_id)
   end

   def parent_reply
        if parent_reply_id.nil?
            return nil
        else
            Reply.find_by_id(parent_reply_id)
        end
   end

   def child_replies
        data = QuestionsDataBase.instance.execute(<<-SQL, id)
            SELECT 
                *
            FROM 
                replies
            WHERE 
                parent_reply_id = ?

        SQL
        data
   end

end