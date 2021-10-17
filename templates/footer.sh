#/bin/sh

if [ -n "$SUB_ENCRYPTED" ]; then
  cat <<EOF >> $SUB_OUTPUT_INDEX
  <script type="module">
  const password = prompt("To view gallery type password");
(async () => {
  try {
    "$SUB_IMAGES_IDS".split(' ').forEach((imageUrl) => {
      const encodedImage = await fetch(imageUrl);
      const buffer = await encodedImage.arrayBuffer();
      const view = new Uint8Array(buffer);

      const message = await openpgp.readMessage({ binaryMessage: view });

      const decrypted = await openpgp.decrypt({
	message: message,
	passwords: [password],
	format: 'binary'
      });

      const image =  document.getElementById(imageUrl);
      image.src = URL.createObjectURL( new Blob([decrypted.data], { type: 'image/png'}));
    } catch (e) {
      console.log(e);
    }

  });
})()
  </script>
EOF
else
  cat <<EOF >> $SUB_OUTPUT_INDEX
    <script type="module">
    (async () => {
      "$SUB_IMAGES_IDS".split(' ').forEach(async (imageUrl) => {
	try {
	  const encodedImage = await fetch(imageUrl);
	  const buffer = await encodedImage.arrayBuffer();
	  const view = new Uint8Array(buffer);

	  const image =  document.getElementById(imageUrl);
	  image.src = URL.createObjectURL( new Blob([view.data], { type: 'image/png'}));
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
