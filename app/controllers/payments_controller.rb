class PaymentsController < ApplicationController
  before_action :authenticate_user!, except: [:process_payment_result]

  skip_before_action :verify_authenticity_token, only: [:process_payment_result, :payment_result]

  def payment
    if payment_params[:rdt_amount] && payment_params[:rdt_amount].to_i>0
      @payment = current_user.payments.build
      @payment.order_id = SecureRandom.uuid
      @payment.rdt_amount = payment_params[:rdt_amount].to_i
      @payment.amount = payment_params[:rdt_amount].to_i*10
      @payment.save
    else
      redirect_to my_profile_path
    end
  end

  def payment_result
    if payment_params[:order_id]
      @payment = Payment.where('order_id=?',payment_params[:order_id]).last
      @success = payment_params[:order_status]=='approved' ? true : false
      if @payment
        @response = case payment_params[:order_status]
                      when 'approved'
                        'Success! '+@payment.rdt_amount.to_s+' RDT added to your balance'
                      when 'declined'
                        'Payment was declined'
                      when 'processing'
                        'Payment processing.'
                      else
                        'Something went wrong.'
                    end
      end
    end
  end

  def process_payment_result
    ip_set = ['127.0.0.1', '54.76.178.89', '54.154.216.60']
    if payment_params[:order_id] && ip_set.any? {|ip| ip==request.remote_ip}
      @payment = Payment.where('order_id=?',payment_params[:order_id]).last
      if @payment && @payment.order_status != 'approved'
        @payment.update(payment_params)
        if payment_params[:order_status] == 'approved'
          @payment.complete
        end
      end
    end
  end

  def payment_redirect
    redirect_to my_profile_path
  end

  private

  def payment_params
    params.permit(:rdt_amount, :amount, :order_id, :amount, :currency, :order_status, :response_status, :signature, :tran_type, :response_signature_string)
  end

  def check_response_signature(string, signature)
    if string && signature
      Digest::SHA1.hexdigest(string.gsub('**********','2N06Wdf1D8EJnngRWJOlSwQeTZuZAoa2'))==signature
    else
      false
    end
  end

end