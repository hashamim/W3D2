

class QuestionLike
    def self.all
        data = QuestionsDataBase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                QuestionLike
        SQL
        data.map {|datum| Question.new(datum)}
    end
    def initialize
        
    end
end