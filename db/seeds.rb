# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tags = ["mountain", "snow", "landscape", "beach", "person"]

5.times do |i|
  image = Image.create!({description: "Foo", media_id: i})
  Tag.create!({images: [image], tag_name: tags[i]})
end

cattag = Tag.create!({tag_name: "cat"})
3.times do |i|
  Image.create!({tags: [cattag], description: "cat", media_id: 5+i})
end

dogtag = Tag.create!({tag_name: "dog"})
2.times do |i|
  Image.create!({tags: [dogtag], description: "dog", media_id: 8+i})
end
