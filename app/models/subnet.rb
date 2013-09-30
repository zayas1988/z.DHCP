class Subnet < ActiveRecord::Base
require "resolv"
  attr_accessible :adress, :broadcast, :domainname, :mask, :nameservers, :routers, :dhcpserver_ids, :nextserver, :guest
  before_save { |subnet| subnet.domainname = domainname.downcase }
  has_many :hosts, dependent: :destroy
  has_and_belongs_to_many :dhcpservers
  validates :adress, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :broadcast, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :mask, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :routers, presence: true, format: { with: Resolv::IPv4::Regex }
  validates(:domainname, presence: true)
  validates(:nameservers, presence: true)
def subnet_prefix
    prefix=self.adress.split(".")
    return "#{prefix[0]}.#{prefix[1]}.#{prefix[2]}."
end
def freeips
  free=Array.new
  (1..254).to_a.each do |ip|
    searchip="#{self.subnet_prefix}#{ip}"
    #p self.hosts.find_by_ip(searchip)
    if self.hosts.find_by_ip(searchip).nil?
      p ip
      free.push(searchip)
    end
    return free if free.length == 5
  end
  return free
end

end
