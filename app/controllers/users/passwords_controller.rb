class Users::PasswordsController < Devise::PasswordsController
  prepend_before_action :require_no_authentication
  # Render the #edit only if coming from a reset password email link
  append_before_action :assert_reset_token_passed, only: :edit
 layout 'application'

  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
     self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end

  protected
    def after_resetting_password_path_for(resource)
      after_sign_in_path_for(resource)
    end

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      new_session_path(resource_name) 
    end

    # Check if a reset_password_token is provided in the request
    def assert_reset_token_passed
      if params[:reset_password_token].blank?
        set_flash_message(:alert, :no_token)
        redirect_to new_session_path(resource_name)
      end
    end

    # Check if proper Lockable module methods are present & unlock strategy
    # allows to unlock resource on password reset
    def unlockable?(resource)
      resource.respond_to?(:unlock_access!) &&
        resource.respond_to?(:unlock_strategy_enabled?) &&
        resource.unlock_strategy_enabled?(:email)
    end
  def set_minimum_password_length
    if devise_mapping.validatable?
      @minimum_password_length = resource_class.password_length.min
    end
  end
  
    def translation_scope
      'devise.passwords'
    end
end