#!/bin/bash

project_name=${1:-game}
tab=$(echo -e '\t')

cat << EOF
# Generated with Love Project Builder
# https://github.com/ediiknorand/love-project-builder

APP=${project_name}.love
SRC=${project_name}

.PHONY: clean

\$(APP): \$(SRC)
${tab}(cd \$<; zip -9 -r \$@ .)
${tab}mv \$</\$@ .

clean:
${tab}rm -f \$(APP)
EOF
