# Delete all entries
Category.delete_all
Product.delete_all
FeaturedProduct.delete_all
Order.delete_all
Admin.delete_all
Faq.delete_all
Cart.delete_all

Admin.create!(email: 'admin@example.com', password: 'password')

# Create Categories
category_images = ["cover.jpg",
                   "larger_pendant.jpg",
                   "rocks_cuff.jpg",
                   "bracelet_cover.jpg",
                   "larger_ring.jpg",
                   "bracelet_cover.jpg"
                  ]

categories = %w(autumn necklaces earrings bracelets rings sale)

product_names = %w(Lilah Renee Laura Sharon Stephanie Dahlia Norah Lucy Leigh) +
                %w(Rachel Matilda Maria Tess Sara Juliet Winona Whitney Cristina) +
                %w(Delilah Leyla Rowan Harper Fiona Marisa Lisa Aria Dani Maude) +
                %w(Margaret Opal Petunia Hermione Lavender Parvati Luna Rowena Sasha) +
                %w(Sansa Aditi Naima Depeeka Sabah Toni Mia Audrey Aubrey Lizbeth) +
                %w(Taylor Joan Esther Ruth Tyra Jezebel Alice Chelsea Hilary Lisha) +
                %w(Tea Shawna Jaredia Sydney Stephania Leia Jessica Jennifer Jordan) +
                %w(Brigitte Gabrielle Nona Ella Rihanna Beyonce Rihannon Stevie) + 
                %w(Melody Mary Kari Lindsay Cameron Lysa Catelyn Arya Arwen Eowyn)

categories.each_with_index do |category, i|
  product_name = product_names.delete(product_names.sample)
  Category.create(title: category,
                  header: product_names.delete(product_names.sample),
                  subheader: Faker::HipsterIpsum.sentence,
                  image: "placeholder/#{category_images[i]}")
end

product_images =  ["stone_ring.jpg",
                   "long_earring.jpg",
                   "gypsy_earring.jpg",
                   "wire_cuff.jpg",
                   "statement_ring.jpg",
                   "rocks_cuff.jpg"]

# Create Products
Category.all.each do |category|
  10.times do
    product = category.products.create(
      title: product_names.delete(product_names.sample), 
      description: Faker::HipsterIpsum.sentence,
      price: rand(250) + 1,
      gem_type: Faker::Product.model,
      length: rand(10),
      karat: rand(10)
      )
    4.times do 
      image = product.images.build
      image.image_url = URI.parse("https://s3.amazonaws.com/crisdevin-production/larger_images/#{product_images.sample}")
      image.save!
    end
  end
end

# Add featured product to each category
Category.all.each do |category|
  product = category.products.sample
  FeaturedProduct.create(
      description: Faker::HipsterIpsum.sentence, 
      title: product_names.delete(product_names.sample),
      product_id: product.id,
      category_id: category.id 
    )
end

10.times do 
  question = Faq.create(
    question: Faker::HipsterIpsum.sentence,
    answer: Faker::HipsterIpsum.sentence 
  )
end
