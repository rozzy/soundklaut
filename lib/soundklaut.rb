require "soundklaut/version"
require 'capybara'
require 'capybara/poltergeist'

module Soundklaut
  class Client
    def initialize(profile_url)
      @profile_url = profile_url 
      @session = Capybara::Session.new(:poltergeist)
    end

    def run
      listen
    end

    private

    attr_reader :profile_url, :session

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
    end

    def recent_tracks(session)
      recent_tracks_selector.map { |t| build_track(t) }
    end

    def recent_tracks_selector
      session.find(:css, '.userStream__list').all(:css, '.soundList__item')
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

      def write(msg)
        stdout.print msg
      end

      def stdout
        $stdout
      end

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
