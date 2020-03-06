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
  String :neighborhood
  String :latitude
  String :longitude
  String :phone
  String :webURL
  Boolean :visited
  Boolean :favorite
  Boolean :reservation
  String :resURL
  String :notes, text: true
end

# Insert initial (seed) data
places_table = DB.from(:places)

places_table.insert(name: "Jam", 
                    street: "2853 N Kedzie Ave",
                    city: "Chicago",
                    neighborhood: "Logan Square",
                    latitude: "41.9336",
                    longitude: "-87.7072",
                    phone: "773-292-6011",
                    webURL: "jamrestaurant.com",
                    reservation: 0)

places_table.insert(name: "Roister", 
                    street: "95 W Fulton Market",
                    city: "Chicago",
                    neighborhood: "West Loop",
                    latitude: "41.8865",
                    longitude: "-87.6519",
                    phone: "312-789-4896",
                    webURL: "roisterrestaurant.com",
                    reservation: 1,
                    resURL: "https://www.exploretock.com/roister/")

places_table.insert(name: "3 Squares Diner", 
                    street: "1020 W Lawrence Ave",
                    city: "Chicago",
                    neighborhood: "Uptown",
                    latitude: "41.9692",
                    longitude: "-87.6556",
                    phone: "773-293-6158",
                    webURL: "3squaresdiner.com",
                    reservation: 1,
                    resURL: "https://www.exploretock.com/3squaresdiner/")

places_table.insert(name: "Band of Bohemia", 
                    street: "4710 N Ravenswood Ave",
                    city: "Chicago",
                    neighborhood: "Ravenswood",
                    latitude: "41.9677",
                    longitude: "-87.6749",
                    phone: "773-271-4710",
                    webURL: "bandofbohemia.com",
                    reservation: 1,
                    resURL: "https://www.exploretock.com/bandofbohemia/")

places_table.insert(name: "etta", 
                    street: "1840 W North Ave",
                    city: "Chicago",
                    neighborhood: "Wicker Park",
                    latitude: "41.9107",
                    longitude: "-87.6742",
                    phone: "312-757-4444",
                    webURL: "ettarestaurant.com",
                    reservation: 1,
                    resURL: "https://www.sevenrooms.com/reservations/ettarestaurant/goog/")

places_table.insert(name: "Dove's Luncheonette", 
                    street: "1545 N Damen Ave",
                    city: "Chicago",
                    neighborhood: "Wicker Park",
                    latitude: "41.9094",
                    longitude: "-87.6773",
                    phone: "773-645-4060",
                    webURL: "doveschicago.com",
                    reservation: 1,
                    resURL: "https://resy.com/cities/chi/doves-luncheonette")

places_table.insert(name: "Tre Kronor", 
                    street: "3258 W Foster Ave",
                    city: "Chicago",
                    neighborhood: "Albany Park",
                    latitude: "41.9759",
                    longitude: "-87.7110",
                    phone: "773-267-9888",
                    webURL: "trekronorrestaurant",
                    reservation: 0)

places_table.insert(name: "Amaru", 
                    street: "1904 W North Ave",
                    city: "Chicago",
                    neighborhood: "Wicker Park",
                    latitude: "41.9107",
                    longitude: "-87.6754",
                    phone: "773-687-9790",
                    webURL: "amaruchicago.com",
                    reservation: 1,
                    resURL: "https://www.opentable.com/r/amaru-chicago")

places_table.insert(name: "Egg Harbor Cafe", 
                    street: "140 E Wing St",
                    city: "Arlington Heights",
                    neighborhood: "suburbs",
                    latitude: "45.048721",
                    longitude: "-87.300743",
                    phone: "847-253-4363",
                    webURL: "eggharborcafe.com",
                    reservation: 0)

places_table.insert(name: "Pacific Standard Time", 
                    street: "141 W Erie St",
                    city: "Chicago",
                    neighborhood: "River North",
                    latitude: "41.8939",
                    longitude: "-87.6329",
                    phone: "312-736-1778",
                    webURL: "pstchicago.com",
                    reservation: 1,
                    resURL: "https://resy.com/cities/chi/pacific-standard-time")

places_table.insert(name: "M Henry", 
                    street: "5707 N Clark St",
                    city: "Chicago",
                    neighborhood: "Andersonville",
                    latitude: "41.9856",
                    longitude: "-87.6691",
                    phone: "773-561-1600",
                    webURL: "mhenry.net",
                    reservation: 0)
                
places_table.insert(name: "Steingold's", 
                    street: "1840 W Irving Park Rd",
                    city: "Chicago",
                    neighborhood: "North Center",
                    latitude: "41.9544",
                    longitude: "-87.6758",
                    phone: "773-661-2469",
                    webURL: "steingoldsdeli.com",
                    reservation: 0)
 
