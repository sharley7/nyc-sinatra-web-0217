class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  post '/figures' do
    @figure = Figure.create(params["figure"])
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(params["landmark"])
    else
      @figure.landmarks << Landmark.find_by(params["figure"]["landmark_ids"])
    end
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(params["title"])
    else
      @figure.titles << Title.find_by(params["figure"]["title_ids"])
    end
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
     erb :'figures/show'
   end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params["figure"])
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(params["landmark"])
    #else
      #@figure.landmarks = params["figure"]["landmark_ids"]
    end
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(params["title"])
  #  else
    #  @figure.update(params["figure"]["title_ids"])
    end
    redirect to "/figures/#{@figure.id}"
  end


end
