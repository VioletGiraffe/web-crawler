TEMPLATE = subdirs

SUBDIRS += crawler cpputils cpp-template-utils

crawler.depends = cpputils
