class Doctor < ApplicationRecord
  def test
    "111 #{ name }"
  end
end