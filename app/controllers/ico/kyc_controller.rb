class Ico::KycController < Ico::IcoController
  before_action :authenticate_ico_user!
  def create
    @kyc = current_ico_user.build_kyc(kyc_params)
    @kyc.wallet = current_ico_user.eth_wallet if current_ico_user.eth_wallet.present?
    if @kyc.save
      redirect_to ico_account_path(:locale => I18n.locale), notice: 'Identity authentication information successfully sent'
    else
      message = '<ul>'
      @kyc.errors.full_messages.each{|msg| message+='<li>'+msg+'</li>'}
      message += '</ul>'
      redirect_to ico_account_path(:locale => I18n.locale), alert: message
    end
  end
  
  private

  def kyc_params
    params.require(:kyc).permit(:firstname, :lastname, :wallet, :country, :address_line_1, :address_line_2, :state, :province, :postal_code, :identity_photo, :address_photo)
  end
end