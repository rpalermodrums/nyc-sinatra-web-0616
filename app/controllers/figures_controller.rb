class FiguresController < ApplicationController
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    # binding.pry
    title = Title.find_or_create_by(name: params[:title][:name])
    landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
    title_ids = params[:figure][:title_ids]
    landmark_ids = params[:figure][:landmark_ids]
    @figure = Figure.create(params["figure"])
    @figure.title_ids, @figure.landmark_ids = title_ids, landmark_ids
    # binding.pry
    @figure.titles << title
    @figure.landmarks << landmark
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params["id"])
    @titles, @landmarks = @figure.titles, @figure.landmarks
    erb :'figures/show'
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params["id"])
    # binding.pry
    @titles, @landmarks = Title.all, Landmark.all
    erb :'figures/edit'
  end

  patch "/figures/:id" do
    @figure = Figure.find(params["id"])
    # binding.pry
    title = Title.find_or_create_by(name: params[:title][:name])
    landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
    title_ids = params[:figure][:title_ids]
    landmark_ids = params[:figure][:landmark_ids]
    @figure = Figure.find(params["id"])
    @figure.title_ids.each do |id|
      @figure.titles << Title.find(id)
    end
    @figure.landmark_ids.each do |id|
      @figure.landmarks << Landmark.find(id)
    end
    @figure.name = params[:figure][:name]
    @figure.save
    # binding.pry
    @figure.titles << title
    @figure.landmarks << landmark
    # binding.pry
    redirect to "/figures/#{@figure.id}"
  end



end
