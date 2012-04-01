class Part < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :ads
  validates :name, :uniqueness => true
end
