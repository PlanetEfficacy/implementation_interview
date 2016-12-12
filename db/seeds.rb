require 'csv'

csv_text = File.read('./seed_data/street_cafes_15_16.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  puts "#{Shop.all.count} : Creating shop with attributes #{row.to_hash}"
  Shop.find_or_create_by( name:            row["Name"],
                          street_address:  row["Street Address"],
                          post_code:       row["Post Code"],
                          chairs:          row["Chairs"] )
end

puts "\n\nStarting to categorize....\n\n"
Shop.all.each do |shop|
  Categorizer.new(shop).assign_category!
end

puts "\n\nStarting to rename....\n\n"
Shop.all.each do |shop|
  puts "shop #{shop.id} with category #{shop.category} was #{shop.name}"
  Categorizer.new(shop).rename!
  puts "shop #{shop.id} with category #{shop.category} is now #{shop.name}"
end
