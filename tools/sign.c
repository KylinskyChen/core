#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <sys/stat.h>

#define SIZE 512

int
main(int argc, char *argv[]) {
    struct stat st;
    if (argc != 3) {
        fprintf(stderr, "Usage: <input filename> <output filename>\n");
        return -1;
    }
    if (stat(argv[1], &st) != 0) {
        fprintf(stderr, "Error opening file '%s': %s\n", argv[1], strerror(errno));
        return -1;
    }
    printf("'%s' size: %lld bytes\n", argv[1], (long long)st.st_size);
    if (st.st_size > (SIZE - 2)) {
        fprintf(stderr, "%lld >> 510!!\n", (long long)st.st_size);
        return -1;
    }
    char buf[SIZE];
    memset(buf, 0, sizeof(buf));
    FILE *ifp = fopen(argv[1], "rb");
    int size = fread(buf, 1, st.st_size, ifp);
    if (size != st.st_size) {
        fprintf(stderr, "read '%s' error, size is %d.\n", argv[1], size);
        return -1;
    }
    fclose(ifp);

    /* 
        为了避免所加载的磁盘引导扇区是一个无效扇区 (可能引导扇区中的内容就是空的或是乱码)，
        要求 512 字节大小的扇区在其最后两字节必须是 0x55 0xAA (其余的空余空间可以用 0x00 填充)，
        否则无法通过 BIOS 的校验，引导失败。 
     */
    buf[SIZE - 2] = 0x55;
    buf[SIZE - 1] = 0xAA;

    FILE *ofp = fopen(argv[2], "wb+");
    size = fwrite(buf, 1, SIZE, ofp);
    if (size != SIZE) {
        fprintf(stderr, "write '%s' error, size is %d.\n", argv[2], size);
        return -1;
    }
    fclose(ofp);
    printf("build %d bytes boot sector: '%s' success!\n", SIZE, argv[2]);
    return 0;
}

