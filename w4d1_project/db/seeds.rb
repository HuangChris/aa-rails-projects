users = User.create!([
  { username: 'charlie123' },
  { username: 'coolguy123'}
])

contacts = Contact.create!([
  { name: "Charles", email: 'charles@gmail.com', user_id: 1, favorited: true},
  { name: "Charles' friend", email: 'not_charles@gmail.com', user_id: 1},
  { name: "Bob", email: 'coolguy123@gmail.com', user_id: 2 },
  { name: "Eric", email: "erik@gmail.com", user_id: 2}

  ])

contact_shares = ContactShare.create!([
  { user_id: 2, contact_id: 1},
  { user_id: 1, contact_id: 4, favorited: true}
  ])
