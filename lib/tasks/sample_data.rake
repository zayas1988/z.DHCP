namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "zayas User",
                 email: "zayas@zayas.su",
                 password: "foobar",
                 password_confirmation: "foobar")
#    10.times do |n|
#      name  = Faker::Name.name
#      email = "example-#{n+1}@zayas.su"
#      password  = "123123"
#      User.create!(name: name,
#                   email: email,
#                   password: password,
#                   password_confirmation: password)
#    end

   Subnet.create!(adress: "192.168.1.0",
			mask: 	"255.255.255.0",
			broadcast: "192.168.1.255",
			routers: "192.168.1.200",
			nameservers: "192.168.1.230, 192.168.187.230",
			domainname: "local.polad.ru")
  end
end
