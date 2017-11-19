#!/bin/bash

project_name=${1:-game}
tab=$(echo -e '\t')

cat << EOF
APP=${project_name}.love
SRC=${project_name}

.PHONY: clean

\$(APP): \$(SRC)
${tab}(cd \$<; zip -9 -r \$@ .)
${tab}mv \$</\$@ .

clean:
${tab}rm -f \$(APP)
EOF
