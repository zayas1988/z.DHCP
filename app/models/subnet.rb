class Subnet < ActiveRecord::Base
require "resolv"
  attr_accessible :adress, :broadcast, :domainname, :mask, :nameservers, :routers, :dhcpserver_ids, :nextserver, :guest, :range, :rangemax, :leasetime
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

def importsubnet(sub)
  ips =  %x(cat ../../../allcomps2 | grep "#{sub}" | while read line; do echo $line; done)
  puts "#{ips}"
  ip=ips.split("|")
  i=1
  begin
    puts "mac:  #{ip[1+i]} ip: #{ip[2+i]} hostname: #{ip[3+i]} tftp: #{ip[4+i]} discr:  #{ip[5+i]}"
    @newhost = Subnet.find_by_adress("192.168.177.0").hosts.new(:hostname => ip[3+i], :ip => ip[2+i], :mac => ip[1+i], :discription => ip[5+i], :tftp_id => Tftp.find_by_image(ip[4+i]).id)
    #ip: nil, mac: nil, discription: nil, tftp_id: nil, subnet_id: 2, created_at: nil, updated_at: nil, lastping: nil
    i+=7
  end while i < ip.length
end

end
