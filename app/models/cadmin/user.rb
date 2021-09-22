module Cadmin
  class User < ApplicationRecord
    include PgSearch::Model

    include ImageUploader::Attachment(:avatar)
    
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: { case_sensitive: false }, on: :update
    validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true # para no permitir caracteres especiales
    validates :role, :invitation_token, presence: true

    has_many :articles
    has_many :comments

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: { case_sensitive: false }, on: :update
    validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true # para no permitir caracteres especiales
    validates :role, :invitation_token, presence: true

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    scope :filter_between_dates, -> (start_date, end_date) { where(created_at: start_date..end_date) }
    scope :filter_by_user_id, -> (user_id) { where(id: user_id)}

    pg_search_scope :filter_by_search, against: [
      :username, 
      :name, 
      :last_name,
      :email
    ]

    # TODO: move to concern
    def user?
      %w(user employee admin superadmin).include?(self.role)
    end
    def employee?
      %w(employee admin superadmin).include?(self.role)
    end
    def admin?
      %w(admin superadmin).include?(self.role)
    end
    def superadmin?
      %w(superadmin).include?(self.role)
    end
  end
end
