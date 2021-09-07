class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @invoices = Transaction.where(profile: current_user.profile, nature: "invoice")
    @payments = Transaction.where(profile: current_user.profile, nature: "payment")
    @credit_day = calc_total_today("invoice")
    @debit_day = calc_total_today("payment")
    @credit_month = calc_total_month("invoice")
    @debit_month = calc_total_month("payment")
    @balance = calc_balance()
  end

  private

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
end
