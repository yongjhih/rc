#!/usr/bin/perl -w

my (%pattern) = (
    layout => '<div\s+class\s*=\s*"layout">',
    presentation => '<div\s+class\s*=\s*"presentation">',
);

my ($title);

while (<>) {
    if (/$pattern{layout}/) {
	last;
    } else {
	s#"\.\./_s5/inc.php"#"../i/jq/presentation/inc.php"#;
	s#<body\s+class\s*=\s*"content"#<body#;
	print;
	s/<!--.*-->//;
	$title = $1 if m#<title>(.*)</title>#;
    }
}
$title = "" unless $title;

die "cannot find 'layout' division\n"
    unless /$pattern{layout}/;

while (<>) {
    # skip the s5-specific div's
    last if /$pattern{presentation}/;
}

die "cannot find 'presentation' division\n"
    unless /$pattern{presentation}/;

    print <<eof;

  <div id="header">
    <h1>$title</h1>
  </div>

  <div id="footer">
    <p>請搜尋 「$title」</p>
  </div>

eof

print qq(  <div id="slides">\n);

while (<>) {
    s#<div\s+class\s*=\s*"slide default_effect#<div class="slide#;
    s#<h1>(.*)</h1>#<h2 class="slide-title">$1</h2>#;
    print;
}


