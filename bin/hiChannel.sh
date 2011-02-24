#!/usr/bin/env bash
# Author: Andrew Chen <yongjhih@gmail.com>
# CC, Creative Commons
# Author: Andrew Chen <yongjhih@gmail.com>
# CC, Creative Commons
## Name: hiChannel command line tuner
## Copyright (R) 2007-2008 Shih-Yuan Lee (FourDollars) <fourdollars@gmail.com>
## License: GPLv3

declare -x version_number="1.2.6"
declare -i option_verbose=0
declare -i option_live_tv=0
declare -i option_alarm_clock=0
declare -i retry_times=5
declare -i retry_interval=5
declare -x alarm_file="file://$HOME/alarm.mp3"

function player ()
{
	case $(uname) in
		Darwin)
		open -a "QuickTime Player" $1 && osascript -e "tell application \"QuickTime Player\"" -e "tell document 1" -e "play" -e "end tell" -e "end tell"
		;;
		*BSD)
		mplayer $1
		;;
		Linux)
		if [ ! -z "$(which mimms)" ] && [ ! -z "$(which ffplay)" ]; then
			mimms $1 - | ffplay -
		elif [ ! -z "$(which gst-launch)" ]; then
			gst-launch playbin uri=$1
		elif [ ! -z "$(which mplayer)" ]; then
			mplayer $1
		elif [ ! -z "$(which xine)" ]; then
			xine $1
		elif [ ! -z "$(which totem)" ]; then
			totem $1
		fi
		;;
	esac
}

function play_alarm ()
{
	while :; do 
		player ${alarm_file}
	done
}

program_name="hiChannel 命令列點播器 v${version_number}"

prompt_message='請選擇：'

category_list=(music life news others foreign culture traffic live)

category_name=(音樂 生活資訊 新聞 綜合 外語 多元文化 交通 免費影視)

music_site_list=(
	'ASIAFM 衛星音樂台' '321'
	'Apple line 蘋果線上' '248'
	'BestRadio 台中好事903' '211'
	'BestRadio 台北好事989' '212'
	'BestRadio 花蓮好事935' '303'
	'BestRadio 高雄港都983' '213'
	'Flyradio 飛揚調頻895' '357'
	'HitFm 聯播網 台中91.5' '88'
	'HitFm 聯播網 高雄90.1' '90'
	'HitFm 聯播網 台北91.7' '87'
	'KISS RADIO 南投廣播' '258'
	'KISS RADIO 台南知音廣播' '255'
	'KISS RADIO 大苗栗廣播' '256'
	'KISS RADIO 大眾廣播電台' '156'
	'KISS RADIO 網路音樂台' '308'
	'中廣古典網' '162'
	'中廣流行網' '205'
	'中廣音樂網 i radio' '206'
	'佳音CCM' '304'
	'全國廣播音樂網' '338'
	'台北之音經典音樂台' '222'
	'台北愛樂' '228'
	'台灣之音-音樂' '313'
	'太陽電台' '289'
	'奇美古典音樂網' '294'
	'寶島新聲廣播電台' '259'
)

life_site_list=(
	'ASIA FM92.3 亞太電台' '295'
	'ASIA FM92.7 亞州電台' '210'
	'GOLD FM-台中城市廣播' '226'
	'GOLD FM-台北健康電台' '229'
	'IC之音' '148'
	'佳音廣播電台' '201'
	'佳音電台2台' '250'
	'全國廣播' '202'
	'台中廣播' '230'
	'台北廣播電台- 都會資訊頻道' '208'
	'台北廣播電台喔海洋頻道' '238'
	'台視數位廣播' '319'
	'大千電台' '109'
	'大愛網路電台' '325'
	'宜蘭中山電台' '301'
	'環宇廣播' '282'
	'真心之音廣播電台' '217'
	'蒲公英聖樂網' '337'
	'警廣長青網' '271'
	'青春線上' '356'
	'飛碟電台' '232'
)

