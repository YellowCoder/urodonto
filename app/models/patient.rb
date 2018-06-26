class Patient < ApplicationRecord
  has_many :events

  validates :name, presence: true

  def test
    "111 #{ name }"
  end
end