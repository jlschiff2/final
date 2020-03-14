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

#before do
#    @current_user = users_table.where(id: session["user_id"]).to_a[0]
#end

get "/" do
    @places = places_table.all.to_a
    view "all"
end

get "/detail/:name" do
     @place = places_table.where(name:params[:name]).to_a[0]
     # @lat = places_table.where(latitude:params[:latitude]).to_a[0]
     # @long = places_table.where(longitude:params[:longitude]).to_a[0]
     # @lat_long = "#{@lat},#{@long}"
     # @reviews = rsvps_table.where(reviews_id: @reviews[:id])
    view "detail"
end

get "/review/:name" do
    @place = places_table.where(name:params[:name]).to_a[0]
    view "add_review"
end

get "/review/:name/create" do
    puts params
    @place = places_table.where(name:params[:name]).to_a[0]
    rsvps_table.insert(id: params["id"],
                       location_id: params[@place[:id]],
                       favorite: params["favorite"],
                       reviews: params["reviews"])
    view "create_review"
end

#get "/favorites" do
    #view "favorites"
#end

#get "/nearby" do
#    view "nearby"
#end

get "/surpriseme" do
    view "surpriseme"
end

#get "/users/new" do
#    view "auth_new_user"
#end

#get "/users/create" do
#    puts params
#    users_table.insert(name: params["name"],
#                      email: params["email"],
#                       password: BCrypt::Password.create(params["password"]))
#    view "auth_create_user"
#end

#get "/logins/new" do
#    view "auth_new_login"
#end

#post "/logins/create" do
#    puts params
#    email_address = params["email"]
#    password = params["password"]

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

#get "/logout" do
#    session["user_id"] = nil
#    view "logout"
#end
