#!/usr/bin/perl

use lib '.'; use lib 't';
use SATest; sa_t_init("spamd_maxchildren");
use Test; BEGIN { plan tests => 22 };

# ---------------------------------------------------------------------------

%patterns = (

q{ X-Spam-Status: Yes, hits=}, 'status',
q{ X-Spam-Flag: YES}, 'flag',
q{ X-Spam-Level: **********}, 'stars',
q{ FROM_ENDS_IN_NUMS}, 'endsinnums',
q{ NO_REAL_NAME}, 'noreal',


);

start_spamd("-L -m1");
ok ($spamd_pid > 1);
ok (spamcrun ("< data/spam/001", \&patterns_run_cb));
ok_all_patterns();
ok (spamcrun_background ("< data/spam/006", {}));
ok (spamcrun_background ("< data/spam/006", {}));
ok (spamcrun_background ("< data/spam/001", {}));
ok (spamcrun_background ("< data/spam/002", {}));
ok (spamcrun_background ("< data/spam/003", {}));
ok (spamcrun_background ("< data/spam/004", {}));
ok (spamcrun_background ("< data/spam/005", {}));
ok (spamcrun_background ("< data/spam/006", {}));
clear_pattern_counters();
ok (spamcrun ("< data/spam/001", \&patterns_run_cb));
ok_all_patterns();
ok (stop_spamd());