news_site_list=(
	'NEWS98新聞網' '187'
	'中廣新聞網' '207'
)

others_site_list=(
	'台灣之音-華語' '315'
	'復興廣播電台 短波網' '288'
	'復興廣播電台 第一網' '286'
	'復興廣播電台 第二網' '287'
	'正聲台北調幅台' '317'
	'正聲台北調頻台' '198'
	'漢聲光華網-中波' '281'
	'漢聲光華網-短波' '309'
	'漢聲廣播電台' '215'
	'漢聲廣播電台全國調頻網' '216'
	'綠色和平台灣文化廣播電台' '327'
)

foreign_site_list=(
	'ICRT' '177'
	'台灣之音-FM' '312'
	'台灣之音-亞洲' '311'
	'台灣之音-歐美及方言' '314'
)

culture_site_list=(
	'中廣客家頻道' '160'
	'大漢之音' '300'
	'寶島客家' '241'
	'新客家廣播電台' '254'
	'高屏溪客家電台' '298'
)

traffic_site_list=(
	'警廣—交通網台東台' '358'
	'警廣全國交通網' '269'
	'警廣台中台' '260'
	'警廣台北台' '261'
	'警廣台南台' '263'
	'警廣宜蘭台' '265'
	'警廣新竹台' '268'
	'警廣花蓮台' '266'
	'警廣高雄台' '267'
)

live_site_list=(
	'世棒2台' '603'
	'世界盃棒球直播' '996'
	'KuLife' '997'
	'KuMovie' '998'
	'KuDrama' '999'
	'Bloomberg Television' '1001'
	#'中視' '36'
	'中天新聞台' '37'
	'大愛電視台' '38'
	'華視影音頻道' '50'
	'生命電視台' '54'
	'大愛電視二台' '57'
	#'台灣樂起來(樂透開獎)' '58'
	#'NOKIA音樂讓我說演唱會' '604'
	'流行追蹤' '21'
)

