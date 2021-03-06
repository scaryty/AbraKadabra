class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:rememberable, :trackable, :omniauthable
  
  has_many :posts      

  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  		user.email = auth.info.email
  		user.name = auth.info.name
  		user.password = Devise.friendly_token[0,20]
  		#user.image = auth.info.image

	end
  end
end
