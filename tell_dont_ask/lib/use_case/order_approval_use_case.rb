# frozen_string_literal: true

require_relative '../domain/order_status'

class OrderApprovalUseCase
  class ShippedOrdersCannotBeChangedError < StandardError; end
  class RejectedOrderCannotBeApprovedError < StandardError; end
  class ApprovedOrderCannotBeRejectedError < StandardError; end

  def initialize(order_repository)
    @order_repository = order_repository
  end

  # @param request [OrderApprovalRequest]
  def run(request)
    order = @order_repository.get_by_id(request.order_id)

    if request.approved
      order.approve!
    else
      order.reject!
    end

    @order_repository.save(order)
  end
end
