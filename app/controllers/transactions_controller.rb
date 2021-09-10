class TransactionsController < ApplicationController
  def create
    case params[:transaction][:nature]
    when "payment"
      @new_payment = Transaction.new(payment_params)
      authorize @new_payment
      if @new_payment.save
        redirect_to dashboard_path
      else
        render "_payment_form", new_payment: @new_payment
      end
    when "invoice"
      @new_invoice = Transaction.new(invoice_params)
      authorize @new_invoice
      if @new_invoice.save
        redirect_to dashboard_path
      else
        render "_invoice_form", new_invoice: @new_invoice
      end
    else
      render './pages/dashboars'
    end
  end

  private

  def invoice_params
    params.require(:transaction).permit(:amount, :nature, :date, :profile_id, :received)
  end

  def payment_params
    params.require(:transaction).permit(:amount, :nature, :date, :company_paid, :profile_id, :description)
  end
end
