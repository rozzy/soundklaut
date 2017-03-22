$LOAD_PATH << 'lib'

require 'soundklaut'

class Main
  def self.run
    new.send(:run)
  end

  private

  def run
    client.run
  end

  def client
    Soundklaut::Client.new(profile_url)
  end

  def profile_url
    "https://soundcloud.com/#{profile}/tracks"
  end

  def profile
    return ARGV[0] if ARGV[0]
    error 'Missing soundcloud username'
  end

  def error(msg)
    $stderr.write msg
    $stderr.write "\n"
    exit -1
  end
end

Main.run
