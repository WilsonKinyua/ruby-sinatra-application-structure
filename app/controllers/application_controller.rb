class ApplicationController < Sinatra::Base
    # format all data to json
    set :default_content_type, "application/json"

    # allow all api endpoints to be accessed
    before do
        response.headers['Access-Control-Allow-Origin'] = "*"
    end

    # enable CORS preflight requests
    options "*" do
        response.headers["Access-Control-Allow-Origin"] = ""
    end



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

    #fetch todo_list by title
    # get '/todo_list/:title' do
    #     TodoList.find_by(title: params[:id]).to_json
    # end

    # post new todo_list
    post '/todo_list' do
        todo_list = TodoList.create(
            title: params[:title],
            description: params[:description],
            category_id: params[:category_id]
        )
        todo_list.to_json
    end

    # update new todo_list
    patch '/todo_list' do
        todo_list = TodoList.find(params[:id])
        todo_list.update(
            title: params[:title],
            description: params[:description],
            category_id: params[:category_id],
            status: params[:status]
        )
        {message: "TodoList was successfully updated!"}.to_json
    end

    # delete a specific category
    # delete "/todo_list" do
    #     todo_list = TodoList.find_by_id(params[:id])
    #     todo_list.delete(
    #         title: params[:title],
    #         description: params[:description],
    #         category_id: params[:category_id],
    #         status: params[:status]
    #     )
    #     {message: "TodoList was successfully deleted!"}.to_json
    # end

end