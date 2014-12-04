class User < ActiveRecord::Base
  ############################################
  # Followed some parts of the book from 
  # www.railstutorial.org/book
  ############################################
  
  # ensure email is lower cased
  before_save { self.email = email.downcase }
  
  # one to many association to surveys
  # destroy surveys upon deletion of user
  has_many :surveys, inverse_of: :user, 
                      dependent: :destroy
  
  # confirms the email format
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # validates presence name, email, age, and sex of a user
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: {case_sensitive: false}
  validates :age, presence: true
  validates :sex, presence: true
  validates :password, length: { minimum: 4 }
  
  # adding a hash function for the password
  has_secure_password
end
