use Test::More tests => 5;
use HTML::GenToc;

# Insert your test code below
#===================================================

$toc = new HTML::GenToc(debug=>0,
	quiet=>1);

#----------------------------------------------------------
# string input and output
$html1 ="<h1>Cool header</h1>
<p>This is a paragraph.</p>
<h2>Getting Cooler</h2>
<p>Another paragraph.</p>
";

$html2 ="<h1><a name=\"Cool\">Cool header</a></h1>
<p>This is a paragraph.</p>
<h2><a name=\"Getting\">Getting Cooler</a></h2>
<p>Another paragraph.</p>
";

$out_str = $toc->generate_toc(
    make_anchors=>1,
    make_toc=>0,
    outfile=>'',
    to_string=>1,
    filenames=>["fred.html"],
    input=>$html1,
    toc_entry=>{
	'H1' =>1,
	'H2' =>2,
    },
    toc_end=>{
	'H1' =>'/H1',
	'H2' =>'/H2',
    },
);

is($out_str, $html2, "(1) generate_anchors matches strings");

$out_str = $toc->generate_toc(
    make_anchors=>0,
    make_toc=>1,
    outfile=>'',
    to_string=>1,
    filenames=>["fred.html"],
    input=>$html2,
);

$ok_toc_str1='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML//EN">
<html>
<head>
<title>Table of Contents</title>
</head>
<body>
<h1>Table of Contents</h1>
<ul><li><a href="fred.html#Cool">Cool header</a>
<ul><li><a href="fred.html#Getting">Getting Cooler</a></li>
</ul></li>
</ul>
</body>
</html>
';

is($out_str, $ok_toc_str1, "(2) generate_toc matches toc string");

$out_str = $toc->generate_toc(
    make_anchors=>0,
    make_toc=>1,
    outfile=>'',
    to_string=>1,
    filenames=>["fred.html"],
    input=>$html2,
    inline=>1,
    toc_tag=>'/H1',
    toc_tag_replace=>0,
    toclabel=>'',
);

$ok_toc_str2='<h1><a name="Cool">Cool header</a></h1>
<ul><li><a href="#Cool">Cool header</a>
<ul><li><a href="#Getting">Getting Cooler</a></li>
</ul></li>
</ul>

<p>This is a paragraph.</p>
<h2><a name="Getting">Getting Cooler</a></h2>
<p>Another paragraph.</p>
';

is($out_str, $ok_toc_str2, "(3) generate_toc matches inline toc string");

#
# Reset
undef $toc;
$toc = new HTML::GenToc(debug=>0,
	quiet=>1);

$html1 ="<h1>Cool header</h1>
<p>This is a paragraph.</p>
<h2>Getting Cooler</h2>
<p>Another paragraph.</p>
";

$html2 ="<h1 id='Cool'>Cool header</h1>
<p>This is a paragraph.</p>
<h2 id='Getting'>Getting Cooler</h2>
<p>Another paragraph.</p>
";

$out_str = $toc->generate_toc(
    make_anchors=>1,
    make_toc=>0,
    outfile=>'',
    to_string=>1,
    use_id=>1,
    filenames=>["fred.html"],
    input=>$html1,
    toc_entry=>{
	'H1' =>1,
	'H2' =>2,
    },
    toc_end=>{
	'H1' =>'/H1',
	'H2' =>'/H2',
    },
);

is($out_str, $html2, "(4) generate_anchors (id) matches strings");

$out_str = $toc->generate_toc(
    make_anchors=>0,
    make_toc=>1,
    outfile=>'',
    to_string=>1,
    filenames=>["fred.html"],
    input=>$html2,
);

$ok_toc_str1='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML//EN">
<html>
<head>
<title>Table of Contents</title>
</head>
<body>
<h1>Table of Contents</h1>
<ul><li><a href="fred.html#Cool">Cool header</a>
<ul><li><a href="fred.html#Getting">Getting Cooler</a></li>
</ul></li>
</ul>
</body>
</html>
';

is($out_str, $ok_toc_str1, "(5) generate_toc (id) matches toc string");

