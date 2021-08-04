class UsersController < ApplicationController
  include ::ActionController::Cookies

  before_action :check_authentication, :only=>[:index]
  def index
    #  @tag = query.fetch(:tags, 'all')
    # @refresh_params = refresh_params
    # @users, @errors = Spoonacular::User.users
    @users = Spoonacular::User.get_users
    p 111111111
    p @users
  end

  def login_new

    @user = Spoonacular::User.login_new

  end

  def login
    # @user = Spoonacular::User.login(params)
    @user = Spoonacular::User.login(permit_user_params.to_h)

    if !@user["errors"].present?
      session[:jwt] = @user.to_json
      redirect_to "/", notice: "Login successfull..!."
    else
      redirect_to "/users/login_otp" , error: @user["errors"]
    end
  end

  def logout
    session[:jwt] = nil
    if !session[:jwt].present?
      redirect_to "/users/login_new",notice: "Signed out successfully."
    end

  end

  def verify_login

    @user = Spoonacular::User.verify_login(permit_user_params.to_h)


    if !@user["errors"].present?

      redirect_to "/users/login_otp", notice: "OTP successfully sent to email/phone,please validate from below."
    else
      redirect_to "/users/login_new" , error: @user["errors"]
    end

  end

  def login_otp

    # @user = Spoonacular::User.verify_login(permit_user_params.to_h)
    # if @user.present?
    #   redirect_to ""
    # end

  end

  def signup
    @user = Spoonacular::User.signup(permit_user_params.to_h)

    if !@user["errors"].present?

      redirect_to "/users/login_new", notice: "Confirmation link successfully sent to mail."
    else
      redirect_to "/users/signup_new" , error: @user["errors"]
    end

  end

  def signup_new
  end


  def forgot_password
    @user = Spoonacular::User.forgot_password(permit_user_params.to_h)
    if !@user["errors"].present?

      redirect_to "/users/login_new", notice: "Instructions sent to email."
    else
      redirect_to "/users/forgot_password_new" , error: @user["errors"]
    end
  end

  def forgot_password_new


  end

  def reset_password
  end

  def search

    @users = Spoonacular::User.search(search_params.to_h)
    p 333333333333
    p @users
    p 444444444

  end

  def check_authentication

    if !session[:jwt].present?
      redirect_to "/users/login_new"

    end

  end

  private
  def query
    params.fetch(:query, {})
  end

  def clear_cache
    params[:clear_cache].present?
  end

  def refresh_params
    refresh = { clear_cache: true }
    refresh.merge!({ query: query }) if query.present?
    refresh
  end

  def search_params
    params.permit(:query)
  end


  def permit_user_params
    # permitted = params.permit(:email, :password,:first_name,:last_name)
    # permitted = params.require(:user).permit(:email, :password,:first_name,:last_name)
    # permitted =  params.permit(:user)
    params.permit(user: [ :email, :password,:password_confirmation,:first_name,:last_name,:otp_attempt,:phone_number])
    # permitted
  end
end