function read_category ()
{
	echo ${program_name}
	size=${#category_list[@]}
	for ((i=0; i<size; i++)); do
		echo " $((i+1)). ${category_name[$i]}"
	done
	echo -n ${prompt_message}
	read category 
}

function read_channel ()
{
	echo ${program_name}
	echo " ${category}. ${category_name[$((category-1))]}"
	echo -e "   0. 回到上一層"
	eval size=\${#${category_list[$((category-1))]}_site_list[@]}
	for ((i=0; i<size/2; i++)); do
		eval name=\${${category_list[$((category-1))]}_site_list[$((i*2))]}
		printf "  %2d. %s\n" $((i+1)) "$name"
	done
	echo -n ${prompt_message}
	read channel
}

function wmp_get ()
{
	if [ "$(uname)" != "Darwin" ]; then
		if [ ! -z $(which wget) ]; then
			wget -q --user-agent 'Windows Media Player' --referer 'http://www.hichannel.hinet.net' -O - "$*"
		elif [ ! -z $(which curl) ]; then
			curl -q --user-agent 'Windows Media Player' --referer 'http://www.hichannel.hinet.net' --location -o - "$*"
		fi
	else
		curl -q --user-agent 'Windows Media Player' --referer 'http://www.hichannel.hinet.net' --location -o - "$*"
	fi
}

function hinet_radio_url ()
{
	wmp_get $(wmp_get "http://www.hichannel.hinet.net/api/streamFreeRadio.jsp?id=$*" | grep mms | cut -d '"' -f 2) | grep 203 | cut -d '"' -f 2
}

function hinet_video_url ()
{
	wmp_get $(wmp_get "http://www.hichannel.hinet.net/api/streamFreeLive.jsp?id=$*&quality=high" | grep mms | cut -d '"' -f 2) | grep 203 | cut -d '"' -f 2
}

function set_alarm_clock ()
{
	local input 
	local -i alarm_time
	local -i now_time
	local -i alarm_interval_second
	echo -en "\r請輸入鬧鐘啟動時間：" && read input
	until [ ! -z $input ] && date -d "$(date +%D) $input" +%s > /dev/null ; do
		echo -en "\r請輸入鬧鐘啟動時間：" && read input
	done
	alarm_time=$(date -d "$(date +%D) $input" +%s)
	now_time=$(date +%s)
	if [ $alarm_time -le $now_time ]; then
		alarm_time=$alarm_time+60*60*24
	fi
	until [ $now_time -ge $alarm_time ]; do
		sleep 1
		now_time=$(date +%s)
		echo -en "\r現在是 $(date +%T) 鬧鐘設定在 $input"
	done
	echo -en "\n"
}

function media_player ()
{
	local -i retry=0
	if [ $option_alarm_clock = 1 ]; then
		set_alarm_clock
		if [ $option_live_tv = 1 ] ; then
			until player $(hinet_video_url $1); do
				retry=$retry+1
				if [ $retry -ge ${retry_times} ]; then
					play_alarm
					break
				fi
				sleep ${retry_interval}
			done
		else
			until player $(hinet_radio_url $1); do
				retry=$retry+1
				if [ $retry -ge ${retry_times} ]; then
					play_alarm
					break
				fi
				sleep ${retry_interval}
			done
		fi
	else
		if [ $option_live_tv = 1 ] ; then
			player $(hinet_video_url $1)
		else
			player $(hinet_radio_url $1)
		fi
	fi
}

function main_func ()
{
	while :; do
		clear
		read_category

		if [ -n $category -a $category -gt 0 -a $category -le ${#category_list[@]} ]; then
			while :; do
				clear
				read_channel

				if [ -n $channel -a $channel -eq 0 ]; then
					break
				elif [ -n $channel -a $channel -gt 0 -a $channel -le $((size/2)) ]; then
					break
				else
					continue
				fi
			done
		fi

		if [ -n $channel -a $channel -ne 0 ]; then
			break
		fi
	done

	clear
	eval channelname=\${${category_list[$((category-1))]}_site_list[$((channel*2-2))]}
	echo "現在要播放的是 [$channelname]"

	eval channel=\${${category_list[$((category-1))]}_site_list[$((channel*2-1))]}

	if [ $category = 8 ]; then
		if [ $option_verbose = 1 ]; then
			echo "$0 --live $channel" 
		fi
		option_live_tv=1
	else
		if [ $option_verbose = 1 ]; then
			echo "$0 $channel"
		fi
	fi
	media_player $channel
}

function show_usage ()
{
	cat <<ENDLINE
$0 [--options] [#channel] 
	--help or -h	: show help message
	--alarm or -a	: enter alarm mode
	--live or -l	: live tv stream
	--verbose or -v : show more information
ENDLINE
}

function parse_parameter ()
{
	case $1 in
		--help|-h)
		show_usage
		exit
		;;
		--alarm|-a)
		option_alarm_clock=1
		;;
		--live|-l)
		option_live_tv=1
		;;
		--verbose|-v)
		option_verbose=1
		;;
		*)
		media_player $1
		exit
	esac
}

function system_check ()
{
	if [ "$(uname)" != "Darwin" ]; then
		if [ -z "$(which wget)" -a -z "$(which curl)" ]; then
			echo "$0 needs wget or curl, please install one of them."
			exit
		fi
	fi

	case $(uname) in
		*BSD)
		if [ -z "$(which mplayer)" ]; then
			echo "$0 needs mplayer, please install it."
			exit
		fi
		;;
		Linux)
		if [ -z "$(which mimms)" -a -z "$(which ffplay)" -a -z "$(which gst-launch)" -a -z "$(which mplayer)" -a -z "$(which xine)" -a -z "$(which totem)" ]; then
			echo "$0 needs mplayer/xine/totem, please install one of them."
			exit
		fi
		;;
	esac
}

system_check

if [ $# -gt 0 ]; then
	while [ $# -gt 0 ]; do
		if [ $# -gt 0 ]; then
			parse_parameter $1
		fi
		shift
	done
fi

main_func
