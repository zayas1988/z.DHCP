class Dhcpserver < ActiveRecord::Base
  attr_accessible :configpath, :ip, :reloadcommand, :sshport, :sync, :lock, :subnet_ids
  validates :ip, presence: true, format: { with: Resolv::IPv4::Regex }, uniqueness: { case_sensitive: false }
  validates :sshport, presence: true
  validates :configpath, presence: true
  validates :reloadcommand, presence: true
  has_and_belongs_to_many :subnets
  def generate_config
  	Dhcpserver.find(:all) do |server|
  		ff= File.new("/tmp/#{server.ip}","w")
  		ff.puts("#{server.configpath}")
  		ff.puts("#{server.ip}")
  	end
  end

end
