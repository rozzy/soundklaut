require "soundklaut/version"
require 'capybara'
require 'capybara/poltergeist'

module Soundklaut
  module IO
    def write(msg)
      stdout.print msg
    end

    def stdout
      $stdout
    end
  end

  class Client
    def initialize(profile_url)
      @profile_url = profile_url
      @session = build_session
    end

    def run
      listen
    end

    private

    attr_reader :profile_url, :session

    def build_session
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, :js_errors => false)
      end
      Capybara::Session.new(:poltergeist)
    end

    def listen
      visit_profile_page
      listen_to_recent_tracks
    end

    def visit_profile_page
      session.visit profile_url
    end

    def listen_to_recent_tracks
      recent_tracks(session).each do |track|
        track.start
        random_sleep
        track.stop
      end
      sleep 60
      listen_to_recent_tracks
    end

    def recent_tracks(session)
      5.times do
        @session.execute_script 'window.scroll(0, 10000); console.log("scrolled to", window.pageYOffset)'
        sleep 3
      end
      recent_tracks_selector.map { |t| build_track(t) }
    end

    def recent_tracks_selector
      session.find(:css, '.userMain__content').all(:css, '.soundList__item')
    end

    def build_track(track)
      Track.new(track)
    end

    def random_sleep
      sleep random
    end

    def random
      Random.rand(5)
    end

    class Track
      include IO

      def initialize(track)
        @username = track.find(:css, '.soundTitle__username span').text
        @title = track.find(:css, '.soundTitle__title span').text
        @play = track.find(:css, '.soundTitle__playButton button')
      end

      def start
        @play.click
        @started_at = time
        write "Listening to #{self}\n"
      end

      def stop
        @play.click
        @stopped_at = time
        write "Listenend #{listened} to #{self}\n"
      end

      private

      def to_s
        "#{@username} - #{@title}"
      end

      def listened
        distance_of_time_in_words(@stopped_at - @started_at)
      end

      def distance_of_time_in_words(time)
        "#{time.round(2)} seconds"
      end

      def time
        Time.now
      end
    end
  end
end
