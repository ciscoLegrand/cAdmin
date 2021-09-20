module Cadmin
  class User < ApplicationRecord
    include ImageUploader::Attachment(:avatar)
    has_many :articles
    has_many :comments


    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  end
end
