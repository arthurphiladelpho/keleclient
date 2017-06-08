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
		  	return value
		  end
		end	
	end

	def get_roadmap(roadmap_id)
    response = self.class.get("/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token })
    response = JSON.parse(response.body)
    @roadmap = response["name"]
    puts "Your roadmaps is #{@roadmap}."
    puts response
    return @roadmap
    # checkpoint id is response["sections"]["checkpoints"]["id" == 1901]
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get("/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token })
    response = JSON.parse(response.body)
  end

end