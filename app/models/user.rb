class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :instagrams, dependent: :destroy
  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader

  has_many :likes, dependent: :destroy
  has_many :liked_instagrams, through: :likes, source: :instagram

  def already_liked?(instagram)
    self.likes.exists?(instagram_id: instagram.id)
  end
end
