class Api::V1::UsersController < Api::V1::BaseController
  def create
    puts "...."
    encoded_sig, payload = get_params[:signed_request].split(".")
    sig = encoded_sig.tr('-_','+/').unpack('m')[0]
    expected_sig = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), ENV['APP_SECRET'], payload)
    puts "All ok re signature"
    # Renders a JSON with the URL to be redirected to in the pages/redirect view Javascript
    url = Rails.application.routes.url_helpers.redirect_url(tid: get_params[:tid], thread_type: get_params[:thread_type])
    puts url
    render json: {url: url}, status: :created
  end

  # SUPPORTER PRIVATE METHODS
  private

  def choosing_non_bot_redirect(user, group)
    if group
      if group.closed
        puts "5. The group exists, but has been closed. Need to rerun creata kitty."
        url = create_kitty_url(user, group)
      elsif group.kitty_created
        url = first_sign_in_url(user, group)
      else
        puts "5. The group exists, but they have not created a kitty yet."
        url = create_kitty_url(group)
      end
    else
      puts "5. This is a new group. Creating Group..."
      group = Group.create(tid: get_params[:tid], name: "Your Kitty", thread_type: get_params[:thread_type])
      url = create_kitty_url(user, group)
    end
    return url
  end

  def first_sign_in_url(user, group)
    if user.first_sign_in
      puts "5. This is the user's first sign in. Group Already Exists"
      # user.first_sign_in = false
      # user.save
      # url = Rails.application.routes.url_helpers.info_url(user_id: user.id, group_id: group.id)
      url = Rails.application.routes.url_helpers.group_url(group, user_id: user.id, group_id: group.id)
      return url
    else
      puts "5. This is not the user's first sign in. Group Already Exists"
      url = Rails.application.routes.url_helpers.group_url(group, user_id: user.id, group_id: group.id)
      return url
    end
  end

  def create_kitty_url(group)
    url = Rails.application.routes.url_helpers.new_group_url(group, group_id: group.id)
  end

  def get_params
    params.require(:user).permit(:psid, :tid, :thread_type, :signed_request)
  end

  def get_user_id
    params.require(:signed_in_id).permit(:user_id)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
  end
end
