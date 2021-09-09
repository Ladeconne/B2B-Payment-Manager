class TransactionsController < ApplicationController
  def create
    case params[:transaction][:nature]
    when "payment"
      @transaction = Transaction.new(payment_params)
    when "invoice"
      @transaction = Transaction.new(invoice_params)
    else
      render './shared/payment_form'
    end

    authorize @transaction
    if @transaction.save
      redirect_to dashboard_path
    else
      render
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
