#!./perl

# test that "use vars;" doesn't load Carp

BEGIN {
    chdir 't' if -d 't';
    @INC = '../lib';
    $ENV{SPECPERLLIB} = '../lib';
}

$| = 1;

print "1..1\n";

# Carp not loaded yet;
print defined $Carp::VERSION ? "not ok 1\n" : "ok 1\n";