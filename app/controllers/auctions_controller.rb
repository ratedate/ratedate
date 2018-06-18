class AuctionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_auction, only: [:show, :edit, :update, :destroy, :videodate]
  # before_action :check_access, only: :videodate

  layout 'videodates', only: [:videodate]
  # GET /auctions
  # GET /auctions.json
  def index
    @auctions = Auction.joins(:profile).filter(params.slice(:by_country, :by_city, :by_gender, :by_age_from, :by_age_to)).active
  end

  # GET /auctions/1
  # GET /auctions/1.json
  def show
  end

  # GET /auctions/new
  def new
    if current_user.profile.auctions.active.present?
      redirect_to auctions_my_bids_path, notice: 'You already have active auction'
    end
    @auction = Auction.new
  end

  # GET /auctions/1/edit
  def edit
    redirect_to auctions_my_bids_path, notice: 'You can not edit auction with bids' if @auction.bids.any?
    @timezone = current_user.profile.timezone || 'UTC'
    # asctime convert DateTime to string without timezone info and recreate in utc for form
    @auction.auction_end = @auction.auction_end.in_time_zone(@timezone).asctime.to_datetime
  end

  def videodate
    if current_user.dating?
      redirect_to auctions_my_bids_path, notice: 'You already connected to this video date'
    end
    @conversation = Conversation.between(@auction.profile.user, @auction.winner.user).first
    @personal_message = PersonalMessage.new
  end

  def my_bids
    @auctions = current_user.profile.bid_auctions.active
    @winning_auctions = current_user.profile.winning_auctions.ended.videodate_not_ended
    @my_auctions = current_user.profile.auctions.videodate_not_ended
  end

  # POST /auctions
  # POST /auctions.json
  def create
    if current_user.profile.auctions.active.present?
      redirect_to auctions_my_bids_path, notice: 'You already have active auction'
    end
    @auction = current_user.profile.auctions.build(auction_params)
    @timezone = current_user.profile.timezone
    @auction.timezone = @timezone
    respond_to do |format|
      if @auction.save
        format.html { redirect_to @auction.profile, notice: 'Auction was successfully created.' }
        format.json { render :show, status: :created, location: @auction }
      else
        format.html { render :new }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auctions/1
  # PATCH/PUT /auctions/1.json
  def update
    @timezone = current_user.profile.timezone
    @auction.timezone = @timezone
    respond_to do |format|
      if @auction.update(auction_params)
        format.html { redirect_to @auction.profile, notice: 'Auction was successfully updated.' }
        format.json { render :show, status: :ok, location: @auction }
      else
        format.html { render :edit }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auctions/1
  # DELETE /auctions/1.json
  def destroy
    @auction.destroy
    respond_to do |format|
      format.html { redirect_to auctions_url, notice: 'Auction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end

    def check_access
      if current_user.profile != @auction.profile || current_user.profile != @auction.bids.max.profile || @auction.auction_end > DateTime.current
        redirect_to auctions_path, notice: 'Error! Something wrong.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auction_params
      params.require(:auction).permit(:aim, :rater_age_min, :rater_age_max, :rater_gender, :date_duration, :auction_end, :video_date_start, :bid_step, :start_bid, :video_preview, :charitable)
    end
end
