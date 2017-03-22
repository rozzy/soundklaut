# Soundklaut
(original author - https://github.com/JanOwiesniak/soundklaut)

Soundklaut is a soundcloud click generator / song play bot.

## How it works

*This should be seen as a simple proof of concept*

It boots up a phantomjs via capybara (poltergeist driver),
visit the profile page and clicks twice on each play button.
Once to start a song and once, with a little delay, to stop it.

## Dependencies

phantomjs

## Usage

Define soundcloud username under bin/run, then execute

```bash
./bin/run
```

## History

### Generate one click

It looks like the button is clicked but the play is still not visible in the soundcloud stats. This could have several reasons.

* Soundcloud is realizing the bot through the User-Agent and blocking it
* There is some client side validation (javascript) which is not fullfilled

### Generate more than one click

My first guess is that clicks are counted as uniq by ip.
One solution could be to click through public proxies.
