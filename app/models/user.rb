class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :omniauthable

  validates :fullname, presence: true, length: {maximum: 50}   

  has_many :rooms 


  def self.from_omniauth(auth)
  	    user = User.where(email: auth.info.email).first

    if user
        return user
    else        
  	    where(provide: auth.provide, uid: auth.uid).first_or_initialize.tap do |user|
  	  	user.fullname = auth.info.name
  	  	user.provide = auth.provide
  	  	user.uid = auth.uid
  	  	user.email = auth.info.email
  	  	user.image = auth.info.image
  	  	user.password = Devise.friendly_token[0,20]
        user.save
  	  end  	
    end  

  end

end
