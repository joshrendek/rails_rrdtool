# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rrdtool_session',
  :secret      => 'dc47faa603c4a7725675155e99c6699b393cada30300a3e7b67885a8f65c3d9a18ff2113d8e5f37bbcad26414b7d6acc66815ec4863935f3ca726e1ba8f00340'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
