# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create sample products
Product.create!([
  {
    name: "Mystery Gaming Box",
    description: "A box full of gaming surprises! Could contain anything from retro games to modern accessories.",
    price: 49.99
  },
  {
    name: "Tech Mystery Box",
    description: "Discover the latest tech gadgets and accessories in this exciting mystery box.",
    price: 79.99
  },
  {
    name: "Collector's Mystery Box",
    description: "For the serious collector. Each box contains rare and unique items.",
    price: 99.99
  },
  {
    name: "Budget Mystery Box",
    description: "Affordable surprises for everyone! Great value mystery items.",
    price: 29.99
  }
])
