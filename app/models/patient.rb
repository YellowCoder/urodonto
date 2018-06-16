class Patient < ApplicationRecord
  validates :name, presence: true

  def test
    "111 #{ name }"
  end
end