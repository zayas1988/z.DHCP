class Host < ActiveRecord::Base
 require "resolv"
  belongs_to :subnet
  belongs_to :tftp
  attr_accessible :discription, :hostname, :ip, :mac, :tftp_id, :subnet_id
  validates :hostname, presence: true, uniqueness: { case_sensitive: false }
  validates :ip, presence: true, format: { with: Resolv::IPv4::Regex }
  validates :mac, presence: true
  validates :subnet_id, presence: true
  validates :tftp_id, presence: true
  #validates_inclusion_of :usetftp, :in => [true, false]
  default_scope order: 'hosts.ip DESC'
end
