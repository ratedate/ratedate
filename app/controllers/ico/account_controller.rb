class Ico::AccountController <  Ico::IcoController
  layout "ico_account"
  before_action :authenticate_ico_user!
  def index
    @referrals = current_ico_user.referrals.where("eth_wallet IS NOT NULL AND created_at<='2018-03-12'::date").count
    @etz_investments = EtzInvestment.where('etz IS NOT NULL AND lower(wallet) = ?', current_ico_user.eth_wallet.downcase) if current_ico_user.eth_wallet.present?
    @eth_investments = EtzInvestment.where('eth IS NOT NULL AND lower(wallet) = ?', current_ico_user.eth_wallet.downcase) if current_ico_user.eth_wallet.present?
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
