# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :places do
  primary_key :id
  String :name
  String :street
  String :city
  String :state
  String :zip
  String :neighborhood
  String :phone
  String :webURL
  Boolean :reservation
  String :resURL
end

DB.create_table! :reviews do
  primary_key :id
  foreign_key :location_id
  foreign_key :user_id
  Boolean :favorite
  String :reviews, text: true
end

DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
places_table = DB.from(:places)

places_table.insert(name: "Jam", 
                    street: "2853 N Kedzie Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60618",
                    neighborhood: "Logan Square",
                    phone: "773-292-6011",
                    webURL: "jamrestaurant.com",
                    reservation: false)

places_table.insert(name: "Roister", 
                    street: "95 W Fulton Market",
                    city: "Chicago",
                    state: "IL",
                    zip: "60607",
                    neighborhood: "West Loop",
                    phone: "312-789-4896",
                    webURL: "roisterrestaurant.com",
                    reservation: true,
                    resURL: "https://www.exploretock.com/roister/")

places_table.insert(name: "3 Squares Diner", 
                    street: "1020 W Lawrence Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60640",
                    neighborhood: "Uptown",
                    phone: "773-293-6158",
                    webURL: "3squaresdiner.com",
                    reservation: true,
                    resURL: "https://www.exploretock.com/3squaresdiner/")

places_table.insert(name: "Band of Bohemia", 
                    street: "4710 N Ravenswood Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60640",
                    neighborhood: "Ravenswood",
                    phone: "773-271-4710",
                    webURL: "bandofbohemia.com",
                    reservation: true,
                    resURL: "https://www.exploretock.com/bandofbohemia/")

places_table.insert(name: "etta", 
                    street: "1840 W North Ave",
                    city: "Chicago",
                    neighborhood: "Wicker Park",
                    state: "IL",
                    zip: "60622",
                    phone: "312-757-4444",
                    webURL: "ettarestaurant.com",
                    reservation: true,
                    resURL: "https://www.sevenrooms.com/reservations/ettarestaurant/goog/")

places_table.insert(name: "Dove's Luncheonette", 
                    street: "1545 N Damen Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60622",
                    neighborhood: "Wicker Park",
                    phone: "773-645-4060",
                    webURL: "doveschicago.com",
                    reservation: true,
                    resURL: "https://resy.com/cities/chi/doves-luncheonette")

places_table.insert(name: "Tre Kronor", 
                    street: "3258 W Foster Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60625",
                    neighborhood: "Albany Park",
                    phone: "773-267-9888",
                    webURL: "trekronorrestaurant",
                    reservation: false)

places_table.insert(name: "Amaru", 
                    street: "1904 W North Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60622",
                    neighborhood: "Wicker Park",
                    phone: "773-687-9790",
                    webURL: "amaruchicago.com",
                    reservation: true,
                    resURL: "https://www.opentable.com/r/amaru-chicago")

places_table.insert(name: "Batter & Berries", 
                    street: "2748 N Lincoln Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60614",
                    neighborhood: "Lincoln Park",
                    phone: "773-248-7710",
                    webURL: "batterandberries.com",
                    reservation: false)

places_table.insert(name: "Pacific Standard Time", 
                    street: "141 W Erie St",
                    city: "Chicago",
                    state: "IL",
                    zip: "60654",
                    neighborhood: "River North",
                    phone: "312-736-1778",
                    webURL: "pstchicago.com",
                    reservation: true,
                    resURL: "https://resy.com/cities/chi/pacific-standard-time")

places_table.insert(name: "M Henry", 
                    street: "5707 N Clark St",
                    city: "Chicago",
                    state: "IL",
                    zip: "60660",
                    neighborhood: "Andersonville",
                    phone: "773-561-1600",
                    webURL: "mhenry.net",
                    reservation: false)
                
places_table.insert(name: "Steingold's", 
                    street: "1840 W Irving Park Rd",
                    city: "Chicago",
                    state: "IL",
                    zip: "60613",
                    neighborhood: "North Center",
                    phone: "773-661-2469",
                    webURL: "steingoldsdeli.com",
                    reservation: false)
 
