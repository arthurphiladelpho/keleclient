require "httparty"
require "json"

class Kele
	include HTTParty
	include JSON
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
		  end
		  if key == "id"
		  	@id = value
		  end
		end	
		puts "Id was set to #{@id}."
		return @current_user
	end

	def get_mentor_availability(id)
		response = self.class.get("/mentors/#{id}/student_availability", headers: { "authorization" => @auth_token } )	
		@mentor_availability = JSON.parse(response.body)
	end

end