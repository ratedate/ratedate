class UserBroadcastJob < ApplicationJob
  queue_as :default

  def perform(balance)

    ActionCable.server.broadcast "users_#{balance.user.id}_channel",
                                 available_balance: balance.available_balance
  end
end