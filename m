Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E842BA5ED
	for <lists+linux-edac@lfdr.de>; Fri, 20 Nov 2020 10:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgKTJWp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Nov 2020 04:22:45 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:46150 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgKTJWo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Nov 2020 04:22:44 -0500
X-AuditID: 0a580157-b25ff70000003991-e6-5fb78745fae1
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 4A.43.14737.54787BF5; Fri, 20 Nov 2020 17:07:17 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 20 Nov
 2020 17:22:35 +0800
Date:   Fri, 20 Nov 2020 17:22:35 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <CHENGUOMIN@kingsoft.com>, Aili Yao <yaoaili@kingsoft.com>
Subject: Re: [PATCH v2] Dump cper error table in mce_panic
Message-ID: <20201120172235.620eb826.yaoaili@kingsoft.com>
In-Reply-To: <20201119174508.GE3769@zn.tnic>
References: <20201104065057.40442-1-yaoaili126@163.com>
        <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
        <20201118124538.GI7472@zn.tnic>
        <20201119134057.37ca2c19.yaoaili@kingsoft.com>
        <20201119174508.GE3769@zn.tnic>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsXCFcGooOvavj3e4PMCRYvPG/6xWdzft5zJ
        YufDt2wWy/f1M1pcONXAZHHm9CVWizcX7rE4sHt8b+1j8Vgzbw2jx+I9L5k8Nq3qZPPYcrWd
        xePzJrkAtigum5TUnMyy1CJ9uwSujFlnfrEWPDeqeLr5MVMD4w+NLkZODgkBE4mzPxuYuhi5
        OIQEpjNJtB3qhnJeMEqsmneBHaSKRUBV4uqmxUwgNhuQveveLFYQW0RASeLrorlgDcwCHxgl
        dnXNB0sIC1hJPN3whgXE5gWyzyxqZwSxOQV0JPaf/8kGYgsJ3GWUeN0g2cXIwcEvICbxqsEY
        4iJ7ied/zzJDtApKnJz5BGwMM1DriVXHmCFseYntb+cwQ4xRlDi85Bc7RK+SxJHuGWwQdqzE
        snmvWCcwCs9CMmoWklGzkIxawMi8ipGlODfdcBMjJC7CdzDOa/qod4iRiYPxEKMEB7OSCO9a
        za3xQrwpiZVVqUX58UWlOanFhxilOViUxHnzsrbHCwmkJ5akZqemFqQWwWSZODilGpjiAhU7
        7eZMKa3Tt1HKdti12aHO7Rqv3PVVsaVZip/lfXeolJZGLrmnenync05NjK4yu6lY/B7ju2x7
        G+LliownfTVRqFSzUm3JnFOe2CCz5uDfRc8Xn+JLOTm/WHHdkiXn8v4kRL2dzL91M7vAHjN3
        69VT84q3GWdsFKir56nvE/Kd49VdY8N3Qe745U6X73yLI4wT1Jxt71seFHh1XFDYqafOznkr
        M7fPI8cJyrbZWxS4m7rNNv04ILspLuOqllzu45/BgfeSbiktCPpf+/6RywKZf+a/WK5H/v+h
        d1CLoZ6v12PPjXPOn//4aJm97Sya6mY3155h75FajVPhJrsWuzwuzD3hnJ0V+IddiaU4I9FQ
        i7moOBEAdq6v9PoCAAA=
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 19 Nov 2020 18:45:08 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Nov 19, 2020 at 01:40:57PM +0800, Aili Yao wrote:
> > [    0.000000] Linux version 4.18.0+  #37 SMP Thu Nov 19 10:38:16 CST 2020  
> 
> Ok, before we look any further into this, please redo the whole exercise
> with the latest upstream kernel - not some 4.18 old crap. Use the
> tip/master branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=master
> 
Hi, This test result if from tip/master, previous is upstream latest.

qd01-test-ec2177009236 login: 
CentOS Linux 7 (Core)
Kernel 5.10.0-rc3 on an x86_64

qd01-test-ec2177009236 login: [  103.306303] usb 1-1.6: USB disconnect, device number 4
[  103.312086] cdc_ether 1-1.6:1.0 usb0: unregister 'cdc_ether' usb-0000:00:14.0-1.6, CDC Ethernet Device
[  105.326306] usb 1-1.6: new high-speed USB device number 5 using xhci_hcd
[  105.410891] usb 1-1.6: New USB device found, idVendor=04b3, idProduct=4010, bcdDevice= 3.14
[  105.420214] usb 1-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  105.428377] usb 1-1.6: Product: XClarity Controller
[  105.433827] usb 1-1.6: Manufacturer: IBM
[  105.440362] cdc_ether 1-1.6:1.0 usb0: register 'cdc_ether' at usb-0000:00:14.0-1.6, CDC Ethernet Device, 3a:68:dd:14:51:1f
[  111.648657] EINJ: Error INJection is initialized.
[  111.666355] EDAC MC: Removed device 0 for skx_edac Skylake Socket#0 IMC#0: DEV 0000:2e:0a.0
[  111.686338] EDAC MC: Removed device 1 for skx_edac Skylake Socket#0 IMC#1: DEV 0000:2e:0c.0
[  111.701336] EDAC MC: Removed device 2 for skx_edac Skylake Socket#1 IMC#0: DEV 0000:ae:0a.0
[  111.726334] EDAC MC: Removed device 3 for skx_edac Skylake Socket#1 IMC#1: DEV 0000:ae:0c.0

