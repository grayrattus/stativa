#/bin/sh

if [ -n "$SUB_ENCRYPTED" ]; then
  cat <<EOF >> $SUB_OUTPUT_INDEX
  <script type="module">
  const password = prompt("To view gallery type password");
(async () => {
  "$SUB_ALL_IMAGES".split(' ').forEach(async (imageUrl) => {
    try {
      const encodedImage = await fetch(imageUrl);
      const buffer = await encodedImage.arrayBuffer();
      const view = new Uint8Array(buffer);

      const message = await openpgp.readMessage({ binaryMessage: view });

      const decrypted = await openpgp.decrypt({
	message: message,
	passwords: [password],
	format: 'binary'
      });

      const image = document.getElementById(imageUrl);
      const blob = new Blob([decrypted.data], { type: 'image/png'});
      image.src = URL.createObjectURL(blob);
      const parsed = await exifr.parse(blob, {tiff: false, xmp: true});
      if (parsed) {
	if (parsed.title) {
	  image.parentElement.setAttribute('data-title', parsed.title);
	}

      }
    } catch (e) {
      console.log(e);
    }
  });
})();
</script>
EOF
else
  cat <<EOF >> $SUB_OUTPUT_INDEX
    <script type="module">
    (async () => {
      "$SUB_ALL_IMAGES".split(' ').forEach(async (imageUrl) => {
	try {
	  const encodedImage = await fetch(imageUrl);
	  const buffer = await encodedImage.arrayBuffer();
	  const view = new Uint8Array(buffer);

	  const image =  document.getElementById(imageUrl);
	  const blob = new Blob([view], { type: 'image/png'});
	  image.src = URL.createObjectURL( blob);
	  const parsed = await exifr.parse(blob, {tiff: false, xmp: true});
	  if (parsed) {
	    if (parsed.title) {
	      image.parentElement.setAttribute('data-title', parsed.title);
	    }

	  }
	} catch (e) {
	  console.log(e);
	}

      });
    })();
</script>
EOF

fi

cat <<EOF >> $SUB_OUTPUT_INDEX
</body>
EOF

echo "$SUB_IMAGES_IDS"
