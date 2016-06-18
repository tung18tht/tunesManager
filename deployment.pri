OTHER_FILES +=\
$${PWD}/scripts/search.sh
OTHER_FILES +=\
$${PWD}/scripts/sort.sh
OTHER_FILES += \
$${PWD}/scripts/checkDuplicate.sh
OTHER_FILES +=\
$${PWD}/README.md

unix:!android {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/bin
        } else {
            target.path = /opt/$${TARGET}/bin
        }
        export(target.path)
    }
    INSTALLS += target
}

export(INSTALLS)
