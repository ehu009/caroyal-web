# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development? then
    User.create!([{email: "admin@person.com", password: "qwerqwer", administrator: true, full_name:"Admin McAdminson", tax_identification_number: '0',name_prefix: 'Mr.',phone_number: '0',country: 'Nowhere',city: 'Noville',company_name: 'Caroyal',company_address: '0'} ])
end




