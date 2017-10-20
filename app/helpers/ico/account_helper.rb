module Ico::AccountHelper
  def ref_link
    ref = 'https://ico.ratedate.net/?ref='+current_user.id.to_s
    ref.html_safe
  end
end
