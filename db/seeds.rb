require 'csv'

csv_text = File.read('./seed_data/street_cafes_15_16.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  puts "#{Shop.all.count} : Creating shop with attributes #{row.to_hash}"
  Shop.find_or_create!( name:            row["Name"],
                        street_address:  row["Street Address"],
                        post_code:       row["Post Code"],
                        chairs:          row["Chairs"] )
end
