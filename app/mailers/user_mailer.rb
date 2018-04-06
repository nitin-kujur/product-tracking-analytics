class UserMailer < ApplicationMailer
	def order_paid_email(order, params)
		@order = order.id
		mail(to: "NKujur@LapineInc.com, PChaudhari@LapineInc.com", subject: "Order #{params[:id]} marked as Paid")
	end
end
