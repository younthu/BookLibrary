# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



user = User.create(:email => "admin@admin.com", :password => "11111111", :password_confirmation=>"11111111", :admin=>true)

p user.errors
