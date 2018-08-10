class User < ApplicationRecord
  # Extensions
  acts_as_paranoid
  has_paper_trail
  enum role: [:user, :admin]
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, 
    :trackable, :validatable, :registerable
end
