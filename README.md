# 使用教程 (User Guide)
此脚本需联网使用 (This script requires an internet connection)

## 1. 自动安装 (Automatic Installation)
```bash
cd ~
git clone https://github.com/xishangyue/Semi-automatic-burning.git
cd Semi-automatic-burning
chmod +x Semi-automatic-burning.sh
./Semi-automatic-burning.sh
```

## 二次执行 (Re-execution)
```bash
./Semi-automatic-burning/Semi-automatic-burning.sh
```
* 第一次执行会自动安装依赖 (The first execution will automatically install dependencies)  
![Image](./semi-automatic-burning/img/flash0.webp)

## 安装完成后会自动打开脚本，自行选择语言 (The script will open automatically after installation, select the language)  
![Image](./semi-automatic-burning/img/flash1.webp)

### 推荐使用前查看概述 (It is recommended to view the overview before use)  
![Image](./semi-automatic-burning/img/flash2.webp)

## 以下选项说明 (Explanation of the following options)  
![Image](./semi-automatic-burning/img/flash3.webp)

## 查询 ID 选项 (Query ID Option)  
![Image](./semi-automatic-burning/img/flash4.webp)

## 选择烧录方式 (Select Burning Method)  
* 输入上位机密码后回车，密码是可显的 (Enter the host password and press Enter, the password is visible)  
![Image](./semi-automatic-burning/img/flash5.webp)

## 选择主板 MCU 类型 (Select Mainboard MCU Type)  
![Image](./semi-automatic-burning/img/flash6.webp)

## 选择固件类型 (Select Firmware Type)  
* 如果没有 BL 固件，选择 Katapult 原 `CANBOOT` (If there is no BL firmware, select Katapult original `CANBOOT`)  
![Image](./semi-automatic-burning/img/flash7.webp)

## 选择烧录模式 (Select Burning Mode)  
* 如果有 BL 固件并且有 USB-ID，选择 USB-ID 模式 (If there is BL firmware and USB-ID, select USB-ID mode)  
* 如果是 USB to CAN，选择 CANID 模式 (If it is USB to CAN, select CANID mode)  
* 如果是 CAN 板，直接选择 CANID 模式 (If it is a CAN board, directly select CANID mode)  
![Image](./semi-automatic-burning/img/flash8.webp)

---

# USB-ID 模式演示 (USB-ID Mode Demonstration)  
其他模式按照提示操作即可 (Follow the prompts for other modes)

### 自动进入固件配置界面 (Automatically enter the firmware configuration interface)  
* 配置主板固件后，输入 `Q Y` 回车 (After configuring the mainboard firmware, enter `Q Y` and press Enter)  
* 自动编译固件 (Automatically compile the firmware)  
![Image](./semi-automatic-burning/img/flash9.webp)  
![Image](./semi-automatic-burning/img/flash10.webp)

## 自动查询 ID (Automatically Query ID)  
* 将鼠标光标移动到 ID 上，双击左键后右键点击 `Paste`，然后回车 (Move the mouse cursor to the ID, double-click the left button, then right-click and select `Paste`, then press Enter)  
![Image](./semi-automatic-burning/img/flash11.webp)

## 自动烧录固件 (Automatically Burn Firmware)  
* 回车即可返回主界面 (Press Enter to return to the main interface)  
![Image](./semi-automatic-burning/img/flash12.webp)
