class Part < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :ads
  validates :name, :uniqueness => true
end

# == Schema Information
#
# Table name: parts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

