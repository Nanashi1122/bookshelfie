class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors, through: :book_authors

  def save_with_author(authors)
    ActiveRecord::Base.transaction do
      save!  # Bookの保存
      self.authors = authors.uniq.reject(&:blank?).map do |name|
        Author.find_or_create_by(name: name.strip)
      end
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end
end
