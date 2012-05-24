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
  validates :price, :presence => true, :numericality => true
  validates :title, :presence => true
  validates :condition, :presence => true
  validates :size, :presence => true
  
  
  scope :available, :conditions => {:available => true}

  def self.price_lower(price)
    where("price < ?", price)
  end
  
  def self.price_higher(price)
    where("price > ?", price)
  end
  
  def self.price_between(low, high)
    where("price BETWEEN ? AND ?", low, high)
  end
  
  def self.find_ads_by_categories(category_ids)
    joins(:category).where("category_id IN (?)", category_ids)
  end

  def self.find_ads_by_parts(part_ids)
    #joins(:parts).select("DISTINCT(ads.id), ads.*").where("parts.id in (?)", part_ids).having("count(*)=#{part_ids.size}")
    joins(:parts).select("ads.*").group("ads.id, ads.description, ads.created_ad, ads.image_url, ads.price, ads.available, ads.title, ads.color, ads.material, ads.size, ads.condition").where("parts.id in (?)", part_ids).having("count(*)=#{part_ids.size}")
    #joins(:parts).select("DISTINCT(ads.id), ads.*").where("parts.id in (?)", part_ids)
  end

  def self.in_condition(condition)
    where("condition = ?", condition)
  end
  
  def self.in_color(color)
    where("color = ?", color)
  end

end

# == Schema Information
#
# Table name: ads
#
#  id          :integer         not null, primary key
#  description :string(255)
#  image_url   :string(255)
#  price       :decimal(, )
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

