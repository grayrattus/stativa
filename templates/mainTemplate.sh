cat << EOF >> $OUTPUT_INDEX
<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link rel="stylesheet" href="https://unpkg.com/@picocss/pico@latest/css/pico.min.css">
  <title>$TITLE</title>
</head>
<body>
EOF

echo $IMAGES
