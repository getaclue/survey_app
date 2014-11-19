class Survey < ActiveRecord::Base
  # association
  belongs_to :user
  
  # validates presence of user_id and title
  validates :user_id, presence: true
  validates :title, presence: true
end
