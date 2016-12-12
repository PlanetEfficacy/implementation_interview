require 'csv'

puts "\n\nReading data from csv....\n\n"
csv_text = File.read('./seed_data/street_cafes_15_16.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  puts "#{Shop.all.count} : Creating shop with attributes #{row.to_hash}\n\n"
  Shop.find_or_create_by( name:            row["Name"],
                          street_address:  row["Street Address"],
                          post_code:       row["Post Code"],
                          chairs:          row["Chairs"] )
end

# **************************************************************
# The follow section categorizes each shop according to
# Task 5a, b, and c: Write a Rails script to categorize the
# cafes and write the result to the category according to
# the rules.
# **************************************************************

puts "\n\nStarting to categorize....\n\n"
Shop.all.each do |shop|
  print "adding category to shop #{shop.id}... "
  Categorizer.new(shop).assign_category!
  print "shop #{shop.id} now has category #{shop.category}\n\n"
end

# **************************************************************
# Uncomment the follow section to rename each shop according to
# Task 7b: For street cafes categorized as medium or large,
# write a script that concatenates the category name to the
# beginning of the name and writes it back to the name column
# **************************************************************

# puts "\n\nStarting to rename....\n\n"
# Shop.all.each do |shop|
#   print "shop #{shop.id} with category #{shop.category} was #{shop.name}... "
#   Categorizer.new(shop).rename!
#   print "shop #{shop.id} with category #{shop.category} is now #{shop.name}\n\n"
# end
