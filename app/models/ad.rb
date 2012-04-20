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
  
  
  scope :available, :conditions => {:available => true}

  #scope :with_part, lambda { |part_id| { :joins => :parts, 
  #                                           :conditions => {:parts => {:id => part_id} } } }

  

  
  def self.price_lower(price)
    where("price < ?", price)
  end
  
  def self.price_higher(price)
    where("price > ?", price)
  end
  
  def self.price_between(low, high)
    where("price BETWEEN ? AND ?", low, high)
  end
  
  def self.in_categories(ids)
     joins(:category).where("category_id IN (?)", ids)
  end

  def self.with_parts(ids)
     joins(:parts).where("part_id = ?", ids)
     #joins(:parts).where("part_id IN (?)", ids)
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
#  color       :string(255)
#  condition   :string(255)
#  size        :string(255)
#  material    :string(255)
#  category_id :integer
#

