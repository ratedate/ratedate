class Ico::AccountController <  Ico::IcoController
  layout "ico_account"
  before_action :authenticate_ico_user!
  def index
    @referrals = Kyc.where(user_id: current_ico_user.referral_ids).count
    @etz_investments = EtzInvestment.where('lower(wallet) = ?', current_ico_user.kyc.wallet.downcase) if current_ico_user.kyc.present?
  end

  def add_eth
    if current_ico_user.eth_wallet.nil?&&params[:eth_wallet].size==42&&params[:eth_wallet]=~/^0x/
      current_ico_user.eth_wallet = params[:eth_wallet]
      if current_ico_user.save
        redirect_to ico_account_path(:locale => I18n.locale)
      else
        redirect_to ico_account_path(:locale => I18n.locale)
      end
    else
      redirect_to ico_account_path(:locale => I18n.locale), alert: t(:wrong_eth)
    end
  end

  private
  def eth_wallet
    params.permit[:eth_wallet]
  end

end
