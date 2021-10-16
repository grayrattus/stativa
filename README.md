# Title of this project need to be agreed

# toml config properties

mainTitle="Title of website"
mainTemplate="mainLinker"

title="Title of website"
templates="simpleGrid=4 bigPhoto=1 simpleGrid=4 footer" - some templates can have default amount of images or argument specified ones
encrypted=TRUE
imagesDirectory="pathToDirectoryOfImages"

title="Title of website"
templates="simpleGrid=4 bigPhoto=1 simpleGrid=4 footer" - some templates can have default amount of images or argument specified ones
encrypted=TRUE
imagesDirectory="pathToDirectoryOfImages"

# Usage 

stativa -c pathToTomlConfig -o dirToOutputContent

#mainTemplate
Main template is a template that will be used to join links to all other templates.

#templates
Specify templates that will be filled with image ids of what as argument.
Everytime new title is present new template will be generated.

#encrypted
If specified as true images will be ecnrypted with passphrase which you will be asked
during encryption.

#imagesDirectory
Directory to build galery from

