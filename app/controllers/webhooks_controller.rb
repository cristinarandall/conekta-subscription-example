class WebhooksController < ApplicationController

def index

        if (params[:type].present?) && (params[:type] == "subscription.payment_failed")
                # mandar correo de falla

        elsif (params[:type].present?) && (params[:type] == "subscription.paid")
		# mandar correo de confirmacion de pago
        elsif (params[:type].present?) && (params[:type] == "subscription.updated")
                # mandar correo 
        elsif (params[:type].present?) && (params[:type] == "subscription.canceled")
                # mandar correo de cancelación
	end


end


end

