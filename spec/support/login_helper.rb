module LoginHelper
  def login(email, password)
    post login_path, params: {session: {email: email, password: password}}
  end

  def silent_login(chef_id)
    session[:chef_id] = chef_id
  end
end
