class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  prepend_before_filter :require_no_authentication
  layout 'application'

#  def all
#   user = User.from_omniauth(request.env["omniauth.auth"])
#     if user.persisted? 
#       # flash.notice = "Account Created! Please Check Your Email for a Confirmation."
#       # redirect_to after_inactive_sign_up_path_for(user)
#       sign_in user
#       redirect_to projects_path
#       Visit.create!(user_id: user.id)
#     else
#       session["devise.user_attributes"] = user.attributes
#       redirect_to new_user_registration_url
#     end
#   # end
#   alias_method :facebook, :all
#   alias_method :google_oauth2, :all

# end

def all
  user = User.from_omniauth(request.env["omniauth.auth"])
  if user.persisted?
    flash.notice = "Signed in!"
    sign_in_and_redirect user
  else
    session["devise.user_attributes"] = user.attributes
    redirect_to new_user_registration_url
  end
  alias_method :twitter, :all
  alias_method :facebook, :all
  alias_method :google_oauth2, :all


end

 # def facebook
 #    # You need to implement the method below in your model (e.g. app/models/user.rb)
 #    @user = User.from_omniauth(request.env["omniauth.auth"])

 #    if @user.persisted?
 #      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
 #      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
 #    else
 #      session["devise.facebook_data"] = request.env["omniauth.auth"]
 #      redirect_to new_user_registration_url
 #    end
 #  end




  
end