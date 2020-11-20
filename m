Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4C22BA14C
	for <lists+linux-edac@lfdr.de>; Fri, 20 Nov 2020 04:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKTDkl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Nov 2020 22:40:41 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:46085 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgKTDkl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 Nov 2020 22:40:41 -0500
X-AuditID: 0a580157-b25ff70000003991-65-5fb7371c2264
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 2F.7E.14737.C1737BF5; Fri, 20 Nov 2020 11:25:16 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 20 Nov
 2020 11:40:33 +0800
Date:   Fri, 20 Nov 2020 11:40:32 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>, <lenb@kernel.org>
CC:     <rjw@rjwysocki.net>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <yangfeng1@kingsoft.com>, <CHENGUOMIN@kingsoft.com>
Subject: Re: [PATCH v2] Dump cper error table in mce_panic
Message-ID: <20201120114032.0978eab8.yaoaili@kingsoft.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsXCFcGooCtjvj3eYPtPQ4vPG/6xWdzft5zJ
        YufDt2wWy/f1M1pcONXAZHHm9CVWizcX7rE4sHt8b+1j8Vgzbw2jx+I9L5k8Nq3qZPPYcrWd
        xePzJrkAtigum5TUnMyy1CJ9uwSujO1bW9kK7hlXrOxsY2lgbNHqYuTkkBAwkZi8fTFrFyMX
        h5DAdCaJ+xNWsEE4Lxglju7/zwxSxSKgKrFl9WcmEJsNyN51bxYriC0iYCqxaFETE0gDs8Au
        RonF/y+AJYQFrCSebnjDAmLzAtlHZkDYnAI6EvvP/2QDsYUE7jJKvG6Q7GLk4OAXEJN41WAM
        cZG9xPO/Z5khWgUlTs58AtbKDNR6YtUxZghbXmL72znMEGMUJQ4v+cUO0askcaR7BhuEHSux
        bN4r1gmMwrOQjJqFZNQsJKMWMDKvYmQpzk033MQIiYvwHYzzmj7qHWJk4mA8xCjBwawkwrtW
        c2u8EG9KYmVValF+fFFpTmrxIUZpDhYlcd70uZvjhQTSE0tSs1NTC1KLYLJMHJxSDUwsrobd
        2w5NluSN/6rGOP9e9+7opQF6r+2rdsRHSVleT0tlj+x5UpfE6fdw8jUrrqbbWRfkDULD0zRv
        /9+ivv8289eJ5VfVJsxt/dYfoTm5RkRo0nRxfWMtu18PucyZHxefy/XfXSJqozxX74bGGiOl
        QB7OF5/elrLkrFnwU6rJSM3JM/Csy7qzv8y37J7wOvlKW/RFZW9Tv8T8XYUfvdQSok79nK7T
        41z93TNbyMJmZciapd0ixxUWqRxMSb9s73bpS86sFy/WHZC/qmX5Z/bMQw8cbxVOeH1pX7HZ
        jw3WJ7xUD3+R+NO4MiikznTpsaiMve6xZzNvS7ptWmefptP1/buVhvYSIT09nzPcZ5RYijMS
        DbWYi4oTAQxPz1b6AgAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 19 Nov 2020 18:45:08 +0100
Borislav Petkov <bp@alien8.de> wrote:

> 
> Ok, before we look any further into this, please redo the whole exercise
> with the latest upstream kernel - not some 4.18 old crap. Use the
> tip/master branch:
>
Hi, here it is:

Error injected:

[    0.000000] Linux version 5.10.0-rc4 (root@qd01-test-ec2177009236.qd01.ksyun.com) (gcc (GCC) 9.3.0, GNU ld version 2.27-43.base.el7_8.1) #3 SMP Fri Nov 20 11:22:24 CST 2020
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.10.0-rc4 root=UUID=a503562a-dafc-40eb-b4c2-6607a3497b5e ro crashkernel=2G nomodeset net.ifnames=0 biosdevname=0 rdloaddriver=mlx5_core rdloaddriver=i40e rdloaddriver=ixgbe strict-devmem=0 hugepages=8192 console=ttyS0,115200n8
qd01-test-ec2177009236 login: [  103.725568] EINJ: Error INJection is initialized.
[  103.746313] EDAC MC: Removed device 0 for skx_edac Skylake Socket#0 IMC#0: DEV 0000:2e:0a.0
[  103.764305] EDAC MC: Removed device 1 for skx_edac Skylake Socket#0 IMC#1: DEV 0000:2e:0c.0
[  103.779293] EDAC MC: Removed device 2 for skx_edac Skylake Socket#1 IMC#0: DEV 0000:ae:0a.0
[  103.794290] EDAC MC: Removed device 3 for skx_edac Skylake Socket#1 IMC#1: DEV 0000:ae:0c.0
[  106.956286] Disabling lock debugging due to kernel taint
[  106.962373] mce: [Hardware Error]: CPU 18: Machine Check Exception: 5 Bank 7: be00000001010091
[  106.962377] mce: [Hardware Error]: RIP !INEXACT! 10:<ffffffffac58472a> 
[  106.996488] {acpi_idle_do_entry+0x4a/0x60}
[  107.001057] mce: [Hardware Error]: TSC ae4b410af0b8 ADDR 314d193000 MISC 200400c008002086 
[  107.010283] mce: [Hardware Error]: PROCESSOR 0:50657 TIME 1605843017 SOCKET 1 APIC 40 microcode 5000021
[  107.020767] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
[  107.031295] mce: [Hardware Error]: Machine check: Processor context corrupt
[  107.039065] Kernel panic - not syncing: Fatal machine check

