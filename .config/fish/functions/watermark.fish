# http://simonkatanski.blogspot.si/2017/08/adding-tiled-watermark-text-to-documents.html

function watermark --description "watermark <text> <file>"

	if test (count $argv) -ne 2
		echo "Usage: watermark <text> <file>"
		return 1
	end

	set -l filepath  (string match -r '(.*)(\..*?)$' "$argv[2]")
	set -l rootname  "$filepath[2]"
	set -l extension "$filepath[3]"

	magick convert \
		-font Helvetica \
		-pointsize 30 \
		-size 430x270 xc:none \
		-fill '#80808080' \
		-gravity NorthWest \
		-draw "rotate 15 text 5,0 '$argv[1]'" miff:- | composite \
		-tile - "$argv[2]" "$rootname"_watermark"$extension"
end
