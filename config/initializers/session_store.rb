# Share session across subdomains. Some bug with omniauth.
# Rails.application.config.session_store :cookie_store, key: '_ratedate_session', domain: {
#     production: '.ratedate.net',
#     development: '.localhost:3000'
# }.fetch(Rails.env.to_sym, :all)