TEMPLATE = subdirs

SUBDIRS += crawler myhtml-pp libcurl-cpp cpputils cpp-template-utils

libcurl-cpp.depends = cpputils
myhtml-pp.depends = cpputils
crawler.depends = myhtml-pp libcurl-cpp cpputils
