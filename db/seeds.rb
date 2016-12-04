# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

prepare_production_data = true
prepare_test_data = false

# prepare data for production use
if prepare_production_data
  regions = ['浦东新区', '徐汇区', '黄浦区', '卢湾区', '静安区', '长宁区', '闵行区', '杨浦区', '普陀区', '虹口区', '宝山区', '闸北区', '松江区', '嘉定区', '青浦区', '奉贤区', '金山区']
  regions.each do |r|
    region = Region.new(name: r)
    region.save!
  end

  products = %w(微辣澳洲进口牛腩饭 中辣澳洲进口牛腩饭 重辣澳洲进口牛腩饭)
  products.each do |p|
    Product.new(name: p).save!
  end
end

# prepare data for test use
if prepare_test_data
  user = User.find(1)
  for i in 1..1000
    Store.new(name: i, owner_name: i, owner_telephone: 1, user: user).save!
  end
  for i in 1..1000
    Order.new(user: user).save!
  end
end