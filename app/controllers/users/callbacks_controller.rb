class Users::CallbacksController < Devise::OmniauthCallbacksController

  def github
    auth = request.env["omniauth.auth"]
    @user = User.where(provider: auth.provider, uid: auth.uid).first
    @user = User.create!(user_attributes(auth)) unless @user
    sign_in_and_redirect(@user, event: :authentication)
    set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
  end

  private

    def user_attributes(auth)
      {
        provider: auth.provider,
        uid: auth.uid,
        name: auth.info.name,
        email: auth.info.email,
        login: auth.info.nickname,
        token: auth.credentials.token
      }
    end

end