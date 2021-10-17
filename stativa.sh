#/bin/sh

for i in "$@"; do
  case $i in
    -c=*|--config=*)
      CONFIG_PATH="${i#*=}"
      shift # past argument=value
      ;;
    *)
      # unknown option
      ;;
  esac
done

if [ ! -n "$CONFIG_PATH" ]; then
  echo "You need to provide config path"
  exit;
fi

export SUB_TITLE=$(grep title $CONFIG_PATH | cut -d '=' -f 2)
IMAGES_DIRECTORY=$(grep imagesDirectory $CONFIG_PATH | cut -d '=' -f 2)
TEMPLATES=$(grep templates $CONFIG_PATH | cut -d '=' -f 2)
export SUB_ENCRYPTED=$(grep encrypted $CONFIG_PATH | cut -d '=' -f 2)

if [ ! -n "$IMAGES_DIRECTORY" ]; then
  echo "You need to provide images directory in which index.html will be created"
  exit;
fi

export SUB_OUTPUT_INDEX="$IMAGES_DIRECTORY/index.html"
[ -f $SUB_OUTPUT_INDEX ] && rm $SUB_OUTPUT_INDEX
# Create array of images before cration of index.html
IMAGES_IDS=$(ls $IMAGES_DIRECTORY)

if [ -n "$SUB_ENCRYPTED" ]; then
  echo "Removing images with .gpg extension"
  rm $IMAGES_DIRECTORY/*.gpg
  IMAGES_IDS=$(ls $IMAGES_DIRECTORY)

  stty -echo
  printf "Password: "
  read GPG_PASSWORD
  stty echo
  printf "\n"

  for fileToEncrypt in $IMAGES_IDS; do
    	echo encrypting $fileToEncrypt
	gpg --output $IMAGES_DIRECTORY/$fileToEncrypt.gpg --cipher-algo AES256 --symmetric --batch --yes --passphrase $GPG_PASSWORD $IMAGES_DIRECTORY/$fileToEncrypt
  done
  IMAGES_IDS=$(ls -1 $IMAGES_DIRECTORY | grep gpg) # This is a dirty fix to get .gpg extension. Find and ls are really bad for that
fi

touch $SUB_OUTPUT_INDEX

export SUB_IMAGES_IDS="$(echo $IMAGES_IDS | xargs)"
export SUB_ALL_IMAGES="$(echo $IMAGES_IDS | xargs)"
 
for template in $TEMPLATES; do
  export SUB_IMAGES_IDS="$(envsubst '$SUB_IMAGES_IDS,$SUB_ALL_IMAGES,$SUB_OUTPUT_INDEX,$SUB_ENCRYPTED' < $template | sh)"
  echo $SUB_IMAGES_IDS
done
