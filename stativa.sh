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

export SUB_TITLE=$(grep title $CONFIG_PATH | cut -d '=' -f 2)
IMAGES_DIRECTORY=$(grep imagesDirectory $CONFIG_PATH | cut -d '=' -f 2)
TEMPLATES=$(grep templates $CONFIG_PATH | cut -d '=' -f 2)
export SUB_ENCRYPTED=$(grep encrypted $CONFIG_PATH | cut -d '=' -f 2)
IMAGES_IDS=$(find $IMAGES_DIRECTORY -type f )

echo $TEMPLATES
rm -rf $OUTPUT_DIRECTORY
mkdir $OUTPUT_DIRECTORY
export SUB_OUTPUT_INDEX="$OUTPUT_DIRECTORY/index.html"
touch $SUB_OUTPUT_INDEX

export SUB_IMAGES_IDS="$(echo $IMAGES_IDS | xargs)"
 
for template in $TEMPLATES; do
  export SUB_IMAGES_IDS="$(envsubst '$SUB_IMAGES_IDS,$SUB_OUTPUT_INDEX,$SUB_ENCRYPTED' < $template | sh)"
  echo "NOWA PETLA"
  echo $SUB_IMAGES_IDS
  #envsubst '$SUB_IMAGES_IDS:$SUB_OUTPUT_INDEX:$SUB_TITLE' < $template
done
