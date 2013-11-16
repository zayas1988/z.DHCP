class Tftp < ActiveRecord::Base
  attr_accessible :config, :group, :image, :pathtoconfig, :pathtoimage, :configfilename
  has_many :hosts
  validates(:image, presence: true)
  validates(:group, presence: true)
  validates(:config, presence: true)
  validates(:pathtoconfig, presence: true)
  validates(:pathtoimage, presence: true)
  calidates(:configfilename, presence: true)
  end
