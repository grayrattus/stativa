#/bin/sh

for i in "$@"; do
  case $i in
    -c=*|--config=*)
      CONFIG_PATH="${i#*=}"
      shift # past argument=value
      ;;
    -o=*|--output=*)
      OUTPUT_DIRECTORY="${i#*=}"
      shift # past argument=value
      ;;
    *)
      # unknown option
      ;;
  esac
done

if [ ! -n "$CONFIG_PATH" ] || [ ! -n "$OUTPUT_DIRECTORY"  ]; then
  echo "You need to provide donfig and output directory"
  exit;
fi

TITLE=$(grep title $CONFIG_PATH | cut -d '=' -f 2)
IMAGES_DIRECTORY=$(grep imagesDirectory $CONFIG_PATH | cut -d '=' -f 2)
TEMPLATES=$(grep templates $CONFIG_PATH | cut -d '=' -f 2)
IMAGES_IDS=$(ls $IMAGES_DIRECTORY)

rm -rf $OUTPUT_DIRECTORY
mkdir $OUTPUT_DIRECTORY
OUTPUT_INDEX="$OUTPUT_DIRECTORY/index.html"
touch $OUTPUT_INDEX

SUB_IMAGES_IDS="$IMAGES_IDS"
for $template in $TEMPLATES; do
  SUB_IMAGES_IDS=$(envsubst '$SUB_IMAGES_IDS' < $template | sh)
done
