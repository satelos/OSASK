; hello-os
; TAB=4

        ORG     0x7c00          ; 指明程序装载地址

; 以下的记述用于标准的FAT12格式的软盘

        JMP     entry
        DB      0x90
        DB      "HELLOIPL"      ; 启动扇区名称（8字节）
        DW      512             ; 每个扇区（sector）大小（必须512字节）
        DB      1               ; 簇（cluster）大小（必须为1个扇区）
        DW      1               ; FAT起始位置（一般为第一个扇区）
        DB      2               ; FAT个数（必须为2）
        DW      224             ; 根目录大小（一般为224项）
        DW      2880            ; 该磁盘大小（必须为2880扇区1440*1024/512）
        DB      0xf0            ; 磁盘类型（必须为0xf0）
        DW      9               ; FAT的长度（必须是9扇区）
        DW      18              ; 一个磁道（track）有几个扇区（必须为18）
        DW      2               ; 磁头数（必须是2）
        DD      0               ; 不使用分区，必须是0
        DD      2880            ; 重写一次磁盘大小
        DB      0, 0, 0x29      ; 意义不明（固定）
        DD      0xffffffff      ; （可能是）卷标号码
        DB      "HELLO-OS   "   ; 磁盘的名称（必须为11字节，不足填空格）
        DB      "FAT12   "      ; 磁盘格式名称（必须是8字节，不足填空格）
        TIMES   18  DB  0       ; 先空出18字节

; 程序核心

entry:
        MOV     AX, 0           ; 初始化寄存器, AX是累加寄存器
        MOV     SS, AX          ; SS是栈段寄存器
        MOV     SP, 0x7c00      ; SP是栈指针寄存器
        MOV     DS, AX          ; DS是数据段寄存器
        MOV     ES, AX          ; ES是附加段寄存器

        MOV     SI, msg         ; SI是源变址寄存器
putloop:
        MOV     AL, [SI]        ; AL是累加寄存器低位
        ADD     SI, 1           ; 给SI寄存器加1
        CMP     AL, 0           ; CMP是比较指令, 结合JE来使用

        JE      fin             ; 如果CMP为0的话那么...
        MOV     AH, 0x0e        ; 显示一个文字, AH是累加寄存器高位
        MOV     BX, 15          ; 指定字符颜色, BX是基址寄存器
        INT     0x10            ; 调用显卡BIOS
        JMP     putloop
fin:
        HLT                     ; 让CPU停止, 等待指令(键鼠等外部变化)
        JMP     fin             ; 无限循环

msg:
        DB      0x0a, 0x0a      ;换行2次
        DB      "hello, world"
        DB      0x0a            ; 换行
        DB      0

        TIMES   0x1fe-($-$$)    DB  0            ; 填写0x00直到0x001fe

        DB      0x55, 0xaa

; 启动扇区以外部分输出

        DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
        TIMES   4600    DB  0
        DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
        TIMES   1469432 DB  0