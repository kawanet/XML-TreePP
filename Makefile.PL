use ExtUtils::MakeMaker;

my $opt = {
    NAME                =>  'XML::TreePP',
    VERSION_FROM        =>  'lib/XML/TreePP.pm',
    PREREQ_PM           =>  {
        'Test::More'        =>  '0',
#       'LWP::UserAgent'    =>  '0',
#       'HTTP::Lite'        =>  '0',
#       'Jcode'             =>  '0', # on Perl 5.005/5.6.x
    },
};

my $mm = $ExtUtils::MakeMaker::VERSION;
$mm =~ s/[^\d\.]+//g;
$opt->{LICENSE} = 'perl' if ( $mm >= 6.3001 );

WriteMakefile( %$opt );
