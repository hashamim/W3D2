require 'Singleton'
require 'SQLite3'


class User
    attr_accessor :id, :fname, :lname
    def self.all
        data = QuestionsDataBase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                users;
        SQL
        data.map {|datum| User.new(datum)}
    end
    def self.find_by_id(id)
        data = QuestionsDataBase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE id = ?
        SQL
        User.new(data.first)
    end
    def self.find_by_name(fname, lname)
        data = QuestionsDataBase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? AND lname = ?
        SQL
        User.new(data.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']    
    end
    def authored_questions
        Question.find_by_author_id(id)
    end
    def authored_replies
        Reply.find_by_user_id(id)
    end
    
    def followed_questions
        Question_follows.followed_questions_for_user_id(id)
    end
end