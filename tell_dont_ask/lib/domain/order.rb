# frozen_string_literal: true

class Order
  class ShippedOrdersCannotBeChangedError < StandardError; end
  class RejectedOrderCannotBeApprovedError < StandardError; end
  class ApprovedOrderCannotBeRejectedError < StandardError; end

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

  def approved?
    status == OrderStatus::APPROVED
  end

  def shipped?
    status == OrderStatus::SHIPPED
  end

  def shipped!
    @status = OrderStatus::SHIPPED
  end

  def reject!
    raise ShippedOrdersCannotBeChangedError if shipped?
    raise ApprovedOrderCannotBeRejectedError if approved?

    @status = OrderStatus::REJECTED
  end

  def approve!
    raise ShippedOrdersCannotBeChangedError if shipped?
    raise RejectedOrderCannotBeApprovedError if rejected?

    @status = OrderStatus::APPROVED
  end
end
