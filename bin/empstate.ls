#!/usr/bin/env lsc
require! {
    cheerio
    http
    util
    argparse
    readline
}

url=\http://geip/gpublic/empservice/admininfo/empstate/DEFAULT.ASP'
post="year1=1990&month1=6&day1=1&year2=#{today_y}&month2=#{today_m}&day2=#{today_d}&CodeID=ALL&MVNO=#{user}&Dept=&cpf37=&tpe01=&B1="

parser = (html) ->
    out = new Array()
    $ = cheerio.load(html)
