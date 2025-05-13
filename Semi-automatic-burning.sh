#!/usr/bin/env python3

import os
import re
import subprocess
import sys
import tempfile
import time
import importlib.util

# --- 新增：自动检测并安装 requests ---
def 检测并安装依赖():
    required = {'requests'}
    installed = set()
    for lib in required:
        if importlib.util.find_spec(lib) is None:
            print(f"正在安装依赖: {lib}...")
            try:
                subprocess.check_call([sys.executable, '-m', 'pip', 'install', '--user', lib])
                installed.add(lib)
            except subprocess.CalledProcessError:
                print(f"无法自动安装 {lib}，请手动运行: pip install {lib}")
                sys.exit(1)
    if installed:
        print("依赖安装完成，重新启动脚本...")
        os.execv(sys.executable, [sys.executable] + sys.argv)  # 重启脚本

检测并安装依赖()

# --- 原有代码（确保 requests 已安装）---
import requests

MESSAGES = {
    'zh': {
        'select_lang': "请选择系统语言" " Please select a system language：",
        'chinese': "1. 中文",
        'english': "2. English",
        'invalid_opt': "无效选项，请重新选择" "Invalid option, please select again",
        'requesting': "正在请求(尝试 {attempt}/{max_retries})",
        'retry': "请求失败: {error}",
        'max_retry': "请求失败(已达到最大重试次数)",
        'exec_script': "正在执行交互式脚本(尝试 {attempt}/{max_retries})",
        'input_prompt': "(按 Ctrl+C 可中断)",
        'no_sh_links': "未找到以 '.sh' 结尾的链接。",
        'script_done': "退出成功"
    },
    'en': {
        'select_lang': "Please select system language:",
        'chinese': "1. Chinese",
        'english': "2. English",
        'invalid_opt': "Invalid option, please try again",
        'requesting': "Requesting (Attempt {attempt}/{max_retries})",
        'retry': "Request failed: {error}",
        'max_retry': "Request failed (maximum retries reached)",
        'exec_script': "Executing interactive script (Attempt {attempt}/{max_retries})",
        'input_prompt': "(Press Ctrl+C to interrupt)",
        'no_sh_links': "No .sh links found.",
        'script_done': "Exit successfully"
    },
    'xi': {
        'select_lang': "请选择系统语言" " Please select a system language：",
        'chinese': "3. 中文窗口",
        'english': "2. English",
        'invalid_opt': "无效选项，请重新选择" "Invalid option, please select again",
        'requesting': "正在请求(尝试 {attempt}/{max_retries})",
        'retry': "请求失败: {error}",
        'max_retry': "请求失败(已达到最大重试次数)",
        'exec_script': "正在执行交互式脚本(尝试 {attempt}/{max_retries})",
        'input_prompt': "(按 Ctrl+C 可中断)",
        'no_sh_links': "未找到以 '.sh' 结尾的链接。",
        'script_done': "退出成功"        
    }
}

API_URL = {
    'zh': "https://sharechain.qq.com/927a65433ae97c682f5b8c4995394caf",
    'en': "https://sharechain.qq.com/9c988855e52153afc9e8a63009889b20",
    'xi': "https://sharechain.qq.com/32350fc41484b6ab582a401ab0e2067c"
}
TIMEOUT = 30
MAX_RETRIES = 3

def 清屏():
    os.system('cls' if os.name == 'nt' else 'clear')
def 安全打印(内容, lang='zh', **kwargs):
    try:
        print(内容.format(**kwargs) if kwargs else 内容)
    except UnicodeEncodeError:
        print(内容.encode('utf-8').decode('latin1'))

def 安全请求(url, lang='zh'):
    重试次数 = 0  
    while 重试次数 < MAX_RETRIES:
        清屏()
        安全打印(MESSAGES[lang]['requesting'], attempt=重试次数+1, max_retries=MAX_RETRIES, lang=lang)
        
        try:
            响应 = requests.get(url, timeout=TIMEOUT)
            响应.encoding = 'utf-8'  # 强制UTF-8解码
            响应.raise_for_status()
            return 响应.text
        except requests.exceptions.RequestException as 错误:
            安全打印(f"请求错误: {错误}", lang=lang)
        except Exception as 错误:
            安全打印(f"未知错误: {错误}", lang=lang)
        
        if 重试次数 < MAX_RETRIES:
            time.sleep(2)
        重试次数 += 1
    
    安全打印(MESSAGES[lang]['max_retry'], lang=lang)
    sys.exit(1)

def 提取sh链接(内容):
    return re.findall(r'https?://[^"\s]+\.sh', 内容)

def 执行脚本(链接, lang='zh'):
    重试次数 = 0
    
    while 重试次数 < MAX_RETRIES:
        清屏()
        安全打印(MESSAGES[lang]['exec_script'], attempt=重试次数+1, max_retries=MAX_RETRIES, lang=lang)
        安全打印(MESSAGES[lang]['input_prompt'], lang=lang)
        
        try:
            with tempfile.NamedTemporaryFile(mode='w+', suffix='.sh', encoding='utf-8', delete=False) as 临时文件:
                临时文件名 = 临时文件.name
                响应 = requests.get(链接, timeout=TIMEOUT)
                响应.encoding = 'utf-8'
                临时文件.write(响应.text)
            
            os.chmod(临时文件名, 0o755)
            
            进程 = subprocess.Popen(
                ['/bin/bash', 临时文件名],
                env=os.environ.copy(),
                stdin=sys.stdin,
                stdout=sys.stdout,
                stderr=sys.stderr
            )
            进程.wait()
            
            if 进程.returncode == 0:
                安全打印(MESSAGES[lang]['script_done'], lang=lang)
                return True
            else:
                raise subprocess.CalledProcessError(进程.returncode, 临时文件名)
                
        except Exception as 错误:
            安全打印(str(错误), lang=lang)
            重试次数 += 1
            time.sleep(2)
        finally:
            if '临时文件名' in locals() and os.path.exists(临时文件名):
                os.remove(临时文件名)
    
    安全打印(MESSAGES[lang]['max_retry'], lang=lang)
    return False

def 主流程():
    当前语言 = 'zh'

    while True:
        try:
            清屏()
            安全打印(MESSAGES[当前语言]['select_lang'])
            安全打印(MESSAGES['zh']['chinese'])
            安全打印(MESSAGES['en']['english'])
            安全打印(MESSAGES['xi']['chinese'])
            选择 = input("请选择: ").strip()  # 修改了这里的输入提示
            
            if 选择 == '1':
                当前语言 = 'zh'
                break
            elif 选择 == '2':
                当前语言 = 'en'              
                break
            elif 选择 == '3':
                当前语言 = 'xi'              
                break                
            else:
                安全打印(MESSAGES[当前语言]['invalid_opt'], lang=当前语言)
                time.sleep(1)
        
        except KeyboardInterrupt:
            清屏()
            print("\n用户中断操作，程序退出/User interrupts operation, program exits")
            sys.exit(0)
    
    try:
        内容 = 安全请求(API_URL[当前语言], lang=当前语言)
        sh链接列表 = 提取sh链接(内容)
        
        if not sh链接列表:
            安全打印(MESSAGES[当前语言]['no_sh_links'], lang=当前语言)
            sys.exit(1)  # Exit with a non-zero status code
        
        执行脚本(sh链接列表[0], lang=当前语言)
    
    except KeyboardInterrupt:
        清屏()
        print("\n用户中断操作，程序退出/User interrupts operation, program exits")
        sys.exit(0)

if __name__ == "__main__":
    主流程()
