# frozen_string_literal: true

class TestShipmentService
  attr_reader :shipped_order

  def initialize
    @shipped_order = nil
  end

  def ship(order)
    raise OrderShipmentUseCase::OrderCannotBeShippedError if order.created? || order.rejected?
    raise OrderShipmentUseCase::OrderCannotBeShippedTwiceError if order.shipped?

    @shipped_order = order
    order.shipped!
  end
end
