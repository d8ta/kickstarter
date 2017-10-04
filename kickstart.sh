# Define colors
RED='\033[0;31m'
LIGHTGREEN='\033[1;32m'
NC='\033[0m' # No Color

# Remove git repo
rm -rf .git

printf "${LIGHTGREEN}\n######### CREATE FOLDERS #########${NC}\n"
mkdir -p src/fonts
mkdir -p src/images
mkdir -p src/sass/components
mkdir -p src/scripts/modules
mkdir -p src/scripts/vendor

printf "${LIGHTGREEN}\n############## NPM INIT ##############${NC}\n"
npm init

printf "${LIGHTGREEN}\n############ BOWER INIT ##############${NC}\n"
bower init

printf "${LIGHTGREEN}\n############ BOWER INSTALL ##############${NC}\n"
bower install --save bootstrap-sass
bower install --save jquery
bower install --save sass-mq
bower install --save scut

printf "${LIGHTGREEN}\n############ NPM INSTALL #############${NC}\n"
npm install --save del
npm install --save gulp
npm install --save gulp-sass
npm install --save gulp-autoprefixer
npm install --save gulp-imagemin
npm install --save gulp-iconfont
npm install --save gulp-iconfont-css
npm install --save gulp-include
npm install --save gulp-livereload
npm install --save gulp-plumber
npm install --save gulp-notify
npm install --save gulp-rename
npm install --save gulp-sourcemaps
npm install --save gulp-uglify
npm install --save run-sequence
npm install --save yargs
npm install jshint gulp-jshint jshint-stylish --save-dev

# Cleanup
printf "${LIGHTGREEN}\n/* ===== Cleanup installation ===== */${NC}\n"
rm kickstart.sh
printf "${LIGHTGREEN}\n/* ===== Cleanup Done ===== */${NC}\n"

printf "${LIGHTGREEN}\n######################################"
printf "\n######## KICKSTART COMPLETE ##########"
printf "\n######################################${NC}\n"
printf "\n${LIGHTGREEN}That’s all Folks!${NC}\n"

exit;