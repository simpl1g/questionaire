class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :authorizations
  has_many :links

  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where(:email => auth["info"]["email"]).first : current_user
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0,10]
        user.name = auth.info.name
        user.email = auth.info.email
        auth.provider == "vkontakte" ? user.save(:validate => false) : user.save
      end
      authorization.username = auth.info.nickname
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end

  def self.from_auth_info(info)
    create(:password => Devise.friendly_token[0, 10], :name => info.name, :email => info.email)
  end
end
