class Tftp < ActiveRecord::Base
  attr_accessible :config, :group, :image
  validates(:image, presence: true)
  validates(:group, presence: true)
  validates(:config, presence: true)

end
