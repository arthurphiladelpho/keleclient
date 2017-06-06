require "httparty"

class Kele
	include HTTParty

	def initialize(email, password)

		values = {
			"email": email, 
			"password": password
		}

		response = self.class.post(
							 "https://www.bloc.io/api/v1/sessions", 
							 :body => values.to_json, 
							 :headers => { 'Content-Type' => 'application/json' } 
							 )
		puts response.code
		raise "Invalid email or password" if response.code == 404
		@auth_token = response["auth_token"]
	end

end