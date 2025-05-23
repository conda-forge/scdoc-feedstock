#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

if [[ ${CONDA_BUILD_CROSS_COMPILATION:-0} == 1 ]]; then
    CROSS_LDFLAGS=${LDFLAGS}
    CROSS_CC="${CC}"
    CROSS_LD="${LD}"

    LDFLAGS=${LDFLAGS//${PREFIX}/${BUILD_PREFIX}}
    CC=${CC_FOR_BUILD}
    unset LD

    make install LDFLAGS="${LDFLAGS}" PREFIX=${PREFIX}

    LDFLAGS="${CROSS_LDFLAGS}"
    CC=${CROSS_CC}
    LD=${CROSS_LD}
    
    HOST_SCDOC=${BUILD_PREFIX}/bin/scdoc
else
    HOST_SCDOC="${SRC_DIR}/scdoc"
fi

make install LDFLAGS="${LDFLAGS}" PREFIX=${PREFIX} HOST_SCDOC=${HOST_SCDOC}
