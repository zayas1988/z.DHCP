class Host < ActiveRecord::Base
 require "resolv"
  belongs_to :subnet
  belongs to :tftp
  attr_accessible :discription, :hostname, :ip, :mac, :subnet_id, :tftp_id, :usetftp
  validates :hostname, presence: true, uniqueness: { case_sensitive: false }
  validates :ip, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :mac, presence: true
  validates :subnet_id, presence: true
  validates :tftp_id, presence: true
  validates :usetftp, presence: true
end
