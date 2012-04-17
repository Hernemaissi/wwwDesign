class Ad < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :available, :title, :color, :material, :size, :condition, :category_id, :part_ids
  
  belongs_to :user
  has_many :requests, :dependent => :destroy
  belongs_to :category
  has_and_belongs_to_many :parts
  default_scope :order => 'ads.created_at DESC'
  
  validates :description, :length => { :maximum => 300 }
  validates :user_id, :presence => true
  validates :category_id, :presence => true
  validates :image_url, :presence => true
  validates :price, :presence => true
  validates :title, :presence => true
  validates :condition, :presence => true
  validates :size, :presence => true
  
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end


end

# == Schema Information
#
# Table name: ads
#
#  id          :integer         not null, primary key
#  description :string(255)
#  image_url   :string(255)
#  price       :string(255)
#  available   :boolean         default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  title       :string(255)
#

