class Tftp < ActiveRecord::Base
  attr_accessible :config, :group, :image
  has_many :hosts
  validates(:image, presence: true)
  validates(:group, presence: true)
  validates(:config, presence: true)
 
end