Kdump triggered:

[    0.000000] Linux version 5.10.0-rc4 (root@qd01-test-ec2177009236.qd01.ksyun.com) (gcc (GCC) 9.3.0, GNU ld version 2.27-43.base.el7_8.1) #3 SMP Fri Nov 20 11:22:24 CST 2020
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.10.0-rc4 ro nomodeset net.ifnames=0 biosdevname=0 rdloaddriver=mlx5_core rdloaddriver=i40e rdloaddriver=ixgbe strict-devmem=0 console=ttyS0,115200n8 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never nokaslr disable_cpu_apicid=0 elfcorehdr=403684744K
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

[    5.946962] io scheduler bfq registered
[    5.951261] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    5.960169] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    5.968096] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    5.976376] ACPI: Power Button [PWRF]
[    5.980794] APEI: Can not request [mem 0xa7d0e040-0xa7d0e04c] for APEI ERST registers
[    5.989550] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
[    5.990513] {1}[Hardware Error]: event severity: fatal
[    5.990513] {1}[Hardware Error]:  Error 0, type: fatal
[    5.990513] {1}[Hardware Error]:  fru_text: Card03, ChnB, DIMM0
[    5.990513] {1}[Hardware Error]:   section_type: memory error
[    5.990513] {1}[Hardware Error]:   error_status: 0x0000000000000000
[    5.990513] {1}[Hardware Error]:   physical_address: 0x000000314d193000
[    5.990513] {1}[Hardware Error]:   node: 2 card: 1 module: 0 rank: 0 bank: 3 device: 0 row: 1651 column: 128 
[    5.990513] {1}[Hardware Error]:   DIMM location: CPU 1 DIMM 8 
[    5.990513] Kernel panic - not syncing: Fatal hardware error!
[    5.990513] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G          I       5.10.0-rc4 #3
[    5.990513] Hardware name: Lenovo ThinkSystem SR650 -[7X06CTO1WW]-/-[7X06CTO1WW]-, BIOS -[IVE636Z-2.13]- 07/18/2019
[    5.990513] Call Trace:
[    5.990513]  dump_stack+0x57/0x6a
[    5.990513]  panic+0xfb/0x2d7
[    5.990513]  __ghes_panic.cold+0x21/0x21
[    5.990513]  ghes_proc+0xe0/0x140
[    5.990513]  ghes_probe+0x129/0x380
[    5.990513]  platform_drv_probe+0x35/0x80
[    5.990513]  really_probe+0x31b/0x420
[    5.990513]  driver_probe_device+0xe1/0x150
[    5.990513]  device_driver_attach+0x53/0x60
[    5.990513]  __driver_attach+0x8a/0x150
[    5.990513]  ? device_driver_attach+0x60/0x60
[    5.990513]  ? device_driver_attach+0x60/0x60
[    5.990513]  bus_for_each_dev+0x78/0xc0
[    5.990513]  bus_add_driver+0x14d/0x1f0
[    5.990513]  driver_register+0x6c/0xc0
[    5.990513]  ? bert_init+0x22a/0x22a
[    5.990513]  ghes_init+0x87/0xe5
[    5.990513]  do_one_initcall+0x44/0x1d0
[    5.990513]  kernel_init_freeable+0x1d3/0x235
[    5.990513]  ? rest_init+0xb4/0xb4
[    5.990513]  kernel_init+0xa/0x10c
[    5.990513]  ret_from_fork+0x1f/0x30
[    5.990513] Kernel Offset: disabled
[    5.990513] Rebooting in 10 seconds..
[    5.990513] ACPI MEMORY or I/O RESET_REG.
 UEFI:START PEI          
 UEFI:START PEI          
 UEFI:MEM INIT           
<F1> System Setup     <F10> PXE Boot            
<F2> Diagnostic       <F12> One Time Boot Device
 UEFI:DXE INIT           
 UEFI:DXE INIT           
                

-- 
Thanks

Best Regards!

Aili Yao
