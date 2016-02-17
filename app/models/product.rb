class Product < ActiveRecord::Base
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item
	validates :title, :description, :image_url, presence: true
	validates :title, uniqueness: true
	# validates :title, length: 4
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\z}i,
		message: 'must be a URL for GIF, JPG or PNG image'
	}

	def self.latest
		Product.order(:updated_at).last
	end

	private

	#no any items xonnected with baskeket

	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'существуют товарные позиции')
			return false
		end
	end
	
end
