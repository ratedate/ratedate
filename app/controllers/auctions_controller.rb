class AuctionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_auction, only: [:show, :edit, :update, :destroy, :videodate]
  # before_action :check_access, only: :videodate

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
    @auction = Auction.new
  end

  # GET /auctions/1/edit
  def edit
  end

  def videodate

  end

  def my_bids
    @auctions = current_user.profile.bid_auctions.active
    @winning_auctions = current_user.profile.winning_auctions
  end

  # POST /auctions
  # POST /auctions.json
  def create
    @auction = Auction.new(auction_params)

    respond_to do |format|
      if @auction.save
        format.html { redirect_to @auction, notice: 'Auction was successfully created.' }
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
    respond_to do |format|
      if @auction.update(auction_params)
        format.html { redirect_to @auction, notice: 'Auction was successfully updated.' }
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
      if current_user.profile != @auction.profile || current_user.profile != @auction.bids.max.profile || @auction.auction_end > DateTime.now
        redirect_to auctions_path, notice: 'Error! Something wrong.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auction_params
      params.require(:auction).permit(:aim, :rater_age_min, :rater_age_max, :rater_gender, :date_duration, :auction_end, :video_date_start, :bid_step, :start_bid, :video_preview)
    end
end
