# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development? then
    begin
        User.create!([{email: "admin@person.com", password: "qwerqwer", administrator: true, first_name:"Admin", last_name: "McAdminson", tax_identification_number: '0',name_prefix: 'Mr.',phone_number: '0',country: 'Nowhere',city: 'Noville',company_name: 'Caroyal',company_address: '0', company_city: "Tromsø", company_country: "NO", phone_code: '+47'} ])
    rescue ActiveRecord::RecordInvalid
    end
end


def fake_user
    is_producer = false
    if rand(100) > 50 then
        is_producer = true
    end
    is_distributor = false
    if rand(100) > 50 then
        is_distributor = true
    end
    phone = (0...5).map { rand(9) }.join
    User.new({producer: is_producer, distributor: is_distributor, password: "asdfF87asdf", administrator: false, first_name:"Fishy", last_name: "McFish", tax_identification_number: '0',name_prefix: 'Mr.',phone_number: phone,country: 'Nowhere',city: 'Noville',company_name: 'FishFishFish',company_address: '0', company_city: "Tromsø", company_country: "NO", phone_code: '+47'})
end

(0..12).each do |n|
    u = fake_user
    begin
        u.save
    rescue ActiveRecord::RecordInvalid
    end
end


begin
events = []
events[0] = {
    :time => DateTime.new(2023, 1, 15),
    :title => "DENISA development",
    :text => "Development of our e-commerce
    platform, DENISA. This groupage model
    platform will enable dealers in Africa to
    purchase a part in a 40ft container load of
    stockfish products with just $5000. The
    aim of this project is to make products
    more accessible and affordable for
    customers.",
    :number => 1
}
events[1] = {
    :time => DateTime.new(2023, 2, 15),
    :title => "Onboarding of pilot customers",
    :text => "As work intensifies on DENISA,
    we register pilot customers who
    wish to import stockfish
    products on caroyal.com. Our
    target is to onbaord 500
    customers by August",
    :number => 2
}
events[2] = {
    :time => DateTime.new(2023, 3, 15),
    :title => "Product development",
    :text => "Stockfish production project that
    considers both industrial and natural
    drying techniques. In case we are
    unable to produce enough to meet
    demand, we shall source for products
    from other reputable producers.",
    :number => 3
}
events[3] = {
    :time => DateTime.new(2023, 6, 15),
    :title => "DENISA test-run",
    :text => "During the test run, we shall work
    closely with a select group of stockfish
    dealers to ensure that DENISA is
    secure, easy to use, and meet their
    needs.",
    :number => 4
}
events[4] = {
    :time => DateTime.new(2023, 8, 15),
    :title => "DENISA launch",
    :text => "Stockfish sales! 40 ft containers
    will be sold on groupage to our
    registered customers who will be
    able to purchase Stockfish
    products on Caroyal.com with
    just $5000.",
    :number => 5
}
events[5] = {
    :time => DateTime.new(2024, 1, 15),
    :title => "DENISA scaling",
    :text => "We will make DENISA accessible to a
    wider range of customers and industries.
    We will collaborate with relevant
    stakeholders to ensure that the platform
    is adapted to the specific needs of each
    added product or supply network.",
    :number => 6
}
events[6] = {
    :time => nil,
    :title => "Traceability era",
    :text => nil,
    :number => 7
}
events[7] = {
    :time => DateTime.new(2025, 1, 15),
    :title => "Commodity trading",
    :text => "Traceable export of commodities from
    Africa. Using blockchain technology,
    multiple parties will collaborate and
    share information about a
    commodity's journey. Our goal is to
    help small and medium-sized
    commodity producers in remote
    locations sell their goods to
    international buyers, thereby
    expanding access to global markets.",
    :number => 8
}
events[8] = {
    :time => nil,
    :title => "Sustainability era",
    :text => nil,
    :number => 9
}
events[9] = {
    :time => DateTime.new(2027, 1, 15),
    :title => "Sustainable supply networks",
    :text => "Caroyal is an innovation leader that
    takes on both managerial and
    technological roles in the evolution of
    supply networks across Africa and
    beyond.",
    :number => 10
}
TimelineEvent.create(events)
rescue ActiveRecord::RecordInvalid
end