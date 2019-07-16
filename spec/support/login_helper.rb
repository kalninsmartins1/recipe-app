module LoginHelper
  def login(email, password)
    post login_path, params: {session: {email: email, password: password}}
  end
end
