require "httparty"
require "json"
require "roadmap"

class Kele
	include HTTParty
	include JSON
	include Roadmap

	base_uri 'https://www.bloc.io/api/v1'
	
	def initialize(email, password)
		
		response = self.class.post("/sessions", body: { "email": email, "password": password } )
		puts response.code
		raise "Invalid email or password" if response.code == 404
		@auth_token = response["auth_token"]
	
	end

	def get_me
		response = self.class.get("/users/me", headers: { "authorization" => @auth_token } )
		@current_user = JSON.parse(response.body)
		@current_user.each do |key, value|
		  if key == "name"
		  	puts "Current user is #{value}."
		  	return value
		  end
		end	
	end

end