# frozen_string_literal: true

class OrderItem
  attr_accessor :product, :quantity

  def initialize(product:, quantity:)
    @product = product
    @quantity = quantity
  end

  def taxed_amount
    (product.unitary_taxed_amount * quantity).ceil(2)
  end

  def tax
    (product.unitary_tax * quantity).ceil(2)
  end
end
