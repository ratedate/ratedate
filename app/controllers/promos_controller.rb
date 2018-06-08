class PromosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_promo, only: [:show, :edit, :update, :destroy]
  before_action :is_super_admin, except: [:activate]

  # GET /promos
  # GET /promos.json
  def index
    if params[:promo_create_session]
      @promos = Promo.where('create_session=?', params[:promo_create_session])
    else
      @promos = Promo.all
    end
  end

  # GET /promos/1
  # GET /promos/1.json
  def show
  end

  # GET /promos/new
  def new
    @promo = Promo.new
  end

  # GET /promos/1/edit
  def edit
  end

  def bunch_create
    @create_session = SecureRandom.urlsafe_base64
    session[:promo_create_session] = @create_session
    @number = promo_params[:number]
    @value = promo_params[:value]
    @string = promo_params[:string].parameterize
    @user_id = current_user.id
    @count = 0
    while @count < @number
      promo = Promo.new(user_id: @user_id, value: @value, create_session: @create_session)
      promo.promocode = @string+'-'+SecureRandom.hex(2)
      if promo.save!
        @count += 1
      end
    end
  end

  def activate
    if params[:promocode]
      @promo = Promo.where('promocode=?',params[:promocode]).last
      if @promo
        if @promo.status == 'available' && @promo.promo_type == 'rdt'
          if current_user.balance.present?
            current_user.balance.add_amount(@promo.value)
          else
            current_user.create_balance()
            current_user.balance.add_amount(@promo.value)
          end
          @promo.update(status: 'used')
          redirect_to my_profile_path, notice: 'Promo code successfully used'
        else
          redirect_to my_profile_path, notice: 'Promo code are wrong or already used'
        end
      end
    end
  end

  # POST /promos
  # POST /promos.json
  def create
    @create_session = SecureRandom.urlsafe_base64
    @number = promo_params[:number]
    @value = promo_params[:value]
    @string = promo_params[:string].parameterize
    @user_id = current_user.id
    @count = 0
    while @count < @number.to_i
      promo = Promo.new(user_id: @user_id, value: @value, create_session: @create_session)
      promo.promocode = @string+'-'+SecureRandom.hex(2)
      if promo.save
        @count += 1
      end
    end
    redirect_to promos_url(promo_create_session: @create_session), notice: 'Promos was successfully created.'
  end

  # PATCH/PUT /promos/1
  # PATCH/PUT /promos/1.json
  def update
    respond_to do |format|
      if @promo.update(promo_params)
        format.html { redirect_to @promo, notice: 'Promo was successfully updated.' }
        format.json { render :show, status: :ok, location: @promo }
      else
        format.html { render :edit }
        format.json { render json: @promo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promos/1
  # DELETE /promos/1.json
  def destroy
    @promo.destroy
    respond_to do |format|
      format.html { redirect_to promos_url, notice: 'Promo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promo
      @promo = Promo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promo_params
      params.require(:promo).permit(:value, :string, :number)
    end

    def is_super_admin
      redirect_to my_profile_path if !current_user.superadmin?
    end
end
