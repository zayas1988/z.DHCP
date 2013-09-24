class Tftpserver < ActiveRecord::Base
  attr_accessible :ip, :sshport, :sync, :tftppath
  validates :ip, presence: true, format: { with: Resolv::IPv4::Regex }, uniqueness: { case_sensitive: false }
  validates :sshport, presence: true
  validates :tftppath, presence: true
end
