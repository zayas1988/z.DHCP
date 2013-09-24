class Host < ActiveRecord::Base
 require "resolv"
 require "ipaddr"
  belongs_to :subnet
  belongs_to :tftp
  attr_accessible :discription, :hostname, :ip, :mac, :tftp_id, :subnet_id
  validates :hostname, presence: true, uniqueness: { case_sensitive: false }
  validates :ip, presence: true, format: { with: Resolv::IPv4::Regex }, uniqueness: { case_sensitive: false }
  validates :mac, presence: true
  validates :subnet_id, presence: true
  validates :tftp_id, presence: true
  #validates_inclusion_of :usetftp, :in => [true, false]
  default_scope order: 'hosts.ip DESC'
  validate :uniqmacsubnet
  validate :subnetinclude
  def uniqmacsubnet
    host = Host.find_by_mac(self.mac)
    if !(host == nil)
      if (self.subnet_id == host.subnet_id) && !(self.id == host.id)
        errors.add :mac, "must be only one in subnet"
      end
    end
  end
  def subnetinclude
    net=IPAddr.new("#{self.subnet.adress}/#{self.subnet.mask}")
    ip=IPAddr.new("#{self.ip}")
    if !net.include?(ip)
      errors.add :ip, "must be on chosen subnet"
      errors.add  :ip, "#{net} #{ip}"
    end
  end
  def setlastping
    @host = Host.find(params[:id])
    @host.lastping = Date.current
  end
end
