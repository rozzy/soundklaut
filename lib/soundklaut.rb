require "soundklaut/version"
require 'mechanize'

module Soundklaut
  class Client
    def initialize(profile_url)
      @profile_url = profile_url 
    end

    def run
      write listen
    end

    private

    attr_reader :profile_url

    def listen
      require 'capybara'
      require 'capybara/poltergeist'
      session = Capybara::Session.new(:poltergeist)

      session.visit profile_url
      session.execute_script play_each_track
    end

    def play_each_track
'(function () {
    function loadScript(url, callback) {
        var script = document.createElement("script")
        script.type = "text/javascript";
        script.onload = function () {
          callback();
        };
        script.src = url;
        document.getElementsByTagName("head")[0].appendChild(script);
        console.log("add jquery to dom");
    }
    loadScript("https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js", function () {
      console.log("jquery loaded");
      $.each($(".sc-button-play"), function( index, value ) {setTimeout(function(){ value.click(); setTimeout(function(){ value.click(); }, 2000); }, 4000);});
    });
})();'
    end

    def write(msg)
      stdout.print msg
    end

    def stdout
      $stdout
    end
  end
end
