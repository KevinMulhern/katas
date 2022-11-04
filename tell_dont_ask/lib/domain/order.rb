# frozen_string_literal: true

class Order
  attr_accessor :currency, :items, :status, :id

  def initialize(currency: 'EUR', items: [], status: OrderStatus::CREATED, id: nil)
    @currency = currency
    @items = items
    @status = status
    @id = id
  end

  def add_item(item)
    @items << item
  end

  def total
    @items.sum(&:taxed_amount)
  end

  def tax
    @items.sum(&:tax)
  end

  def rejected?
    status == OrderStatus::REJECTED
  end

  def created?
    status == OrderStatus::CREATED
  end

  def shipped?
    status == OrderStatus::SHIPPED
  end
end
