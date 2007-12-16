require 5.8.1;
use Module::Build;
my $build = Module::Build->new(
    module_name	=> 'HTML::GenToc',
    dist_version_from	=> 'scripts/hypertoc',
    requires		=> {
    		'HTML::LinkList' => 0.1501,
    		'HTML::SimpleParse' => 0.10,
		'Getopt::Long' => 2.34,
		'Getopt::ArgvFile' => 1.09,
		'Pod::Usage' => 0,
		'Data::Dumper' => 0,
    	},
    build_requires	=> {
		'Test::More' => 0,
    	},
    script_files	=> ['scripts/hypertoc'],
    dist_author		=> 'Kathryn Andersen',
    license		=> 'gpl',
);
$build->create_build_script;
# create the Makefile.PL always
use Module::Build::Compat;
print "creating Makefile.PL\n";
Module::Build::Compat->create_makefile_pl('passthrough', $build);
