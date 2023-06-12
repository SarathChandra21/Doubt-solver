class Question < ApplicationRecord
    belongs_to :student
    belongs_to :teacher
    validates :que, presence: true, length:{minimum: 3, maximum: 100}
    validates :ans, length:{ maximum: 1000}
end