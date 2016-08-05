# Stuck-Call Generator

## Background

On Adhearsion 2.6.1, it is possible to 

## Software

* Adhearsion 2.6.1
* Asterisk 1.8
* JRuby 1.7.24
* stuck-call-scenario/adhearsion (This simple ahn application)
   * Nothing novel in this app, other than a `Cache::Stats` module that periodically reports how many calls Adhearsion considers to be active.

## Invocation

### 1. Checkout and Setup

    git clone https://github.com/sfgeorge/stuck-call-scenario.git
    cd stuck-call-scenario/adhearsion
    bundle install

### 2. Start Adhearsion

    export AHN_PUNCHBLOCK_USERNAME=**<Asterisk-AMI-Username>**
    export AHN_PUNCHBLOCK_PASSWORD=**<Asterisk-AMI-Password>**
    export AHN_PUNCHBLOCK_HOST=**<Asterisk-hostname>**
    export JRUBY_OPTS='--server --headless -J-XX:+PrintCommandLineFlags -Xcompile.invokedynamic=false'
    export AHN_PLATFORM_LOGGING_LEVEL=trace

    screen -A -m -d \
      -S stuck-call-scenario \
      bundle exec ahn start . &

### 3. Send 1 call into Adhearsion

    ../sipp/stuck-call-generator.sh
    tail -f log/adhearsion.log

## Reproducible Results

If the above test was 'successful' in reproducing failure, then you will see that adhearsion.log reports > 0 calls, even when `asterisk -rx 'core show channels count'` reports no calls.

If you have _not_ produced any stuck calls, then you may need to be a bit more aggressive:

### Running more calls

  TOTAL_CALLS=30 ../sipp/stuck-call-generator.sh

### Using more diverse timing for quick-hangups

You may need to modify the amount of time before we perform a quick-hangup.  You can do so by editing `../sipp/stuck-call-generator.xml` and changing this line:

    <pause distribution="uniform" min="1" max="10" />

...the units are in milliseconds.  Consider changing "10" to something larger like "100".

After you save, you can re-run for a more diverse distribution of "quick" hang-ups, between 1 to 100 milliseconds:

    TOTAL_CALLS=100 ../sipp/stuck-call-generator.sh
