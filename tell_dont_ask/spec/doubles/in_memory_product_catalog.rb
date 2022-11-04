# frozen_string_literal: true

class InMemoryProductCatalog

  def initialize(products)
    @products = products
  end

  def get_by_name(name)
    product = @products.find { |p| p.name == name }

    raise OrderCreationUseCase::UnknownProductError if product.nil?
    product
  end
end
