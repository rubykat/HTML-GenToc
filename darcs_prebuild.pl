#!/usr/bin/env perl
use strict;
use Module::DevAid;

=head1 NAME

darcs_prebuild.pl - Script for darcs to call before building a dist dir

=head1 SYNOPSIS

perl darcs_prebuild.pl

=head1 DESCRIPTION

This is a script for darcs to call before building a dist dir or
before tests.  This should be customized for the particular user,
but the default version does a chmod +x on all the scripts, and
generates the auto-generated files which are supposed to be in the
MANIFEST (README and TODO)

Set this up to be called as follows:

darcs setpref predist "perl darcs_prebuild.pl"

darcs setpref test "perl darcs_prebuild.pl && perl Build.PL && Build && Build test"

=cut

print "darcs prebuild started\n";

my $mda = Module::DevAid->new();

# first, chmod the scripts
my $command = 'chmod +x ' . join(' ', @{$mda->{scripts}});
system($command);

# now generate the auto-generated docs
$mda->generate_todo_file();
$mda->generate_readme_file(0);

print "darcs prebuild ended\n";
