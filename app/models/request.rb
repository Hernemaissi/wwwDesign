class Request < ActiveRecord::Base
  attr_accessible :ad_id
  
  belongs_to :ad
  belongs_to :sender, :class_name => "User"
  
  validates :sender_id, :presence => true
  validates :ad_id, :presence => true
 
end

# == Schema Information
#
# Table name: requests
#
#  id         :integer         not null, primary key
#  sender_id  :integer
#  ad_id      :integer
#  created_at :datetime
#  updated_at :datetime
#

