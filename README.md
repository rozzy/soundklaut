# Soundklaut

Soundklaut is a simple soundcloud click generator / song play bot

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
