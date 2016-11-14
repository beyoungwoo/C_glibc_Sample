#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys

import os
import time

import configparser
import logging
from telepot.namedtuple import InlineKeyboardMarkup, InlineKeyboardButton
import telepot

import urllib.request

from bs4 import BeautifulSoup
from typing import List

bot = ' '
config = ' '

def sendMessage(chat_id: int, meg: str): 
    try:
        bot.sendMessage(chat_id, meg)
    except Exception as e:
        logging.error(e, exc_info=True)

def bot_help(chat_id: int):
    sendMessage(chat_id, 
'''
개인 알림 봇 사용 명령어
/1 : 아파트 전세 실거래가 (e.g. /1 11440 201612)
/2 : 내집체크 not yours.  (e.g. /2 )
''')

def get_apt_rent(command: List[str]):
    result = '' 

    param_len = len(command)
    if (param_len != 3):
        # use defult
        loc_code = 11440
        ymd = 201611
    else:
        loc_code = command[1]
        ymd = command[2]

    url = config.get('TOKEN', 'apt_rent_url')
    svc_key = config.get('TOKEN', 'apt_rent_key', raw=True)
    request_url = '%s?LAWD_CD=%s&DEAL_YMD=%s&serviceKey=%s' % (url, loc_code, ymd, svc_key)
    req = urllib.request.Request(request_url)
    try:
        res = urllib.request.urlopen(req)
    except UnicodeEncodeError:
        result = 'Check your input'
        return result

    soup = BeautifulSoup(res.read().decode('utf-8'), 'html.parser') 
    items = soup.findAll('item')
    for item in items:
        item = item.contents
        print(item[0])
        
    return result
        

        #request_url = '%s?LAWD_CD=%s&DEAL_YMD=%s&serviceKey=%s' % (url, loc_code, ymd, svc_key)
'''
["['", "2016', '년', '", "상암동', '법정동', '", "    35,000', '보증금액', '", "상암월드컵파크5단지', '아파트', '", "11', '월', '", "        70', '월세금액', '", "1~10', '일', '", "104.69', '전용면적', '", "1658', '지번', '", "11440', '지역코드', '", "4', '층']"]
'''


def on_chat_message(msg):
    content_type, chat_type, chat_id = telepot.glance(msg)
    logging.info('content type: %s, chat type: %s, chat id: %s',
            content_type, chat_type, chat_id)

    if content_type != 'text':
        sendMessage(chat_id, "Only text!")

    rcv_msg = msg['text']
    command = rcv_msg.split(' ')
    print(command)

    if command[0] == '/1':
        res_list = get_apt_rent(command)
        for res in res_list:
            sendMessage(chat_id, res)
    else:
        bot_help(chat_id)
    return


def on_callback_query(msg):
    query_id, from_id, query_data = telepot.glance(msg, flavor='callback_query')
    print('callback query :', query_id, from_id, query_data)


if __name__ == '__main__':

    # Read config
    config = configparser.ConfigParser()
    config.readfp(open('bot.ini'))

    token = config.get('TOKEN', 'telegram')
    log_level = config.getint('LOG', 'level')

    # Set logging
    logging.basicConfig(filename='telegram_bot.log', level=log_level)

    bot = telepot.Bot(token)
    logging.info(bot.getMe())

    bot.message_loop({'chat': on_chat_message,
                      'callback_query': on_callback_query},
                      run_forever='Listening ...')

    sys.exit(0)
