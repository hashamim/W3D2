require 'Singleton'
require 'SQLite3'

class Question 
    attr_accessor :id, :title, :body, :author_id
    def self.all
        data = QuestionsDataBase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                questions
        SQL
        data.map {|datum| Question.new(datum)}
    end

    
    def self.find_by_id(id)
        data = QuestionsDataBase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE id = ?
        SQL
        Question.new(data.first)
    end

     def self.find_by_author_id(author_id)
        data = QuestionsDataBase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE author_id = ?
        SQL
        data.map {|datum| Question.new(datum)}
    end

    def self.most_followed(n)
        Question_follows.most_followed_questions(n)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end
    def author
        User.find_by_id(author_id)
    end

    def replies
        Reply.find_by_question_id(id)
    end

    def followers
        Question_follows.followers_for_question_id(id)
    end
end


































# class Question 
#     attr_accessor :id, :title, :body, :author_id
#     def self.all
#         data = QuestionsDataBase.instance.execute(<<-SQL)
#             SELECT
#                 *
#             FROM
#                 questions
#         SQL
#         data.map {|datum| Question.new(datum)}
#     end

    
#     def self.find_by_id(id)
#         data = QuestionsDataBase.instance.execute(<<-SQL, id)
#             SELECT
#                 *
#             FROM
#                 questions
#             WHERE id = ?
#         SQL
#         Question.new(data.first)
#     end

#      def self.find_by_author_id(author_id)
#         data = QuestionsDataBase.instance.execute(<<-SQL, author_id)
#             SELECT
#                 *
#             FROM
#                 questions
#             WHERE author_id = ?
#         SQL
#         data.map {|datum| Question.new(datum)}
#     end

#     def initialize(options)
#         @id = options['id']
#         @title = options['title']
#         @body = options['body']
#         @author_id = options['author_id']
#     end



# end






