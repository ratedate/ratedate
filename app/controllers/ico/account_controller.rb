class Ico::AccountController <  Ico::IcoController
  layout "ico_account"
  def index

  end

  def add_eth
    if current_user.eth_wallet.nil?
      current_user.eth_wallet = params[:eth_wallet]
      if current_user.save
        redirect_to ico_account_path(:locale => I18n.locale)
      else
        redirect_to ico_account_path(:locale => I18n.locale)
      end
    end
  end

  private
  def eth_wallet
    params.permit[:eth_wallet]
  end

end
