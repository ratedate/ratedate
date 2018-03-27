# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from("users_#{current_user.id}_channel")
  end

  def unsubscribed
  end
end