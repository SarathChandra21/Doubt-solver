class Student < ApplicationRecord
    before_save { self.email = email.downcase }
    has_many :questions, dependent: :destroy
    has_many :student_topics
    has_many :topics, through: :student_topics
    validates :name, presence: true, 
                     uniqueness: { case_sensitive: false }, 
                     length: {minimum: 3, maximum: 25}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                      uniqueness: { case_sensitive: false },   
                      length: { maximum: 105},
                      format: { with: VALID_EMAIL_REGEX}
    has_secure_password
end