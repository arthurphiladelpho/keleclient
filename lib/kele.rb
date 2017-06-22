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

	def get_messages(page)
    response = self.class.get("/message_threads?page=#{page}", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def create_message(email, recipient_id, subject, message)
    response = self.class.post("/messages", body: { "sender": email, "recipient_id": recipient_id, "subject": subject, "stripped-text": message }, headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

end