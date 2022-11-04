# frozen_string_literal: true

class Product
  attr_accessor :name, :price, :category

  def unitary_taxed_amount
    (price + unitary_tax).ceil(2)
  end

  def unitary_tax
    ((price / 100.0) * category.tax_percentage).ceil(2)
  end
end
