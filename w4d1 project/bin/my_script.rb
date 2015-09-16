require 'addressable/uri'
require 'rest-client'

def get_users
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.html',
  ).to_s

  puts RestClient.get(url)
end

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.post(
    url,
    { user: { name: "Gizmo", email: "gizmo@gizmo.gizmo" } }
  )
end

def user_contacts
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1/contacts.json'
  ).to_s

  puts RestClient.get(url)
end

def create_comment
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/1/comments.json'
  ).to_s

  puts RestClient.post(
    url,
    { comment: { body: "Testing comment on contact"} }
  )
end

# create_user
# get_users
# user_contacts
create_comment
