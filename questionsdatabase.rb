require 'Singleton'
require 'SQLite3'
require_relative 'question.rb'
require_relative 'reply.rb'
require_relative 'user.rb'
require_relative 'question_follows.rb'
class QuestionsDataBase < SQLite3::Database
    include Singleton
    def initialize
        super("questions.db")
        self.type_translation = true
        self.results_as_hash = true
    end
end








