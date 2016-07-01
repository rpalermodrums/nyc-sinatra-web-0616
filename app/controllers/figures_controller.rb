class FiguresController < ApplicationController
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    # binding.pry
    @figure = Figure.create(params["figure"])

    new_title_and_figure

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
    @titles, @landmarks = Title.all, Landmark.all

    erb :'figures/edit'
  end

  patch "/figures/:id" do
    @figure = Figure.find(params["id"])
    @figure.update(name: params[:figure][:name])

    new_title_and_figure

    redirect to "/figures/#{@figure.id}"
  end

  private

  def new_title_and_figure
    title = Title.find_or_create_by(name: params[:title][:name])
    landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
    @figure.titles << title
    @figure.landmarks << landmark
  end
end
