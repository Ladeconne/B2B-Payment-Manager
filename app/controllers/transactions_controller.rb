class TransactionsController < ApplicationController

  def create
    @transaction = true
    @page = params[:transaction][:page]
    case params[:transaction][:nature]
    when "payment"
      @new_payment = Transaction.new(payment_params)
      authorize @new_payment
      if @new_payment.save
        redirect_to redirection_url(@page)
      else
        render "_payment_form", new_payment: @new_payment
      end
    when "invoice"
      @new_invoice = Transaction.new(invoice_params)
      @new_invoice.company_paid = "N/A"
      authorize @new_invoice
      if @new_invoice.save
        redirect_to redirection_url(@page)
      else
        render "_invoice_form", new_invoice: @new_invoice
      end
    else
      render './pages/dashboard'
    end
  end

  def destroy
    @id = params[:id]
    raise
    @transaction = transaction.find(@id)
    authorize @transaction
    @transaction.destroy
    authorize @transaction
    redirect_to dashboard_path
  end

  private

  def invoice_params
    params.require(:transaction).permit(:amount, :nature, :date, :profile_id, :received)
  end

  def payment_params
    params.require(:transaction).permit(:amount, :nature, :date, :company_paid, :profile_id, :description)
  end

  def redirection_url(origin)
    case origin
    when "dashboard"
      return dashboard_path
    when "invoices"
      return invoices_path
    when "payments"
      return payments_path
    else
      dashboard_path
    end
  end
end
