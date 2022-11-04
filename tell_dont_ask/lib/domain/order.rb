# frozen_string_literal: true

class Order
  attr_accessor :total, :currency, :items, :tax, :status, :id

  def initialize(total: 0.0, currency: 'EUR', items: [], tax: 0.0, status: OrderStatus::CREATED, id: nil)
    @total = total
    @currency = currency
    @items = items
    @tax = tax
    @status = status
    @id = id
  end

  def add_item(item)
    @items << item
  end
end
