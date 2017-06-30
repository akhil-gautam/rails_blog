class User < ActiveRecord::Base
  
  has_many :articles, dependent: :destroy
  has_many :comments
  has_many :providers, dependent: :destroy

  has_many :friendships
  has_many :friends, :through => :friendships


  has_attached_file :avatar, styles: { medium: "200x200>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :name, {:presence => true, :uniqueness => true, :length => {:minimum =>2}}
                        
 
  devise  :database_authenticatable, :registerable, :async,
          :recoverable, :rememberable, :trackable, :validatable, :lockable,
          :omniauthable, :omniauth_providers => [:facebook, :twitter]



  def self.create_user_with_omniauth(auth)
    create(:email => auth.info.email, password: Devise.friendly_token)
  end
  
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

end

