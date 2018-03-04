class Ico::EtzInvestmentsController < ApplicationController

  layout "ico_account"
  before_action :authenticate_ico_user!
  before_action :set_ico_etz_investment, only: [:show, :edit, :update, :destroy]
  before_action :is_super_admin

  # GET /ico/etz_investments
  # GET /ico/etz_investments.json
  def index
    @ico_etz_investments = EtzInvestment.all
  end

  # GET /ico/etz_investments/1
  # GET /ico/etz_investments/1.json
  def show
  end

  # GET /ico/etz_investments/new
  def new
    @ico_etz_investment = EtzInvestment.new
  end

  # GET /ico/etz_investments/1/edit
  def edit
  end

  # POST /ico/etz_investments
  # POST /ico/etz_investments.json
  def create
    @ico_etz_investment = EtzInvestment.new(ico_etz_investment_params)

    respond_to do |format|
      if @ico_etz_investment.save
        format.html { redirect_to ico_etz_investment_path(@ico_etz_investment), notice: 'Etz investment was successfully created.' }
        format.json { render :show, status: :created, location: @ico_etz_investment }
      else
        format.html { render :new }
        format.json { render json: @ico_etz_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ico/etz_investments/1
  # PATCH/PUT /ico/etz_investments/1.json
  def update
    respond_to do |format|
      if @ico_etz_investment.update(ico_etz_investment_params)
        format.html { redirect_to ico_etz_investment_path(@ico_etz_investment), notice: 'Etz investment was successfully updated.' }
        format.json { render :show, status: :ok, location: @ico_etz_investment }
      else
        format.html { render :edit }
        format.json { render json: @ico_etz_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ico/etz_investments/1
  # DELETE /ico/etz_investments/1.json
  def destroy
    @ico_etz_investment.destroy
    respond_to do |format|
      format.html { redirect_to ico_etz_investments_url, notice: 'Etz investment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ico_etz_investment
      @ico_etz_investment = EtzInvestment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ico_etz_investment_params
      params.require(:etz_investment).permit(:wallet, :time, :etz, :rdt)
    end

    def is_super_admin
      redirect_to ico_account_path if !current_ico_user.superadmin?
    end
end
