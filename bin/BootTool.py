#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import shutil
import struct

"""
#define BOOT_MAGIC "ANDROID!"
#define BOOT_MAGIC_SIZE 8
#define BOOT_NAME_SIZE 16
#define BOOT_ARGS_SIZE 512
 
struct boot_img_hdr
{
    unsigned char magic[BOOT_MAGIC_SIZE];
 
    unsigned kernel_size;  /* size in bytes */
    unsigned kernel_addr;  /* physical load addr */
 
    unsigned ramdisk_size; /* size in bytes */
    unsigned ramdisk_addr; /* physical load addr */
 
    unsigned second_size;  /* size in bytes */
    unsigned second_addr;  /* physical load addr */
 
    unsigned tags_addr;    /* physical addr for kernel tags */
    unsigned page_size;    /* flash page size we assume */
    unsigned unused[2];    /* future expansion: should be 0 */
 
    unsigned char name[BOOT_NAME_SIZE]; /* asciiz product name */
 
    unsigned char cmdline[BOOT_ARGS_SIZE];
 
    unsigned id[8]; /* timestamp / checksum / sha1 / etc */
};
"""

def main():
    boot_name = 'boot.img'
    #boot_name = 'recovery.img'
    bootimg = open(boot_name, 'rb').read()

    # header
    cur = 0

    size = 8
    magic = struct.unpack('8s', bootimg[cur:cur+size])[0];
    cur += size

    size = 4    
    kernel_size = struct.unpack('i', bootimg[cur:cur+size])[0]
    cur += size

    size = 4
    kernel_addr = struct.unpack('i', bootimg[cur:cur+size])[0]
    cur += size

    size = 4
    ramdisk_size = struct.unpack('i', bootimg[cur:cur+size])[0]
    cur += size

    size = 4
    ramdisk_addr = struct.unpack('i', bootimg[cur:cur+size])[0]
    cur += size

    size = 4
    second_size = struct.unpack('i', bootimg[cur:cur+size])[0]
    cur += size

    size = 4
    second_addr = struct.unpack('i', bootimg[cur:cur+size])[0]
    cur += size

    size = 4
    tags_addr = struct.unpack('i', bootimg[cur:cur+size])[0]
    cur += size

    size = 4
    page_size = struct.unpack('i', bootimg[cur:cur+size])[0]
    cur += size

    size = 8
    unused = struct.unpack('2i', bootimg[cur:cur+size])
    cur += size

    size = 16
    name = struct.unpack('16s', bootimg[cur:cur+size])[0]
    cur += size

    size = 512
    cmdline = struct.unpack('512s', bootimg[cur:cur+size])[0]
    cur += size

    size = 32
    ID = struct.unpack('8i', bootimg[cur:cur+size])
    cur += size    

    """
    print 'magic', magic    
    print 'kernel_size', kernel_size
    print 'kernel_addr', kernel_addr
    print 'ramdisk_size', ramdisk_size
    print 'ramdisk_addr', ramdisk_addr
    print 'second_size', second_size
    print 'second_addr', second_addr    
    print 'tags_addr', tags_addr
    print 'page_size', page_size
    print 'unused', unused
    print 'name', name
    print 'cmdline', cmdline
    print 'ID', ID
    """

    #kernel_img = open('kernel', 'wb').write(bootimg[kernel_addr:kernel_addr+kernel_size])
    os.system('dd if=%s of=xxx bs=%d skip=1' % (boot_name, page_size))
    os.system('dd if=xxx of=kernel bs=%d count=1' % (kernel_size))

    n = (kernel_size + page_size - 1) / page_size
    os.system('dd if=%s of=xxx bs=%d skip=1' % (boot_name, ((n+1)*page_size)))
    os.system('dd if=xxx of=ramdisk.img.gz bs=%d count=1' % ramdisk_size)
    os.system('gunzip -f ramdisk.img.gz')

    if os.path.exists('root'):
        shutil.rmtree('root')
    os.mkdir('root')
    os.system('cd root; cat ../ramdisk.img | cpio -id')
    os.system('cp %s/bin/default.prop ./root' % sys.path[0])

    os.system('%s/bin/mkbootfs root | %s/bin/minigzip > ramdisk.img.gz' % (sys.path[0], sys.path[0]))
    #os.system('%s/bin/mkbootimg --kernel kernel --ramdisk ramdisk.img.gz --cmdline "mem=216M console=ttyMSM2,115200n8 androidboot.hardware=qcom" -o boot.eng.img --base 0x00200000' % sys.path[0])
    flounder_kernel_arg = 'mem=212M@0x200000 mem=256M@0x20000000 androidboot.hardware=qcom fb_addr=0xD200000'
    #os.system('%s/bin/mkbootimg --kernel kernel --ramdisk ramdisk.img.gz --cmdline "%s" -o boot.eng.img --base 0x00200000' % (sys.path[0], flounder_kernel_arg))
    os.system('%s/bin/mkbootimg --kernel kernel --ramdisk ramdisk.img.gz --cmdline "%s" -o boot.eng.img --base 0x00200000' % (sys.path[0], flounder_kernel_arg))

    os.system('rm xxx ramdisk.img.gz ramdisk.img kernel')

    # gen boot.sig
    os.system('%s/bin/digest boot.eng.img boot.eng.sig' % sys.path[0])

    print 'OK!'    

if __name__ == '__main__':
    main()
