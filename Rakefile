ROOT = File.expand_path('../', __FILE__)

CONFIG_RU = "#{ROOT}/config.ru"
CONFIG = YAML.load_file("#{ROOT}/config/pianoweb.yml")

namespace :pianoweb do

  desc 'Starts application'
  task :start do
    if File.exists? "/tmp/pianoweb_#{CONFIG['port']}.pid"
      puts "Already running..."
    else
      puts "Starting at localhost:#{CONFIG['port']}"
      `rackup --server thin --port #{CONFIG['port']} --pid /tmp/pianoweb_#{CONFIG['port']}.pid --daemonize #{CONFIG_RU}`
    end
  end

  desc 'Stops application'
  task :stop do
    if File.exists? "/tmp/pianoweb_#{CONFIG['port']}.pid"
      puts "Stopping Pianoweb"
      pid = File.read("/tmp/pianoweb_#{CONFIG['port']}.pid").to_i
      system "kill -9 #{pid}"
      File.delete "/tmp/pianoweb_#{CONFIG['port']}.pid"
    else
      puts "Pianoweb not running"
    end
  end


  desc 'Restarts application'
  task :restart do
    Rake::Task['pianoweb:stop'].invoke
    Rake::Task['pianoweb:start'].invoke
  end
end

namespace :pianobar do

  desc "Gets TLS fingerprint from pandora.com"
  def tls_fingerprint
    require 'net/http'
    https = Net::HTTP.new('tuner.pandora.com', 443)
    https.use_ssl = true
    https.start
    Digest::SHA1.hexdigest(https.peer_cert.to_der).upcase
  end

  task :tls_fingerprint do
    puts tls_fingerprint
  end

  task :setup do
    if File.exists?("#{ENV['HOME']}/.config/pianobar/config")
      puts "Pianobar config exists. Update tls fingerprint? [y/N]"
      if STDIN.getc.downcase == 'y'
        fingerprint = tls_fingerprint
        puts fingerprint
      end
    end
  end
end


