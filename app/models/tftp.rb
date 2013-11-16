class Tftp < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :config, :group, :image, :pathtoconfig, :pathtoimage, :configfilename
=======
  attr_accessible :config, :group, :image, :pathtoconfig, :pathtoimage. :configfilename
>>>>>>> 44aa016923a542791ea88bb012c53f80b5f0fb18
  has_many :hosts
  validates(:image, presence: true)
  validates(:group, presence: true)
  validates(:config, presence: true)
  validates(:pathtoconfig, presence: true)
  validates(:pathtoimage, presence: true)
  calidates(:configfilename, presence: true)
  end
