# Configure Rhoconnect-rb plugin
#
Rhoconnectrb.configure do |config|
  # `token` is the rhoconnect token for your rhoconnect instance.
  # You can find the value for this token in your rhoconnect web console.
  # config.token = "my-rhoconnect-token"
  config.token = "my-rhoconnect-token"

  # `uri` defines the location of your rhoconnect instance.
  config.uri   = "http://localhost:9292"
  # config.uri   = "http://sometokenforme@localhost:9292"
  #config.uri           = "http://sometokenforme@rhoconnect-resource.heroku.com"

  # `app_endpoint` is the url of this rails app.  It is used to notify the
  # rhoconnect instance where this rails app is located on startup.
  # If you do not define `app_endpoint`, you will have to set this variable
  # manually using the rhoconnect web console.
  config.app_endpoint = "http://localhost:3000"
  #config.app_endpoint  = "http://rho-fat-free.heroku.com"

  # Use `authenticate` to define your authentication logic.
  # credentials are passed in as a hash:
  # {
  #   :login => 'someusername',
  #   :password => 'somepassword'
  # }
  config.authenticate = lambda { |credentials|
    user = User.find_by_username(credentials['login'])
    if user && user.valid_password?(credentials['password'])
      Rails.logger.info "Rhoconnect#authenticate: User #{credentials['login']} is successfully authenticated"
      return credentials['login']
    end

    Rails.logger.error "Rhoconnect#authenticate: Invalid user credentials: #{credentials['login']}/#{credentials['password']}"
    return false
  }

end
