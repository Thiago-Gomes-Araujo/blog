class Article < ApplicationRecord
    belongs_to :Category
    validates :title, presence: true, length: { minimum: 5 }
    validates :body, presence: true, length: { minimum: 10 }

    scope :desc_order, -> { order(created_at: :desc) }
    scope :without_highlights, ->(ids) { where("id NOT IN(#{ids})") if ids.present? }

end
