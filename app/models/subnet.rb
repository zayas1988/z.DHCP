class Subnet < ActiveRecord::Base
require "resolv"
  attr_accessible :adress, :broadcast, :domainname, :mask, :nameservers, :routers
  before_save { |subnet| subnet.domainname = domainname.downcase }

  validates :adress, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :broadcast, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :mask, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :routers, presence: true, format: { with: Resolv::IPv4::Regex }
  validates(:domainname, presence: true)
  validates(:nameservers, presence: true)
end
