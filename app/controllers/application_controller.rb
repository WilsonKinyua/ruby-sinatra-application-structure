class ApplicationController < Sinatra::Base

    set :default_content_type, "application/json"

    get '/' do # this is the root route of the application (the homepage) but you can have as many routes as you want
        {hello: "Just a starting code 😃"}.to_json
    end

    # fetch all categories
    get '/categories' do
        # {categories: "Here's the api endpoint"}.to_json
        Category.all.to_json
    end

    # find category by id
    get '/category/:id' do
        Category.find(params[:id]).to_json
    end

    #fetch all todo_lists
    get '/todo_lists' do
        TodoList.all.to_json
    end

    #fetch todo_list by id
    get '/todo_list/:id' do
        TodoList.find(params[:id]).to_json
    end

    
end