# Used to convert chktexrc.in (which see) into chktexrc and ChkTeXRC.tex

use strict;
use warnings;

my $chktexrc_output;
if ( $ARGV[0] eq '--chktexrc' ) {
    $chktexrc_output = 1;
} elsif ( $ARGV[0] eq '--latex' ) {
    $chktexrc_output = 0;
} else {
    exit 1;
}


# Filter the lines of the file
open(my $fh, '<:encoding(UTF-8)', $ARGV[1])
    or die "Could not open file '$ARGV[1]' $!";

while ( <$fh> ) {

    if ($chktexrc_output) {
        # chktexrc output, so discard all lines over
        print unless /^#{3,}/;

    } else {

        # LaTeX output, so discard lines except with 1,3
        next if /^#{4,}/;
        next if /^#{2} /;
        next unless /^#/;
        s/^#+\s*//;
        print;
    }
}
