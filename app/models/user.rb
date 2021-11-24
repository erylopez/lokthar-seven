class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable, omniauth_providers: %i[discord]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "#{auth.provider}_#{auth.uid}@lokthar.com"
      user.password = Devise.friendly_token[0, 20]
      user.discord_username = auth.info.name
      user.discord_discriminator = auth&.extra&.raw_info&.discriminator
      user.discord_avatar = auth.info.image
    end
  end

  def discord_tag
    "#{discord_username}##{discord_discriminator}"
  end
end
