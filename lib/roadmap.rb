module Roadmap

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