places_table.insert(name: "Beatrix", 
                    street: "519 N Clark St",
                    city: "Chicago",
                    neighborhood: "River North",
                    latitude: "41.8944",
                    longitude: "-87.6225",
                    phone: "312-284-1377",
                    webURL: "beatrixrestaurants.com/beatrix/river-north/",
                    reservation: 1,
                    resURL: "https://www.opentable.com/beatrix-river-north")

places_table.insert(name: "All Together Now", 
                    street: "2119 W Chicago Ave",
                    city: "Chicago",
                    neighborhood: "West Town",
                    latitude: "41.8957",
                    longitude: "-87.6804",
                    phone: "773-661-1599",
                    webURL: "alltogethernow.fun",
                    reservation: 0)

places_table.insert(name: "Little Goat Diner", 
                    street: "820 W Randolph St",
                    city: "Chicago",
                    neighborhood: "West Loop",
                    latitude: "41.8847",
                    longitude: "-87.6484",
                    phone: "312-888-3455",
                    webURL: "littlegoatchicago.com",
                    reservation: 1,
                    resURL: "https://www.exploretock.com/littlegoatchicago/")

places_table.insert(name: "Gather", 
                    street: "4539 N Lincoln Ave",
                    city: "Chicago",
                    neighborhood: "Lincoln Square",
                    latitude: "41.9643",
                    longitude: "-87.6855",
                    phone: "773-506-9300",
                    webURL: "gatherchicago.com",
                    reservation: 1,
                    resURL: "https://resy.com/cities/chi/gather")

places_table.insert(name: "Mindy's Hot Chocolate", 
                    street: "1747 N Damen Ave",
                    city: "Chicago",
                    neighborhood: "Bucktown",
                    latitude: "41.9137",
                    longitude: "-87.6772",
                    phone: "773-489-1747",
                    webURL: "hotchocolatechicago.com",
                    reservation: 1,
                    resURL: "https://resy.com/cities/chi/hot-chocolate")

places_table.insert(name: "Southport Grocer", 
                    street: "3552 N Southport Ave",
                    city: "Chicago",
                    neighborhood: "Lakeview",
                    latitude: "41.9467",
                    longitude: "-87.6642",
                    phone: "773-665-0100",
                    webURL: "southportgrocery.com",
                    reservation: 0)

places_table.insert(name: "Hutch American Bistro", 
                    street: "3301 N Clark St",
                    city: "Chicago",
                    neighborhood: "Lakeview",
                    latitude: "41.9420",
                    longitude: "-87.6522",
                    phone: "773-248-1155",
                    webURL: "hutchamericanbistro.com",
                    reservation: 1,
                    resURL: "https://www.opentable.com/r/hutch-american-bistro-lakeview-chicago")

places_table.insert(name: "Big Jones", 
                    street: "5347 N Clark St",
                    city: "Chicago",
                    neighborhood: "Andersonville",
                    latitude: "41.9794",
                    longitude: "-87.6681",
                    phone: "773-275-5725",
                    webURL: "bigjoneschicago.com",
                    reservation: 1,
                    resURL: "https://www.exploretock.com/bigjones/")

places_table.insert(name: "S.K.Y.", 
                    street: "1239 W 18th St",
                    city: "Chicago",
                    neighborhood: "Pilsen",
                    latitude: "41.8578",
                    longitude: "-87.6580",
                    phone: "312-846-1077",
                    webURL: "skyrestaurantschicago.com",
                    reservation: 1,
                    resURL: "https://resy.com/cities/chi/s-k-y")

places_table.insert(name: "Virtue", 
                    street: "1462 E 53rd St",
                    city: "Chicago",
                    neighborhood: "Hyde Park",
                    latitude: "41.7997",
                    longitude: "-87.8593",
                    phone: "773-947-8831",
                    webURL: "virtuerestaurant.com",
                    reservation: 1,
                    resURL: "https://resy.com/cities/chi/virtue-restaurant-and-bar")

places_table.insert(name: "Summer House Santa Monica", 
                    street: "1954 N Halsted St",
                    city: "Chicago",
                    neighborhood: "Lincoln Park",
                    latitude: "41.9176",
                    longitude: "-87.6487",
                    phone: "773-634-4100",
                    webURL: "summerhousesm.com",
                    reservation: 1,
                    resURL: "https://www.opentable.com/summer-house")

places_table.insert(name: "The Publican", 
                    street: "837 W Fulton Market",
                    city: "Chicago",
                    neighborhood: "West Loop",
                    latitude: "41.8866",
                    longitude: "-87.6489",
                    phone: "312-733-9555",
                    webURL: "thepublicanrestaurant.com",
                    reservation: 1,
                    resURL: "https://resy.com/cities/chi/the-publican")