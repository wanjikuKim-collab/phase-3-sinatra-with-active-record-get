class ApplicationController < Sinatra::Base
    # Add this line to set the Content-Type header for all responses
   set :default_content_type, 'application/json'

  get '/games' do
    # get all the games from the database
    games = Game.all.order(:title).limit(10)
    # return a JSON response with an array of all the game data
    games.to_json
  end

  #adding a dynamic route to controller
  get '/games/:id' do
    game = Game.find(params[:id])
    # game.to_json(include: {reviews: {include: :user}})
    game.to_json(only:[:id, :title, :genre, :price], include:{
      reviews:{only:[:comment, :score], include: {user: {only: [:name]}}}
    })
  end

end
