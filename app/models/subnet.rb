class Subnet < ActiveRecord::Base
require "resolv"
  attr_accessible :adress, :broadcast, :domainname, :mask, :nameservers, :routers
  before_save { |subnet| subnet.domainname = domainname.downcase }
  has_many :hosts, dependent: :destroy
  validates :adress, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :broadcast, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :mask, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :routers, presence: true, format: { with: Resolv::IPv4::Regex }
  validates(:domainname, presence: true)
  validates(:nameservers, presence: true)
def subnet_prefix
    prefix=self.adress.split(".")
    return "#{prefix[1]}.#{prefix[2]}.#{prefix[3]}."
end
end
