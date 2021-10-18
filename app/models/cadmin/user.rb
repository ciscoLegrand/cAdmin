module Cadmin
  class User < ApplicationRecord
    include PgSearch::Model

    include ImageUploader::Attachment(:avatar)
    
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: { case_sensitive: false }, on: :update
    validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true # para no permitir caracteres especiales
    validates :role, presence: true

    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :events

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: { case_sensitive: false }, on: :update
    validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true # para no permitir caracteres especiales
    validates :role , presence: true

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

    # TODO: move validations to concern
    def user?
      %w(user admin superadmin).include?(self.role)
    end

    def customer?
      %w(customer admin superadmin).include?(self.role)
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
