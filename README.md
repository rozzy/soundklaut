# Soundklaut

Soundklaut is a soundcloud click generator / song play bot.

## How it works

*This should be seen as a simple proof of concept*

It boots up a phantomjs via capybara (poltergeist driver),
visit the profile page and click twice on each play button.
Once to start a song and once, with a little delay, to stop it.

## Dependencies

phantomjs

## Usage

Define soundcloud username under bin/run, then execute

```bash
./bin/run
```

## TODO

### Click play button for each song

Load jQuery dynamically into dom to click each play button.
At the moment this is not working because the callback function which is registered on script#onload is never fired

Give it another try or solve it with vanilla javascript.

### Generate more than one click

My first guess is that clicks are counted as uniq by ip.
One solution could be to click through public proxies.
