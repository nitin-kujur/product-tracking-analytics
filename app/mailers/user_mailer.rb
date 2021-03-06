class UserMailer < ApplicationMailer
	def order_paid_email(order, params)
		@order = order.id
		mail(to: "NKujur@LapineInc.com, PChaudhari@LapineInc.com", subject: "Order #{params[:id]} marked as Paid")
	end

	def order_cancellation_email(order_local, reason)
		@order = order_local
		mail(to: "NKujur@LapineInc.com, PChaudhari@LapineInc.com", subject: "Order cancelled successfully.")
	end

	def order_update_fail_email(order, shop)
		@order = order.id
		mail(to: "NKujur@LapineInc.com, PChaudhari@LapineInc.com", subject: "Order #{params[:id]} marked as Paid")
	end
end
