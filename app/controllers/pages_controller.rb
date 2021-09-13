class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :set_active_profile, only: [:dashboard, :invoices, :payments]

  def home
    @page = "home"
  end

  def dashboard
    @page = "dashboard"
    authorize @active_profile, policy_class: ProfilePolicy
    # Retrieve invoices and payments
    @invoices = Transaction.where(profile: @active_profile, nature: "invoice")
    @payments = Transaction.where(profile: @active_profile, nature: "payment")

    # Calculate daily, monthly and balance totals
    @credit_day = calc_total_today("invoice")
    @debit_day = calc_total_today("payment")
    @credit_month = calc_total_month("invoice")
    @debit_month = calc_total_month("payment")
    @balance = calc_balance

    # Initiate a new invoice for the invoice form
    @new_invoice = Transaction.new
    @new_invoice.nature = "invoice"
    @new_invoice.profile_id = @active_profile.id

    # Initiate a new payment for the payment form
    @new_payment = Transaction.new
    @new_payment.nature = "payment"
    @new_payment.profile_id = @active_profile.id
  end

  def invoices
    @page = "invoices"
    authorize @active_profile, policy_class: ProfilePolicy
    # Retrieve invoices, sort them by date descending and limit the answer size
    @invoices = Transaction.where(profile: @active_profile, nature: "invoice").order("created_at DESC").limit(30)
    # Initiate a new invoice for the invoice form
    @new_invoice = Transaction.new
    @new_invoice.nature = "invoice"
    @new_invoice.profile_id = @active_profile.id
  end

  def payments
    @page = "payments"
    authorize @active_profile, policy_class: ProfilePolicy
    # Retrieve invoices
    @payments = Transaction.where(profile: @active_profile, nature: "payment").order("created_at DESC").limit(30)
    # Initiate a new payment for the payment form
    @new_payment = Transaction.new
    @new_payment.nature = "payment"
    @new_payment.profile_id = @active_profile.id
  end

  private

  # DASHBOARD CALCULATIONS
  def calc_total_today(nature)
    # nature should be equal to "invoice" or "payment"
    transactions = Transaction.where(profile: @active_profile, nature: nature, date: Date.today.all_day)
    transactions.reduce(0) { |total, transaction| total + transaction.amount }
  end

  def calc_total_month(nature)
    # nature should be equal to "invoice" or "payment"
    month = Date.today.month
    transactions = Transaction.where(profile: @active_profile, nature: nature)
                              .where("EXTRACT(MONTH FROM date) = ?", month)
    transactions.reduce(0) { |total, transaction| total + transaction.amount }
  end

  def calc_total(nature)
    # nature should be equal to "invoice" or "payment"
    transactions = Transaction.where(profile: @active_profile, nature: nature)
    transactions.reduce(0) { |total, transaction| total + transaction.amount }
  end

  def calc_balance
    # nature should be equal to "invoice" or "payment"
    tot_invoice = calc_total("invoice")
    tot_payment = calc_total("payment")
    return tot_invoice - tot_payment
  end

  def set_active_profile
    # Get every profile of the user
    if params[:profile_id]
      session[:profile_id] = params[:profile_id]
      # If a param is setting the profile_id used than set it as active_profile
      @active_profile = Profile.find(session[:profile_id])
    elsif session[:profile_id]
      @active_profile = Profile.find(session[:profile_id])
    else
      # Set the profile as the first of the user
      @profiles = current_user.profiles
      @active_profile = @profiles.first
    end
  end
end
