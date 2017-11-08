json.extract! profile, :id, :name, :surname, :hide_surname, :nickname, :avatar, :dob, :hide_dob, :gender, :about, :created_at, :updated_at
json.url profile_url(profile, format: :json)
