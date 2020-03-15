# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"                                                                 #
require "bcrypt" 
require "geocoder"                                                                  #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################

places_table = DB.from(:places)
reviews_table = DB.from(:reviews)
users_table = DB.from(:users)

before do
    @current_user = users_table.where(id: session["user_id"]).to_a[0]
end

get "/" do
    @places = places_table.all.to_a
    view "all"
end

get "/detail/:name" do
    @place = places_table.where(name:params[:name]).to_a[0]
    @location = "#{@place[:street]},#{@place[:city]} #{@place[:state]} #{@place[:zip]}"
    results = Geocoder.search(@location)
    puts results

    lat_long = results.first.coordinates # => [lat, long]
    @lat_long = "#{lat_long[0]}, #{lat_long[1]}"

    @reviews = reviews_table.where(location_id: @place[:id])
    @fav_count = reviews_table.where(location_id: @place[:id], favorite: true).count
    @users_table = users_table

    view "detail"
end

get "/review/:name" do
    @place = places_table.where(name:params[:name]).to_a[0]
    view "add_review"
end

get "/review/:name/create" do
    puts params
    @place = places_table.where(name:params[:name]).to_a[0]
    @review = reviews_table.where(id: params[:id]).to_a[0]
    reviews_table.insert(id: params["id"],
                        location_id: @place[:id],
                        user_id: session["user_id"],
                        favorite: params["favorite"],
                        reviews: params["review"])
    view "create_review"
end

get "/surpriseme" do
    @surprise_number = rand(1..25)
    @surprise_place = places_table.where(id:@surprise_number).to_a[0]

    @surprise_location = "#{@surprise_place[:street]},#{@surprise_place[:city]} #{@surprise_place[:state]} #{@surprise_place[:zip]}"
    results = Geocoder.search(@surprise_location)

    lat_long = results.first.coordinates # => [lat, long]
    @lat_long = "#{lat_long[0]}, #{lat_long[1]}"

    @reviews = reviews_table.where(location_id: @surprise_place[:id])
    @fav_count = reviews_table.where(location_id: @surprise_place[:id], favorite: true).count
    @users_table = users_table
    view "surpriseme"
end

get "/users/new" do
    view "auth_new_user"
end

post "/users/create" do
    puts params
    hashed_password = BCrypt::Password.create(params["password"])
    users_table.insert(name: params["name"], email: params["email"], password: hashed_password)
    view "auth_create_user"
end

get "/logins/new" do
    view "auth_new_login"
end

post "/logins/create" do
    puts params
    email_address = params["email"]
    password = params["password"]

    @user = users_table.where(email: params["email"]).to_a[0]
    puts BCrypt::Password::new(@user[:password])
    if @user && BCrypt::Password::new(@user[:password]) == params["password"]
        session["user_id"] = @user[:id]
        @current_user = @user
        view "auth_create_login"
    else
        view "auth_create_login_failed"
    end
end

#    @user = users_table.where(email: email_address).to_a[0]
#    if @user
#        if BCrypt::Password.new(@user[:password]) == password
#            session["user_id"] = @user[:id]
#            view "auth_create_login"
#        else
#            view "auth_login_failed"
#        end
#    else
#        view "auth_login_failed"
#    end

get "/logout" do
    session["user_id"] = nil
    @current_user = nil
    view "auth_logout"
end