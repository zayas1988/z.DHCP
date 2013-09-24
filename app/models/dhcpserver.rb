class Dhcpserver < ActiveRecord::Base
  attr_accessible :configpath, :ip, :reloadcommand, :sshport, :sync
  validates :ip, presence: true, format: { with: Resolv::IPv4::Regex }, uniqueness: { case_sensitive: false }
  validates :sshport, presence: true
  validates :configpath, presence: true
  validates :reloadcommand, presence: true
end
