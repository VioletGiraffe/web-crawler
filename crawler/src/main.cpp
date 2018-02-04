#include "cwebdownloader.h"
#include "assert/advanced_assert.h"
#include "compiler/compiler_warnings_control.h"

DISABLE_COMPILER_WARNINGS
#include <QDebug>
RESTORE_COMPILER_WARNINGS

int main(int argc, char* argv[])
{
	AdvancedAssert::setLoggingFunc([](const char* message) {
		qInfo() << message;
	});

	CWebDownloader downloader;

	const QString content = downloader.download("google.com");

	return 0;
}
