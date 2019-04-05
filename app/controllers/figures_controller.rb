class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params["title"]["name"].empty?
      @title = Title.create(name: params["title"]["name"])
      @title.figures << @figure
    end
    if !params["landmark"]["name"].empty?
      @landmark = Landmark.create(name: params["landmark"]["name"])
    end
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @titles = @figure.titles
    @landmarks = @figure.landmarks
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    ####### bug fix to remove previous titles
    if !params[:figure].keys.include?("title_ids")
      params[:figure]["title_ids"] =[]
    end
    #######
    ####### bug fix to remove previous landmarks
    if !params[:figure].keys.include?("landmark_ids")
      params[:figure]["landmark_ids"] = []
    end
    #######
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end
    redirect "/figures/#{@figure.id}"
  end

end
