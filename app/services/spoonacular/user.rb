module Spoonacular
  class User < Base
     attr_accessor :id,:email,:password,:password_confirmation,:first_name,:last_name,:phone_number,:otp

     MAX_LIMIT = 12
     CACHE_DEFAULTS = { expires_in: 7.days, force: false }
     def self.random(query = {}, clear_cache)
       cache = CACHE_DEFAULTS.merge({ force: clear_cache })
       response = Request.where('users', cache, query.merge({ number: MAX_LIMIT }))

       recipes = response.fetch('users', []).map { |recipe| Recipe.new(recipe) }
       [ recipes, response[:errors] ]
     end

     def self.get_users
       response = Request.get("api/users/list", CACHE_DEFAULTS)
       p "============1111111111111"
       p response
       p 222222222222222
       p response.count
       p 44444444444444444
       response = response.map{|each_r| User.new(each_r) }
       return response

     end

     def self.login_new

       @user = User.new
     end
     def self.forgot_password(params)

       response = Request.post("api/users/password",params, CACHE_DEFAULTS)
     end

     def self.signup(params)

       response = Request.post("api/users",params, CACHE_DEFAULTS)
     end
     def self.verify_login(params)
       response = Request.post("api/users/verify_login",params, CACHE_DEFAULTS)

     end

     def self.login(params)
       response = Request.post("api/users/login",params, CACHE_DEFAULTS)
     end

     def self.users
       response = Request.get("api/users/list", CACHE_DEFAULTS)
       # User.new(response)
     end

     def self.search(params)


       response = Request.get("api/users/search?query=#{params[:query]}", CACHE_DEFAULTS)

       p "============1111111111111"
       p response
       p 222222222222222
       p response.count
       p 44444444444444444
       response = response.map{|each_r| User.new(each_r) }
       return response
     end



     def self.find(id)
       response = Request.get("recipes/#{id}/information", CACHE_DEFAULTS)
       Recipe.new(response)
     end

     def initialize(args = {})
       super(args)
       # self.ingredients = parse_ingredients(args)
       # self.instructions = parse_instructions(args)
     end


  end
end