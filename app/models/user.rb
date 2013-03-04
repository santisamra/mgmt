class User < ActiveRecord::Base
  include Github::User

  # Devise

  devise :registerable
  devise :rememberable
  devise :trackable
  devise :omniauthable, omniauth_providers: [:github]
end
