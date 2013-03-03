class User < ActiveRecord::Base
  devise :registerable
  devise :rememberable
  devise :trackable
  devise :omniauthable, omniauth_providers: [:github]
end