[  [    0.000000] Linux version 5.10.0-rc3 (root@qd01-test-ec2177009236.qd01.ksyun.com) (gcc (GCC) 9.3.0, GNU ld version 2.27-43.base.el7_8.1) #3 SMP Fri Nov 20 16:59:03 CST 2020
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.10.0-rc3 ro nomodeset net.ifnames=0 biosdevname=0 rdloaddriver=mlx5_core rdloaddriver=i40e rdloaddriver=ixgbe strict-devmem=0 console=ttyS0,115200n8 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never nokaslr disable_cpu_apicid=0 acpi_rsdp=0xf05a0 elfcorehdr=403684744K
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
...
...
...
[    6.280390] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    6.288655] ACPI: Power Button [PWRF]
[    6.292961] ERST: Error Record Serialization Table (ERST) support is initialized.
[    6.301295] pstore: Registered erst as persistent store backend
[    6.307912] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
[    6.308886] {1}[Hardware Error]: event severity: fatal
[    6.308886] {1}[Hardware Error]:  Error 0, type: fatal
[    6.308886] {1}[Hardware Error]:  fru_text: Card03, ChnB, DIMM0
[    6.308886] {1}[Hardware Error]:   section_type: memory error
[    6.308886] {1}[Hardware Error]:   error_status: 0x0000000000000000
[    6.308886] {1}[Hardware Error]:   physical_address: 0x00000031a53f0000
[    6.308886] {1}[Hardware Error]:   node: 2 card: 1 module: 0 rank: 0 bank: 1 device: 0 row: 3541 column: 0 
[    6.308886] {1}[Hardware Error]:   DIMM location: CPU 1 DIMM 8 
[    6.308886] Kernel panic - not syncing: Fatal hardware error!
[    6.308886] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc3 #3
[    6.308886] Hardware name: Lenovo ThinkSystem SR650 -[7X06CTO1WW]-/-[7X06CTO1WW]-, BIOS -[IVE636Z-2.13]- 07/18/2019
[    6.308886] Call Trace:
[    6.308886]  dump_stack+0x57/0x6a
[    6.308886]  panic+0xfb/0x2d7
[    6.308886]  __ghes_panic.cold+0x21/0x21
[    6.308886]  ghes_proc+0xe0/0x140
[    6.308886]  ghes_probe+0x129/0x380
[    6.308886]  platform_drv_probe+0x35/0x80
[    6.308886]  really_probe+0x31b/0x420
[    6.308886]  driver_probe_device+0xe1/0x150
[    6.308886]  device_driver_attach+0x53/0x60
[    6.308886]  __driver_attach+0x8a/0x150
[    6.308886]  ? device_driver_attach+0x60/0x60
[    6.308886]  ? device_driver_attach+0x60/0x60
[    6.308886]  bus_for_each_dev+0x78/0xc0
[    6.308886]  bus_add_driver+0x14d/0x1f0
[    6.308886]  driver_register+0x6c/0xc0
[    6.308886]  ? bert_init+0x22a/0x22a
[    6.308886]  ghes_init+0x87/0xe5
[    6.308886]  do_one_initcall+0x44/0x1d0
[    6.308886]  kernel_init_freeable+0x1d3/0x235
[    6.308886]  ? rest_init+0xb4/0xb4
[    6.308886]  kernel_init+0xa/0x10c
[    6.308886]  ret_from_fork+0x1f/0x30
[    6.308886] Kernel Offset: disabled
[    6.308886] Rebooting in 10 seconds..
[    6.308886] ACPI MEMORY or I/O RESET_REG.
 UEFI:START PEI          
 UEFI:START PEI          
 UEFI:MEM INIT           
<F1> System Setup     <F10> PXE Boot            
<F2> Diagnostic       <F12> One Time Boot Device
 UEFI:DXE INIT           
 UEFI:DXE INIT           
                
ThinkSystem SR650                                   
Serial Number 
J3016250
Machine Type 
7X06
BMC IP 
10.177.134.108
UEFI Version 
2.13 IVE636Z (07/18/2019)
BMC Version    
2.70 CDI338D (06/19/2019)

-- 
Best Regards!

Aili Yao
