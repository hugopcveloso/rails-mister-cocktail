class Cocktail < ApplicationRecord
  has_many :doses
  has_many :ingredients, through: :doses, dependent: :destroy
  has_one_attached :photo

  validates :name, uniqueness: true, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_and_ingredient,
    against: [ :name ],
    associated_against: {
      ingredients: [:name]
    },
    using: {
      tsearch: { prefix: true }
 }
end
