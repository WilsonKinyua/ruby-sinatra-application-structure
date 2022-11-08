class ApplicationController < Sinatra::Base
    set :default_content_type, "application/json"
    before do
        response.headers["Access-Control-Allow-Origin"]="*"
    end

    options "*" do
        response.headers["Access-Control-Allow-Methods"]="GET,POST,PUT,PATCH,DELETE,OPTIONS"
    end

    # to get all buyers
        get "/buyers" do
            Buyer.all.to_json
        end

    # to get all sellers
        get "/sellers" do
            Seller.all.to_json
        end


# POST IN buyers
        post "/buyers" do
            buyers=Buyer.create(
                name: params[:name],
                email: params[:email],
                password: params[:password]
            )
            buyers.to_json
        end

# DELETE IN Buyers
        delete "/buyers/:id" do
            buyers = Buyer.find(params[:id])
            buyers.destroy
            {message: "Buyer '#{buyers.name}' has been deleted."}.to_json
        end

# POST in sellers
        post "/sellers" do
            sellers=Seller.create(
                name: params[:name],
                email: params[:email],
                password: params[:password]
            )
            sellers.to_json
        end
# DELETE IN SELLERS
    delete "/sellers/:id" do
        sellers=Seller.find(params[:id])
        sellers.destroy
        {message: "seller '#{sellers.name}' has been deleted."}.to_json
    end     
        
end