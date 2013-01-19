require 'bundler'
Bundler.require

configure do
  config = YAML.load_file "#{Sinatra::Application.root}/config/pianoweb.yml"
  set environment: config['environment']
end

set environment: :production

class Pianoweb < Sinatra::Base

  require_relative 'assets'

  COMMANDS = {
      play: 'p',
      next: 'n'
  }

  use Assets

  post %r{/player/(play|next)} do |c|
    cmd = COMMANDS[c.to_sym]
    %x[echo -n '#{cmd}' > ~/.config/pianobar/ctl]
  end



  get '/' do
    erb :index
  end

end