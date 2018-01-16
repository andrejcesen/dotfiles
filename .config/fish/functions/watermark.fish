# http://simonkatanski.blogspot.si/2017/08/adding-tiled-watermark-text-to-documents.html

function watermark --description "watermark <text> <file>"

	if test (count $argv) -ne 2
		echo "Usage: watermark <text> <file>"
		return 1
	end

	magick convert \
		-font Arial \
		-pointsize 50 \
		-size 430x270 xc:none \
		-fill '#80808080' \
		-gravity NorthWest \
		-draw "rotate 15 text 5,0 '$argv[1]'" miff:- | composite \
		-tile - "$argv[2]" watermark_"$argv[2]"
end