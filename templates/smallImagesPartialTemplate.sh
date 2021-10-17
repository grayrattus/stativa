#/bin/sh
NOT_USED_IMAGES="$SUB_IMAGES_IDS"

cat << EOF >> $SUB_OUTPUT_INDEX
	<style>
	  [data-title]::before {
	    content: attr(data-title) " ";
	    font-size: 2em;
	    text-align: center;
	    display: block;
	    margin: 1em;
	  }
	  [data-description]::after {
	    content: attr(data-description) " ";
	    margin: 0.5em;
	    display: block;
	  }
	  .small-images-partial-template {
	    display: flex;
	    justify-content: center;
	    flex-direction: column;
	    align-items: center;
	  }
	</style>
EOF

i=0;
rows=0;
for IMAGE_ID in $SUB_IMAGES_IDS; do
  NOT_USED_IMAGES=$(echo $NOT_USED_IMAGES | sed -E "s/$IMAGE_ID\s?//g");
  [ $i -eq 0 ] && echo '<div class="grid">' >> $SUB_OUTPUT_INDEX
  cat << EOF >> $SUB_OUTPUT_INDEX
      <div class="small-images-partial-template"><img id="$IMAGE_ID" style="max-height: 100vh;"/></div>
EOF
  if [ "$i" -eq "1" ]; then 
    echo '</div>' >> $SUB_OUTPUT_INDEX 
    i=0
    rows=$(( $rows + 1)) 
    if [ "$rows" -eq "2" ]; then 
      break
    fi
  else 
    i=$(( $i + 1)) 
  fi
done
[ $i -le 0 ] && echo '</div>' >> $SUB_OUTPUT_INDEX

echo $NOT_USED_IMAGES

