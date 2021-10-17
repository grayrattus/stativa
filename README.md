# Title of this project need to be agreed

# Usage 

stativa -c pathToTomlConfig

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

#templates
Specify templates that will be filled with image ids of what as argument.
Everytime new title is present new template will be generated.

<span color="red">EVERY TEMPLATE NEEDS TO `echo` IMAGES THAT WERE NOT USED IN TEMPLATE. THIS IS DONE THIS WAY SO YOU CAN HAVE MULTIPLE TEMPLATES THAT WILL WORK ON REST OF IMAGES.</span>

- mainTemplate
Main template specify top part of HTML with `head` and start of `body` tag.

- footer
This is very important part. You need to provide it as one of last templates.
It is adding decryption for `gpg` or link images when encryption flag is not provided.


