#include "cwebdownloader.h"
#include "cmyhtmlparser.h"
#include "uri/UriParser.hpp"

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
	const QByteArray content = downloader.download("http://4pda.ru/forum/index.php?showtopic=837667&st=6000");

	CMyHtmlParser parser;
	const auto& result = parser.parse(content);
	for (const auto& tag : result)
	{
		if (tag.type == MyHTML_TAG_A)
		{
			const QString href = tag.attributeValue("href");
			if (!href.isEmpty())
			{
				qDebug() << href;

				std::string stdUrl = href.toStdString();
				const http::url parsed = http::ParseHttpUrl(stdUrl);
				qDebug() << "Host:" << QString::fromStdString(parsed.host);
				qDebug() << "Path:" << QString::fromStdString(parsed.path);
			}
		}
	}

	return 0;
}
