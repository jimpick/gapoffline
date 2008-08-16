#! /bin/sh

# http://blog.clawpaws.net/post/2007/07/16/Storing-iPhone-apps-locally-with-data-URLs

perl -0777 -e 'use MIME::Base64; $text = <>; $text = encode_base64($text); $text =~ s/\s+//g; print "data:text/html;charset=utf-8;base64,$text\n";'

