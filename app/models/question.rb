class Question < ApplicationRecord
    belongs_to :student
    belongs_to :teacher
    has_many :question_topics
    has_many :topics, through: :question_topics, dependent: :destroy
    validates :que, presence: true, length:{minimum: 3, maximum: 1000}
    validates :ans, length:{ maximum: 2000}
end