#/bin/sh
cat <<EOF >> $SUB_OUTPUT_INDEX
<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  $([ -n "$SUB_ENCRYPTED" ] && echo '<script src="https://unpkg.com/openpgp@5.0.0/dist/openpgp.js" ></script>')

  <link rel="stylesheet" href="https://unpkg.com/@picocss/pico@latest/css/pico.min.css">
  <title>$SUB_TITLE</title>
</head>
<body>
EOF

echo "$SUB_IMAGES_IDS"
