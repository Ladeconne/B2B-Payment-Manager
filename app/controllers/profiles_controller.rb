class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show destroy edit update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def delete
  end

  def update
  end

  def dashboard
    # Retrieve invoices and payments
    @invoices = Transaction.where(profile: current_user.profile, nature: "invoice")
    @payments = Transaction.where(profile: current_user.profile, nature: "payment")

    # Calculate daily, monthly and balance totals
    @credit_day = calc_total_today("invoice")
    @debit_day = calc_total_today("payment")
    @credit_month = calc_total_month("invoice")
    @debit_month = calc_total_month("payment")
    @balance = calc_balance

    # Initiate a new invoice for the invoice form
    @new_invoice = Transaction.new
    @new_invoice.nature = "invoice"
    @new_invoice.profile = current_user.profile

  end

  private

  # DASHBOARD CALCULATIONS
  def calc_total_today(nature)
    # nature should be equal to "invoice" or "payment"
    transactions = Transaction.where(profile: current_user.profile, nature: nature, date: Date.today.all_day)
    transactions.reduce(0) { |total, transaction| total + transaction.amount }
  end

  def calc_total_month(nature)
    # nature should be equal to "invoice" or "payment"
    month = Date.today.month
    transactions = Transaction.where(profile: current_user.profile, nature: nature)
                              .where("EXTRACT(MONTH FROM date) = ?", month)
    transactions.reduce(0) { |total, transaction| total + transaction.amount }
  end

  def calc_total(nature)
    # nature should be equal to "invoice" or "payment"
    transactions = Transaction.where(profile: current_user.profile, nature: nature)
    transactions.reduce(0) { |total, transaction| total + transaction.amount }
  end

  def calc_balance
    # nature should be equal to "invoice" or "payment"
    tot_invoice = calc_total("invoice")
    tot_payment = calc_total("payment")
    return tot_invoice - tot_payment
  end

  # USUAL HELPERS
  def profile_params
    params.require(:profile).permit(:name)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
