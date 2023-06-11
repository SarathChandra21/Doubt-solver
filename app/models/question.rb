class Question < ApplicationRecord
    validates :que, presence: true, length:{minimum: 3, maximum: 100}
    validates :ans, length:{ maximum: 1000}
end