places_table.insert(name: "Beatrix", 
                    street: "519 N Clark St",
                    city: "Chicago",
                    state: "IL",
                    zip: "60654",
                    neighborhood: "River North",
                    phone: "312-284-1377",
                    webURL: "beatrixrestaurants.com/beatrix/river-north/",
                    reservation: true,
                    resURL: "https://www.opentable.com/beatrix-river-north")

places_table.insert(name: "All Together Now", 
                    street: "2119 W Chicago Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60622",
                    neighborhood: "West Town",
                    phone: "773-661-1599",
                    webURL: "alltogethernow.fun",
                    reservation: false)

places_table.insert(name: "Little Goat Diner", 
                    street: "820 W Randolph St",
                    city: "Chicago",
                    state: "IL",
                    zip: "60607",
                    neighborhood: "West Loop",
                    phone: "312-888-3455",
                    webURL: "littlegoatchicago.com",
                    reservation: true,
                    resURL: "https://www.exploretock.com/littlegoatchicago/")

places_table.insert(name: "Gather", 
                    street: "4539 N Lincoln Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60625",
                    neighborhood: "Lincoln Square",
                    phone: "773-506-9300",
                    webURL: "gatherchicago.com",
                    reservation: true,
                    resURL: "https://resy.com/cities/chi/gather")

places_table.insert(name: "Mindy's Hot Chocolate", 
                    street: "1747 N Damen Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60647",
                    neighborhood: "Bucktown",
                    phone: "773-489-1747",
                    webURL: "hotchocolatechicago.com",
                    reservation: true,
                    resURL: "https://resy.com/cities/chi/hot-chocolate")

places_table.insert(name: "Southport Grocery", 
                    street: "3552 N Southport Ave",
                    city: "Chicago",
                    state: "IL",
                    zip: "60657",
                    neighborhood: "Lakeview",
                    phone: "773-665-0100",
                    webURL: "southportgrocery.com",
                    reservation: false)

places_table.insert(name: "Hutch American Bistro", 
                    street: "3301 N Clark St",
                    city: "Chicago",
                    state: "IL",
                    zip: "60657",
                    neighborhood: "Lakeview",
                    phone: "773-248-1155",
                    webURL: "hutchamericanbistro.com",
                    reservation: true,
                    resURL: "https://www.opentable.com/r/hutch-american-bistro-lakeview-chicago")

places_table.insert(name: "Big Jones", 
                    street: "5347 N Clark St",
                    city: "Chicago",
                    neighborhood: "Andersonville",
                    state: "IL",
                    zip: "60640",
                    phone: "773-275-5725",
                    webURL: "bigjoneschicago.com",
                    reservation: true,
                    resURL: "https://www.exploretock.com/bigjones/")

places_table.insert(name: "S.K.Y.", 
                    street: "1239 W 18th St",
                    city: "Chicago",
                    state: "IL",
                    zip: "60608",
                    neighborhood: "Pilsen",
                    phone: "312-846-1077",
                    webURL: "skyrestaurantschicago.com",
                    reservation: true,
                    resURL: "https://resy.com/cities/chi/s-k-y")

places_table.insert(name: "Virtue", 
                    street: "1462 E 53rd St",
                    city: "Chicago",
                    state: "IL",
                    zip: "60615",
                    neighborhood: "Hyde Park",
                    phone: "773-947-8831",
                    webURL: "virtuerestaurant.com",
                    reservation: true,
                    resURL: "https://resy.com/cities/chi/virtue-restaurant-and-bar")

places_table.insert(name: "Summer House Santa Monica", 
                    street: "1954 N Halsted St",
                    city: "Chicago",
                    state: "IL",
                    zip: "60614",
                    neighborhood: "Lincoln Park",
                    phone: "773-634-4100",
                    webURL: "summerhousesm.com",
                    reservation: true,
                    resURL: "https://www.opentable.com/summer-house")

places_table.insert(name: "The Publican", 
                    street: "837 W Fulton Market",
                    city: "Chicago",
                    state: "IL",
                    zip: "60607",
                    neighborhood: "West Loop",
                    phone: "312-733-9555",
                    webURL: "thepublicanrestaurant.com",
                    reservation: true,
                    resURL: "https://resy.com/cities/chi/the-publican")