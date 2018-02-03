#include <cpr/cpr.h>


int main(int argc, char* argv[])
{
	auto r = cpr::Get(cpr::Url{"https://habrahabr.ru/company/mailru/blog/345522/"});
	r.status_code;                  // 200
	r.header["content-type"];       // application/json; charset=utf-8
	r.text;                         // JSON text string


	return 0;
}
