#### Automatic installation
```
cd ~
git clone https://github.com/xishangyue/Semi-automatic-burning.git
./Semi-automatic-burning.sh
```
#### If you need to execute again.
```
./Semi-automatic-burning.sh
```

# 使用教程
# 此脚本需联网使用
## 1. 自动安装
```cfg
cd ~
git clone https://github.com/xishangyue/Semi-automatic-burning.git
cd Semi-automatic-burning
chmod +x Semi-automatic-burning.sh
./Semi-automatic-burning.sh
```
## 二次执行
```cfg
./Semi-automatic-burning/Semi-automatic-burning.sh
```
* 第一次执行会自动安装依赖
![Image](./semi-automatic-burning/img/flash0.webp)

## 安装完成会自动打开脚本，自行选择语言
![Image](./semi-automatic-burning/img/flash1.webp)

### 推荐使用前看一下概述
![Image](./semi-automatic-burning/img/flash2.webp)

## 以下选项
![Image](./semi-automatic-burning/img/flash3.webp)

## 查询id 选项
![Image](./semi-automatic-burning/img/flash4.webp)

## 选择烧录方式
* 出来输入上位机密码输入密码即可，然后回车，密码是可显
![Image](./semi-automatic-burning/img/flash5.webp)

## 选择你要烧录主板mcu类型
![Image](./semi-automatic-burning/img/flash6.webp)

## 选择你要烧录的固件类型 如没有BL固件选择katapult原`CANBOOT`
![Image](./semi-automatic-burning/img/flash7.webp)

## 选择你要烧录模式  选择完成了回车即可
* 如你有bl固件并且有usb-id 那么选择usb-id模式，如果你是usb to can 那么选择canid模式
* 如果你是can板那么直接选择canid模式
![Image](./semi-automatic-burning/img/flash8.webp)

# 下面是usb-id模式演示 其他模式按照提示操作即可

### 会自动进入固件配置界面
* 配置好主板固件后 输入Q Y 回车即可
* 会自动进行编译固件
![Image](./semi-automatic-burning/img/flash9.webp)
![Image](./semi-automatic-burning/img/flash10.webp)

## 会自动查询id 把鼠标（光标）移动到id上面双击左键然后右键然后点击`Paste` 即可 回车
![Image](./semi-automatic-burning/img/flash11.webp)

## 会自动烧录固件
* 回车即可返回主界面
![Image](./semi-automatic-burning/img/flash12.webp)
