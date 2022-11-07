puts "🌱 Seeding data..."

# place your seeds here
Category.create(name: "Perosnal")
Category.create(name: "Home")
Category.create(name: "Office")
Category.create(name: "Hobbies")


Category.all.each do |category|
    6.times do 
        TodoList.create(
            title: Faker::Lorem.sentence(word_count: 5),
            description: Faker::Lorem.paragraph(sentence_count: 2),
            category_id: category.id,
            status: false
        )
    end
end

puts "🌱 Done seeding!"
