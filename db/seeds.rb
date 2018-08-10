10.times do |n|
  genre = Faker::Book.genre
  Category.create!(category_name: genre)
end

Book.__elasticsearch__.create_index!(force: true)

categories = Category.order(:created_at).take(6)

10.times do |n|
  name = Faker::Book.title
  author = Faker::Book.author
  publisher = Faker::Book.publisher
  categories.each {|category| category.books.create!(name: name, author: author, publisher: publisher, price: 10, quantity: 10)}
end

User.create!(name: "admin",
  gender: 1,
  birthday: "04/05/1997",
  address: "VXT",
  phone_number: "01686741787",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  user_type: 2,
  activated: true
)

User.create!(name: "employee",
  gender: 2,
  birthday: "05/05/1997",
  address: "VXT",
  phone_number: "01686745999",
  email: "employee@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  user_type: 1,
  activated: true
)

10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    gender: 1,
    birthday: "04/05/1996",
    address: "VXT",
    phone_number: "01686741789",
    email: email,
    password: password,
    password_confirmation: password)
end
Cart.destroy_all
