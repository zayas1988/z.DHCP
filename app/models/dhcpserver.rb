class Dhcpserver < ActiveRecord::Base
  require "resolv"
  attr_accessible :configpath, :ip, :reloadcommand, :sshport, :sync, :lock, :subnet_ids
  validates :ip, presence: true, format: { with: Resolv::IPv4::Regex }, uniqueness: { case_sensitive: false }
  validates :sshport, presence: true
  validates :configpath, presence: true
  validates :reloadcommand, presence: true
  has_and_belongs_to_many :subnets
  
  def generate_config
  	Dhcpserver.find(:all) do |server|
  		ff= File.new("/tmp/#{server.ip}","w")
  		ff.puts("allow bootp;
allow booting;
default-lease-time 1000000;
max-lease-time 1000000;
ddns-update-style interim;
authoritative;

")
      server.subnets.each do |subnet|
        ff.puts("subnet #{subnet.adress} netmask #{subnet.mask} {
option subnet-mask #{subnet.mask}
option broadcast-address #{subnet.adress};
option routers #{subnet.routers};
option domain-name-servers #{subnet.nameservers};
")
        if !(!subnet.range.nil? || !subnet.range.empty?)
          ff.puts("range #{subnet.range} #{subnet.rangemax};")
        end
        if !(!subnet.leasetime.nil? || !subnet.leasetime.empty?)
          ff.puts("max-lease-time #{subnet.leasetime};
default-lease-time #{subnet.leasetime};")
        end
        if !subnet.guest?
          ff.puts("
option domain-name \"#{subnet.domainname}\";
option netbios-node-type 2;
option netbios-name-servers #{subnet.nameservers};
next-server #{subnet.nextserver};
}
        
")
        else
          ff.puts("
            }")
        end
        subnet.hosts.each do |host|
          mac=host.mac.downcase.split("-")
          ff.puts("host #{host.hostname} {
hardware ethernet #{mac[0]}:#{mac[1]}:#{mac[2]}:#{mac[3]}:#{mac[4]}:#{mac[5]};
fixed-address #{host.ip};
filename \"#{host.tftp.pathtoimage}#{host.tftp.image}\";
}

")
        end
      end
      ff.close
   	end
  gentftp
  copytoserver

  end
  def gentftp
    Tftp.all.each do |tftp|
      #filename=tftp.image.split(".")
      if tftp.group == "network"
        ff= File.new("/tftpboot/#{tftp.pathtoconfig}#{tftp.configfilename}.conf.#{tftp.group}","w")
      else
        ff= File.new("/tftpboot/#{tftp.pathtoconfig}#{tftp.configfilename}.conf.group-#{tftp.group}","w")
      end
      ff.puts("#{tftp.config}")
      ff.close
      genhosts("#{tftp.pathtoconfig}#{tftp.configfilename}")
    end
  end
  def genhosts(filen)
    ff= File.new("/tftpboot/#{filen}.hosts","w")
    Host.all.each do |host|
      mac=host.mac.upcase.split("-")
        if !(host.tftp.group == "network")
          ff.puts("#{host.hostname} #{mac[0]}#{mac[1]}#{mac[2]}#{mac[3]}#{mac[4]}#{mac[5]} #{host.tftp.group}")
        end
      end
      ff.close

  end
  def copytoserver
     Dhcpserver.all.each do |dhcpserver|
      %x(scp /tmp/"#{dhcpserver.ip}" -P "#{dhcpserver.port}" root@"#{dhcpserver.ip}":/etc/dhcp/dhcpd.conf)
      %x(ssh -p "#{dhcpserver.port}" root@"#{dhcpserver.ip}" \""#{dhcpserver.reloadcommand}"\")
      %x(scp -r /tftpboot/* -P "#{dhcpserver.port}" root@"#{dhcpserver.ip}":/tftpboot/)
   puts 1
    end
  end
end
