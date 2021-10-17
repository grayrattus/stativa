# Stativa

Static site gallery generator that uses `gpg` for images encryption.

You can use it to:

- make gallery from you vacation photos and share with your friends. You really don't need to use Instagram or Facebook
- make gallery that you want to shared only with people who know password for your photos
- present XMP metadata of your files

# Basic usage Usage 

`sh stativa.sh -c=pathToTomlConfig`

## Encrypted example
```
sh stativa.sh -c=config_encrypted.toml
cd encrypted_my_photos

http-server .
```

## Without encryption
```
sh stativa.sh -c=config_normal.toml
cd my_photos

http-server .
```

# How to configure?

Very basic config file should look like this.
```
title=Title of website
templates=templates/mainTemplate.sh templates/smallImagesPartialTemplate.sh templates/footer.sh
encrypted=TRUE
imagesDirectory=encrypted_my_photos
```

## Config description
- title - this one accept page title
- templates - separated with space list of templates. At least 2 are required to make it working `mainTemplate.sh` and `footer.sh` but I didn't make them default since maybe you want to make custom ones. It's pretty easy.
- encrypted - if it's provided files will be encrypted with passphrase you provide in further step.
- imagesDirectory - path to directory in which you would like to make gallery from. In this directory `index.html` will be generated that will allow to view your files in the browser.

# Templates

Specify templates that will be filled with image ids of what as argument.
Everytime new title is present new template will be generated.

<span color="red">EVERY TEMPLATE NEEDS TO `echo` IMAGES THAT WERE NOT USED IN TEMPLATE. THIS IS DONE THIS WAY SO YOU CAN HAVE MULTIPLE TEMPLATES THAT WILL WORK ON REST OF IMAGES.</span>

- mainTemplate
Main template specify top part of HTML with `head` and start of `body` tag.

- footer
This is very important part. You need to provide it as one of last templates.
It is adding decryption for `gpg` or link images when encryption flag is not provided.

It also feeds `parentElement` of `img` tags with data from [XMP metatdata format](https://www.adobe.com/products/xmp.html). 

# Special variables in tempates

- `SUB_TITLE` - title of the page
- `SUB_ENCRYPTE` - if it's present that means you should treat all files as encrypted
- `SUB_OUTPUT_INDEX` - path to `index.html`
- `SUB_IMAGES_IDS` - string of paths to images separated by space that left between template parsing
- `SUB_ALL_IMAGES` - string of paths separated by space that are in images directory provided in config

# Why stativa?

`sta` comes from `static site generator` and `va` from `vacation`.
