module Cadmin
  class User < ApplicationRecord
    extend FriendlyId

    friendly_id :username, use: :slugged

    include Cadmin::PermissionLevel
    include PgSearch::Model

    include ImageUploader::Attachment(:avatar)
    
    validates :email, presence: true,
                      format: { with: /\A(.+)@(.+)\z/ },
                      uniqueness: { case_sensitive: false },
                      length: { minimum: 4, maximum: 254 }

    validates :username, presence: true, 
                         uniqueness: { case_sensitive: false }, 
                         on: :update

    validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true # para no permitir caracteres especiales
    validates :role, presence: true

    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :events
    has_many :interviews, dependent: :destroy

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :invitable, :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, :trackable

    # todo: create page's results
    scope :filter_between_dates, -> (start_date, end_date) { where(created_at: start_date..end_date) }
    scope :filter_by_user_id, -> (user_id) { where(id: user_id)}

    pg_search_scope :filter_by_search, against: [
      :username, 
      :name, 
      :last_name,
      :email
    ]
  end
end
