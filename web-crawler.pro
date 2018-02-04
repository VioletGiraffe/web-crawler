TEMPLATE = subdirs

SUBDIRS += crawler libcurl-cpp cpputils cpp-template-utils

libcurl-cpp.depends = cpputils
crawler.depends = cpputils libcurl-cpp