class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.filter(params.slice(:by_country, :by_city, :by_gender, :by_age_from, :by_age_to))
    console
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    console
    if current_user.profile.present?
      redirect_to my_profile_path
    end
    @profile = Profile.new
    6.times {@profile.photos.build}
  end

  # GET /profiles/1/edit
  def edit
    if @profile.photos.any?
      (6-@profile.photos.count).times {@profile.photos.build}
    else
      6.times {@profile.photos.build}
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = current_user.build_profile(profile_params)

    respond_to do |format|
      if @profile.save
        if params['profile']['crop_x']
          @profile.avatar.recreate_versions!
        end
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        if params['profile']['crop_x']
          @profile.avatar.recreate_versions!
        end
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = params[:id] ? Profile.find(params[:id]) : current_user.profile
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name, :surname, :hide_surname, :nickname, :avatar, {:languages => []}, :dob, :hide_dob, :gender, :about, :crop_x, :crop_y, :crop_w, :crop_h, :hobby_list, :music_list, :film_list, :book_list, :country, :country_code, :city_name, :administrative_area_level_1, :administrative_area_level_2, photos_attributes:[:id,:photo,:remove_photo])
    end
end
