class Doctor < ApplicationRecord
  # Extensions
  has_paper_trail
  acts_as_paranoid
end