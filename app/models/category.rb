class Category < ActiveRecord::Base
  has_ancestry
  has_and_belongs_to_many :parts
  has_many :ads
  
  def self.json_tree(nodes)
    nodes.map do |node, sub_nodes|
      {:name => node.name, :id => node.id, :children => json_tree(sub_nodes).compact } 
    end
  end

end

# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  ancestry   :string(255)
#  ad_id      :integer
#

