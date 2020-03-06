# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"                                                                 #
require "bcrypt"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################

places_table = DB.from(:places)

before do
    @current_user = users_table.where(id: session["user_id"]).to_a[0]
end

get "/" do
    view "all"
end

get "/:name" do
    view "detail"
end

get "/favorites" do
    view "favorites"
end

get "/nearby" do
    view "nearby"
end

get "/surpriseme" do
    view "surpriseme"
end

get "/users/new" do
    view "auth_new_user"
end

get "/users/create" do
    puts params
    users_table.insert(name: params["name"],
                       email: params["email"],
                       password: BCrypt::Password.create(params["password"]))
    view "auth_create_user"
end

get "/logins/new" do
    view "auth_new_login"
end

post "/logins/create" do
    puts params
    email_address = params["email"]
    password = params["password"]

    @user = users_table.where(email: email_address).to_a[0]
    if @user
        if BCrypt::Password.new(@user[:password]) == password
            session["user_id"] = @user[:id]
            view "auth_create_login"
        else
            view "auth_login_failed"
        end
    else
        view "auth_login_failed"
    end

get "/logout" do
    session["user_id"] = nil
    view "logout"
end
