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
		puts @current_user["name"]
		@current_user
	end

	def get_mentor_availability(id)
	  @mentor_availability ||= begin
	    JSON.parse(self.class.get("/mentors/#{id}/student_availability", headers: { "authorization" => @auth_token } ))
	  end
	end

end