class Users::RegistrationsController < Devise::RegistrationsController
  layout 'application'

  prepend_before_action :require_no_authentication, only: [ :signup_success, :new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy, :autocomplete ]
  # protect_from_forgery except:  [  :update, :edit ]


  def signup_success
    if params[:resource]
      @user = params[:resource]
    end
  end

  def new
    super
  end





  def create

    build_resource(sign_up_params)


    resource.save
    yield resource if block_given?
    if resource.persisted?

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end


def destroy
  user_details
  @name =  resource.firstname
  @email =  resource.email
  resource.destroy
  NotifierMailer.delete_user_account(@email, @name).deliver_later
  Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
  set_flash_message :notice, :destroyed if is_flashing_format?
  yield resource if block_given?
  respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
end
def cancel
  expire_data_after_sign_in!
  redirect_to new_registration_path(resource_name)
end

protected

def update_needs_confirmation?(resource, previous)
  resource.respond_to?(:pending_reconfirmation?) &&
  resource.pending_reconfirmation? &&
  previous != resource.unconfirmed_email
end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  # def sign_up(resource_name, resource)
  #   after_sign_in_path_for(resource)
  # end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    signup_success_path
  end

  def set_minimum_password_length
    if devise_mapping.validatable?
      @minimum_password_length = resource_class.password_length.min
    end
  end


  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    # scope = Devise::Mapping.find_scope!(resource)
    # router_name = Devise.mappings[scope].router_name
    # context = router_name ? send(router_name) : self
    # context.respond_to?(:root_path) ? context.root_path : "/"
     signup_success_path
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  # def after_update_path_for(resource)
  #   signed_in_root_path(resource)
  # end

  def after_inactive_sign_up_path_for(resource)
     signup_success_path
  end
   def after_inactive_sign_up_path_for(resource)
    signup_success_path
  end




 #  def add_default_preferences
 #   @user.user_preferences.create!(user_id: @user.id, preference_id: 5, answer: 'organizer')
 #   @user.user_preferences.create!(user_id: @user.id, preference_id: 7, answer: 'organizer')
 #   @user.user_preferences.create!(user_id: @user.id, preference_id: 9, answer: 'yes')
 #   Profile.create!(user_id: @user.id, country: 'USA', language: 'en-us')
 # end


 def after_update_path_for(resource)
  #
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end

  def translation_scope
    'devise.registrations'
  end


end