module Cadmin
  class User < ApplicationRecord
    extend FriendlyId

    friendly_id :username, use: :slugged

    include Cadmin::PermissionLevel
    include PgSearch::Model

    include ImageUploader::Attachment(:avatar)

    validates :email, presence: true,
                      uniqueness: true,
                      format: { with: /\A(.+)@(.+)\z/ },
                      length: { minimum: 4, maximum: 254 }

    validates :username, presence: true, 
                         uniqueness: { case_sensitive: false }, 
                         on: :update

    validates :phone, uniqueness: { case_sensitive: false },
                      format: { with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/},
                      length: {minimum: 9, maximum: 12}

    validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true # para no permitir caracteres especiales
    validates :role, presence: true

    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :events
    has_many :interviews, dependent: :destroy

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, 
           :trackable, :invitable

    # todo: create page's results
    scope :filter_between_dates, -> (start_date, end_date) { where(created_at: start_date..end_date) }
    scope :filter_by_user_id, -> (user_id) { where(id: user_id)}

    pg_search_scope :filter_by_search, against: [
      :username, 
      :name, 
      :last_name,
      :email
    ]

    def create_stripe_customer
      # to prevent create stripe customer every time that user buy a service
      customer = Stripe::Customer.create({
        email: self.email,
      })
      self.update!(role: 'customer', stripe_customer_id: customer.id)
    end
  end
end
