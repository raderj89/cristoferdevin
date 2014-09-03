set :stage, :production

role :app, %w{example.com}
role :web, %w{example.com}
role :db,  %w{example.com}

server 'example.com',
  user: 'your_username',
  roles: %w{web app},
  ssh_options: {
      user: 'your_username', # overrides user setting above
      keys: %w(/home/your_app_directory/.ssh/id_rsa),
      forward_agent: false,
      auth_methods: %w(password),
      password: 'your_password'
  }
