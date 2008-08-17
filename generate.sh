#! /bin/sh

subst() {
	perl -e '
	$from = shift;
	$to = shift; 
	while (<>) {
		s/$from/$to/g;
		print;
	}' $1 $2
}

make_dataurl() {
	./make-dataurl.sh
}

# Flick Demo
flick_icon_data=`cat "phonegap-flick-icon.png" | make_dataurl` 
flick_nav_data=`cat "phonegap-flick.html" |
	subst "http://i.mydailyphoto.com/icon.png" $flick_icon_data |
	make_dataurl`

# Stylesheets / Javascript
ball_icon_png_data=`cat "phonegap-ballIcon.png" | make_dataurl`
#styles_css_data=`cat "phonegap-styles.css" |
#	subst "ballIcon.png" $ball_icon_png_data |
#	make_dataurl` 
styles_css_data=`cat "phonegap-styles.css" |
	make_dataurl` 
gap_js_data=`cat phonegap-gap.js | make_dataurl` 

# Bounce Demo
mootools_data=`cat "phonegap-mootools12b.js" | make_dataurl` 
bounce_html_data=`cat "phonegap-bounce.html" |
	subst "styles.css" $styles_css_data |
	subst "gap.js" $gap_js_data |
	subst "mootools12b.js" $mootools_data |
	make_dataurl` 

# Main index page
# Note: A little inefficent as stylesheet and image are encoded twice
# once for bounce and once for the main page
#index_html_data=`cat phonegap-index.html |
#	subst "styles.css" $styles_css_data |
#	subst "gap.js" $gap_js_data |
#	subst "bounce.html" $bounce_html_data |
#	subst "http://i.mydailyphoto.com/flick_navigation.php" $flick_nav_data |
#	make_dataurl`
index_html_data=`cat phonegap-index.html |
	grep -v 'Gravity' |
	grep -v 'Get Photo' |
	subst "styles.css" $styles_css_data |
	subst "gap.js" $gap_js_data |
	subst "http://i.mydailyphoto.com/flick_navigation.php" $flick_nav_data |
	make_dataurl`
echo $index_html_data > url.txt

#curl http://phonegap.com/demo/bounce.html > phonegap-bounce.html
#curl http://phonegap.com/demo/mootools12b.js > phonegap-mootools12b.js
