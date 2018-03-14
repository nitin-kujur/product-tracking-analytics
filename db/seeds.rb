# # # This file should contain all the record creation needed to seed the database with its default values.
# # # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# # #
# # # Examples:
# # #
# # #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# # #   Character.create(name: 'Luke', movie: movies.first)
# # Shop.create(:shop_name => "pepsiprint.myshopify.com", :shopify_domain => "pepsiprint.myshopify.com", :shop_private_api_keys => "eea4bf9b40015e895c46e0dbf76ffd57", :shop_private_api_secret => "d26c3eb8f0b58a7007e69c1a207a5f65", :shop_private_api_password => "f9b0e579e616757f3875c7ec3b039fad", :shopify_token => 1)
# User.create(:email => "lapineanalytics@lapineinc.com", :password => "Ana!ytics@2018", :password_confirmation => "Ana!ytics@2018")

# shop = Shop.where(:shopify_domain => "pepsiprint.myshopify.com").first
# shop.shop_name = "pepsiprint.myshopify.com"
# shop.shop_private_api_keys = "eea4bf9b40015e895c46e0dbf76ffd57"
# shop.shop_private_api_secret = "d26c3eb8f0b58a7007e69c1a207a5f65" 
# shop.shop_private_api_password = "f9b0e579e616757f3875c7ec3b039fad"
# shop.save

# Shop.create(:shop_name => "pepsigenerations.myshopify.com", :shopify_domain => "pepsigenerations.myshopify.com", :shop_private_api_keys => "858fa0a3b3504e86b83933b05f225ff1", :shop_private_api_secret => "6883e6bd065aa32ee38edc2202a827f2", :shop_private_api_password => "5d32706666a580899ed64b5d42948531", :shopify_token => 1)
# shop = Shop.where(shopify_domain: "pepsigenerations.myshopify.com").first
# shop.shop_private_api_keys = "858fa0a3b3504e86b83933b05f225ff1"
# shop.shop_private_api_password ="5d32706666a580899ed64b5d42948531"
# shop.shop_private_api_secret = "6883e6bd065aa32ee38edc2202a827f2"
# shop.save

# shop = Shop.where(shopify_domain: "starsource-merchandise.myshopify.com").first
# shop.shop_private_api_keys = "9596807a8f255e0f322b6f9f2960e2c4" 
# shop.shop_private_api_password = "202af2e6cd5b9b0b333345372112136c"
# shop.shop_private_api_secret = "a6ac6aaf6a4d38d523d0d34ddf99517d"
# shop.save

# shop = Shop.where( shopify_domain: "pepsinba.myshopify.com").first
# shop.shop_private_api_keys = "f4215b4a890001c2a90b7a7b117f8097"
# shop.shop_private_api_password = "94c5141c853a5cb460073e0900477a83"
# shop.shop_private_api_secret = "46c6303f2ff865e4d926f6b52bf2cc1e"
# shop.save



# shop = Shop.where(shopify_domain: "pepsinfl.myshopify.com").first
# shop.shop_private_api_keys = "b8bb484d9b96f737078ec4aa58133947" 
# shop.shop_private_api_password = "0bfe4bab1fec7c635d125a841cb76d92"
# shop.shop_private_api_secret = "bb698eaa6035690a1d2df6f485d6e5bc"
# shop.save

# shop = Shop.where(shopify_domain: "shophydration.myshopify.com").first
# shop.shop_private_api_keys = "be88749d65378b355931b6a56fbe55c4"
# shop.shop_private_api_password = "93c6a7120419439bec39ec4db829f4a4"
# shop.shop_private_api_secret = "a4256084639a96abea05ea8fedcafc25"
# shop.save

# shop = Shop.where(shopify_domain: "weberprint.myshopify.com").first
# shop.shop_private_api_keys = "adf6d63192bd4a8e5bcd04b06683503f"
# shop.shop_private_api_password = "f6c4c44c06533aca732d578d851aed8b"
# shop.shop_private_api_secret = "7ab82a0d025ce1bed38beb620c11d311"
# shop.save

# shop = Shop.where(shopify_domain: "gatoradeplus.myshopify.com").first
# shop.shop_private_api_keys = "3255fff61eea4a9a788dc1adfe11ac5c"
# shop.shop_private_api_password = "75385b1b21924bb99de1b479adfef059"
# shop.shop_private_api_secret = "64b28bde8cf5ae5859285a4b4321d17e"
# shop.save

# shop = Shop.where(shopify_domain: "cycling-sports-group.myshopify.com").first
# shop.shop_private_api_keys = "9a78939d45c7a8fd29eb9d6729d3fe07"
# shop.shop_private_api_password = "0bd7ae2a0ce4d7d4784155e167b98e62"
# shop.shop_private_api_secret = "619b3ed50546b5d1a5996549dde38601"
# shop.save

# shop = Shop.where(shopify_domain: "fissler-b2b.myshopify.com").first
# shop.shop_private_api_keys = "99cc5d7fa1766968e4de1685936fa0d0"
# shop.shop_private_api_password = "5b43ff05192601413903c0d110bed120"
# shop.shop_private_api_secret = "3a4ad661c9c41c8164831dc6a79a9cdf"
# shop.save

# shop = Shop.where(shopify_domain: "dewice.myshopify.com").first
# shop.shop_private_api_keys = "f2c8234e0b401361403d57092e702609"
# shop.shop_private_api_password = "3be779d3bfe33ad1b3707f6db46de940"
# shop.shop_private_api_secret = "986b3170e4001a0d5176d47e7a7b1a34"
# shop.save

# shop = Shop.where(shopify_domain: "dewbeatthebuzzer.myshopify.com")
# shop.shop_private_api_keys = "96dd3fad81856fbd9b7f4f2518330c9c"
# shop.shop_private_api_password = "7ae318f5e9d21c871da1bb66b8c98052"
# shop.shop_private_api_secret = "4d274f05f8b65950aad2bcb986afbdab"
# shop.save

# shop = Shop.where(shopify_domain: "charterschools.myshopify.com")
# shop.shop_private_api_keys = "1e1321159cfdcb68b96bd9506687d0a4"
# shop.shop_private_api_password = "aeff1cd6d341271e4b34766142f3a0d6"
# shop.shop_private_api_secret = "37646eb6df9e141c94dcd8291e38fcca"
# shop.save

# shop = Shop.where(shopify_domain: "kipp-dev.myshopify.com").first
# shop.shop_private_api_keys = "000b9bed16c9e9bdd54e7d8eeac6bdb2"
# shop.shop_private_api_password = "238ad9075b6a97fb614cf075861e23cd"
# shop.shop_private_api_secret = "32212cc1c5f787bf3dd017db29589c83"
# shop.save

# shop = Shop.where(shopify_domain: "pepsidewmixology.myshopify.com").first
# shop.shop_private_api_keys = "44160ba790218b731c3cf66d513817a8"
# shop.shop_private_api_password = "46bf264d6a445b4c954d1eb52dddab63"
# shop.shop_private_api_secret = "8c8c5c65abf6a681290e70ff710e44d7"
# shop.save

# # ["pepsiprint.myshopify.com", "lapineteststore.myshopify.com", "kipp-dev.myshopify.com", "shophydration.myshopify.com", "weberprint.myshopify.com", "gatoradeplus.myshopify.com", "pepsinfl.myshopify.com", "gatoradecoaches.myshopify.com", "fissler-b2b.myshopify.com", "charterschools.myshopify.com", "pepsiholiday.myshopify.com", "pepsidewmixology.myshopify.com", "dewice.myshopify.com", "pepsigenerations.myshopify.com"]
