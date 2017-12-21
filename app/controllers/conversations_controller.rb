class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_profile!
  before_action :set_conversation, except: [:index]
  before_action :check_participating!, except: [:index]

  layout "wide"

  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    respond_to do |format|
      format.html
      format.js {render layout: false}
    end
  end

  def show
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    @personal_message = PersonalMessage.new
    respond_to do |format|
      format.html
      format.js {render layout: false}
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:id])
  end

  def check_participating!
    redirect_to conversations_path unless @conversation && @conversation.participates?(current_user)
  end


  def check_user_profile!
    redirect_to my_profile_path unless current_user.profile.present?
  end


end
