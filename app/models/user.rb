class User < ActiveRecord::Base
  before_save :default_values
  def default_values
    self.salt ||=  Digest::SHA2.hexdigest("#{Time.now.utc}--")
  end
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  
  has_many :ads, :dependent => :destroy
  has_many :requests, :foreign_key => "sender_id",
                      :dependent => :destroy
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  
  validates_presence_of :password, :on => :create
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
                    
                    
  def self.authenticate_user(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.authenticate(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  def requested?(ad_id)
    self.requests.find_by_ad_id(ad_id)
  end
  
  def request!(hash)
    self.requests.create!(hash)
  end
  
  def remove_request(ad_id)
    self.requests.find_by_ad_id(ad_id).destroy
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  salt            :string(255)
#  admin           :boolean         default(FALSE)
#  notifications   :integer         default(0)
#

