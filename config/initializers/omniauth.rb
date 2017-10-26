OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID_DEV'], ENV['GOOGLE_CLIENT_SECRET_DEV'], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
