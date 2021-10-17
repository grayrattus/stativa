#/bin/sh
USED_IMAGES=""

cat << EOF >> $SUB_OUTPUT_INDEX
	<style>
	  [data-title]::before {
	    content: attr(data-title) " ";
	    font-size: 2em;
	    text-align: center;
	    display: block;
	  }
	  [data-description]::after {
	    content: attr(data-description) " ";
	  }
	</style>
EOF

i=0;
for IMAGE_ID in $SUB_IMAGES_IDS; do
  USED_IMAGES="$USED_IMAGES $IMAGE_ID"
  [ $i -eq 0 ] && echo '<div class="grid small-images-partial-template">' >> $SUB_OUTPUT_INDEX
  cat << EOF >> $SUB_OUTPUT_INDEX
      <div><img id="$IMAGE_ID" style="width: 100%;"/></div>
EOF
if [ "$i" -eq "2" ]; then 
  echo '</div>' >> $SUB_OUTPUT_INDEX 
  i=0
else 
  i=$(( $i + 1)) 
fi
done
[ $i -le 0 ] && echo '</div>' >> $SUB_OUTPUT_INDEX

echo "$(echo "$IMAGES_IDS" | sed "s/${USED_IMAGES}//g")"
