class User < ActiveRecord::Base
  include GithubProvisioner::User

  # Devise

  devise :registerable
  devise :rememberable
  devise :trackable
  devise :omniauthable, omniauth_providers: [:github]
end
