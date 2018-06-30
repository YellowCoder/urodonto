class Doctor < ApplicationRecord
  acts_as_paranoid
  
  def test
    "111 #{ name }"
  end
end