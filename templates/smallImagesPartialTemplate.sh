USED_IMAGES=""
for IMAGE_ID in "$SUB_IMAGES_IDS"; do
  USED_IMAGES="$USED_IMAGES $IMAGE_ID"
  cat << EOF >> $OUTPUT_INDEX
    <article>
      <img id="$IMAGE_ID" width="300" height="300" />
    </article>
EOF
done

echo $(echo $IMAGES_IDS | grep -v $USED_IMAGES)

