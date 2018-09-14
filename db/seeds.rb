

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

puts Benchmark.measure {

csv_text = File.read(Rails.root.join('lib/seeds/zip_codes_final.csv'))
csv = CSV.parse(csv_text, :headers => true)

csv.each do |row|
  # Moulding.create!(row.to_hash)


  state = State.new(name: row["State"], abbreviation: row["Abbreviation"])
  state.save

  state = State.find_by(name: row["State"])
  # p row["ZIP code"]
  zip_code = ZipCode.new(value: row.to_hash["ZIP code"], state_id: state.id)
  zip_code.save!
  # zip_code.save
  # p zip_code

end


 }


state_id = 3

50.times do
  state = State.find(state_id)
  store = Store.new(
    title: Faker::Company.name,
    email: Faker::Internet.email,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state_id: state_id,
    zip_code: state.zip_codes.sample,
    password: "password"
  )

  store.save!
  state_id += 1
end
