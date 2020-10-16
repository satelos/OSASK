# day01 hello, world

## 环境依赖
- nasm

    `brew install nasm`

- qemu

    `brew install qemu`

## 目录说明
```
├── Makefile        // 脚本
├── README.md       // 文档
├── hellos-hex.asm  // 这是全16进制的写法
└── hellos.asm      // 这是可读性更强的写法
```

## 调试
- 编译
```shell
make build
make build-hex # 两者编译出的字节码相同, 所以编译运行并没有什么区别
```

- 运行
```shell
make run
make run-hex
```

## 关于手输二进制
由于发现需要手输 1.4 MB 的二进制, 比较耽误时间, 所以这一部分略过, 直接开始汇编部分

## 替换 nask 的 RESB 为 nasm 下的指令
- RESB

    `RESB 4600`替换成`TIMES	4600	DB	0`
