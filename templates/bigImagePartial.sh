#/bin/sh
NOT_USED_IMAGES="$SUB_IMAGES_IDS"

cat << EOF >> $SUB_OUTPUT_INDEX
	<style>
	  .big-image-partial[data-title]::before {
	    content: attr(data-title) " ";
	    font-size: 2em;
	    text-align: center;
	    display: block;
	    margin: 1em;
	    position: absolute;
	    top: 0;
	    width: 80vw;
	    background-color: rgba(255,255,255,0.4);
	  }
	  .big-image-partial[data-description]::after {
	    content: attr(data-description) " ";
	    margin: 0.5em;
	    display: block;
	    width: 80vw;
	  }
	  .big-image-partial {
	    display: flex;
	    justify-content: center;
	    flex-direction: column;
	    align-items: center;
	    position: relative;
	  }
	  .big-image-partial img {
	    width: 80vw;
	  }
	</style>
EOF

for IMAGE_ID in $SUB_IMAGES_IDS; do
  NOT_USED_IMAGES=$(echo $NOT_USED_IMAGES | sed -E "s/$IMAGE_ID\s?//");
  cat << EOF >> $SUB_OUTPUT_INDEX
<div>
      <div class="grid big-image-partial"><img id="$IMAGE_ID" /></div>
</div>
EOF
  break
done

echo $NOT_USED_IMAGES

