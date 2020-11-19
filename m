Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA52B8B11
	for <lists+linux-edac@lfdr.de>; Thu, 19 Nov 2020 06:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgKSFlG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Nov 2020 00:41:06 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:45828 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSFlG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 Nov 2020 00:41:06 -0500
X-AuditID: 0a580155-613ff7000003c60c-e5-5fb6016a8757
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 86.26.50700.A6106BF5; Thu, 19 Nov 2020 13:23:54 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 19 Nov
 2020 13:40:57 +0800
Date:   Thu, 19 Nov 2020 13:40:57 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <CHENGUOMIN@kingsoft.com>
Subject: Re: [PATCH v2] Dump cper error table in mce_panic
Message-ID: <20201119134057.37ca2c19.yaoaili@kingsoft.com>
In-Reply-To: <20201118124538.GI7472@zn.tnic>
References: <20201104065057.40442-1-yaoaili126@163.com>
        <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
        <20201118124538.GI7472@zn.tnic>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXCFcGooJvFuC3e4NQTcYvPG/6xWdzft5zJ
        YufDt2wWy/f1M1pcONXAZHHm9CVWizcX7rE4sHt8b+1j8Vgzbw2jx+I9L5k8Nq3qZPPYcrWd
        xePzJrkAtigum5TUnMyy1CJ9uwSujFOzzAs+BlScWnCAvYHxumMXIyeHhICJxM0NzSxdjFwc
        QgLTmSQ65y5khnBeMEo8XDyNBaSKRUBVYtu0J+wgNhuQveveLFYQW0RASeLrorlMIDazwHlG
        id17akFsYQEriacb3oD18gLZZ58+A+vlFNCROLx4NtS2LkaJpmXvgRwODn4BMYlXDcYQF9lL
        PP97lhmiV1Di5MwnLBDzdSROrDrGDGHLS2x/OwfMFhJQlDi85Bc7RK+SxJHuGWwQdqzEsnmv
        WCcwCs9CMmoWklGzkIxawMi8ipGlODfdaBMjJCpCdzDOaPqod4iRiYPxEKMEB7OSCO9aza3x
        QrwpiZVVqUX58UWlOanFhxilOViUxHlF5m6OFxJITyxJzU5NLUgtgskycXBKNTDpnEptu8zw
        MnS6IdfklPB3E/2nMk8XqucTnsZcspev7OP3d805JeLVT6pYk6Js5C6um7RoOd9RA8NV+tfC
        n11K8LcM2vJd9N1uznW2vBLFqxettRLR1r52+mWUwPPzLCdjfFwcp712+X1S8utf7lWX1f3k
        T07e9Sa75uW7+AZv21tLv5wIYXqjfiP+WdXV7KRbF9T4/FreucjH/tR88uFz++eX0ZK3/4dP
        FnykmcU0YYPo3o6kP67KLvu3umVVs2xSKLb4l61gfEtxfxWfTd1i1TmWrLbuynmtInMNxSze
        v/qZOn/7Ets7U1liJi7YGnj5ycfjHsVvk5Nspv/52Pkjeup00fs32N7IhRxo8fyixFKckWio
        xVxUnAgAxcRhbPkCAAA=
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi, Thanks for your reply! 

On Wed, 18 Nov 2020 13:45:38 +0100
Borislav Petkov <bp@alien8.de> wrote:

> 
> Problem is A.
> 

1.There are a lot of Memory UE crash cases on production enviroment, but there is no vmcore-dmesg.txt collected. 
Only log we got is SEL log, We don't know what is happenning in kernel.

2.Then I tested this using EINJ module, I injected a Fatal memory error, checked the console log followed: 

Error injected:

[  140.833351] EINJ: Error INJection is initialized.
[  140.852107] EDAC MC: Removed device 0 for skx_edac Skylake Socket#0 IMC#0: DEV 0000:2e:0a.0
[  140.867095] EDAC MC: Removed device 1 for skx_edac Skylake Socket#0 IMC#1: DEV 0000:2e:0c.0
[  140.885091] EDAC MC: Removed device 2 for skx_edac Skylake Socket#1 IMC#0: DEV 0000:ae:0a.0
[  140.900096] EDAC MC: Removed device 3 for skx_edac Skylake Socket#1 IMC#1: DEV 0000:ae:0c.0
[  144.092321] Disabling lock debugging due to kernel taint
[  144.098423] core: [Hardware Error]: CPU 18: Machine Check Exception: 5 Bank 7: be00000001010090
[  144.108138] core: [Hardware Error]: RIP !INEXACT! 10:<ffffffffa16506be> {native_safe_halt+0xe/0x10}
[  144.118239] core: [Hardware Error]: TSC a806dc0f34 ADDR 5c7a4df000 MISC 200000c020002086 
[  144.127366] core: [Hardware Error]: PROCESSOR 0:50657 TIME 1605754444 SOCKET 1 APIC 40 microcode 5000021
[  144.137946] core: [Hardware Error]: Run the above through 'mcelog --ascii'
[  144.148275] core: [Hardware Error]: Machine check: Processor context corrupt
[  144.156140] Kernel panic - not syncing: Fatal machine check

Kdump triggered:

[    0.000000] Linux version 4.18.0+  #37 SMP Thu Nov 19 10:38:16 CST 2020
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.18.0+ ro nomodeset net.ifnames=0 biosdevname=0 rdloaddriver=mlx5_core rdloaddriver=i40e rdloaddriver=ixgbe strict-devmem=0 console=ttyS0,115200n8 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never nokaslr disable_cpu_apicid=0 elfcorehdr=403684744K
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
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009afff] usable
[    0.000000] BIOS-e820: [mem 0x0000000095000000-0x00000000a4ffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000a5a74000-0x00000000a5f3ffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000a5f40000-0x00000000a6b56fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000005fbf000000-0x000000603ef61fff] usable
...
...
...
[    2.597514] ACPI: Power Button [PWRF]
[    2.601782] APEI: Can not request [mem 0xa7d0e040-0xa7d0e04c] for APEI ERST registers
[    2.610529] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
[    2.611493] {1}[Hardware Error]: event severity: fatal
[    2.611493] {1}[Hardware Error]:  Error 0, type: fatal
[    2.611493] {1}[Hardware Error]:  fru_text: Card03, ChnA, DIMM0
[    2.611493] {1}[Hardware Error]:   section_type: memory error
[    2.611493] {1}[Hardware Error]:   error_status: 0x0000000000000000
[    2.611493] {1}[Hardware Error]:   physical_address: 0x0000005c7a4df000
[    2.611493] {1}[Hardware Error]:   node: 2 card: 0 module: 0 rank: 1 bank: 1 device: 0 row: 57217 column: 976 
[    2.611493] {1}[Hardware Error]:   DIMM location: CPU 1 DIMM 8 
[    2.611493] Kernel panic - not syncing: Fatal hardware error!
[    2.611493] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0+ #37
[    2.611493] Hardware name: Lenovo ThinkSystem SR650, BIOS -[IVE636Z-2.13]- 07/18/2019
[    2.611493] Call Trace:
[    2.611493]  dump_stack+0x5c/0x80
[    2.611493]  panic+0xe7/0x2a9
[    2.611493]  __ghes_panic.cold+0x21/0x21
[    2.611493]  ? ghes_proc+0xfd/0x120
[    2.611493]  ? ghes_probe+0x129/0x3b0
[    2.611493]  ? platform_drv_probe+0x38/0x90
[    2.611493]  ? really_probe+0xf9/0x3a0
[    2.611493]  ? driver_probe_device+0x4b/0xc0
[    2.611493]  ? device_driver_attach+0x55/0x60
[    2.611493]  ? __driver_attach+0x62/0x140
[    2.611493]  ? device_driver_attach+0x60/0x60
[    2.611493]  ? bus_for_each_dev+0x78/0xc0
[    2.611493]  ? bus_add_driver+0x14d/0x1f0
[    2.611493]  ? driver_register+0x6c/0xb0
[    2.611493]  ? bert_init+0x220/0x220
[    2.611493]  ? ghes_init+0x88/0xe6
[    2.611493]  ? do_one_initcall+0x46/0x1c4
[    2.611493]  ? kernel_init_freeable+0x334/0x3ca
[    2.611493]  ? rest_init+0xaa/0xaa
[    2.611493]  ? kernel_init+0xa/0xf7
[    2.611493]  ? ret_from_fork+0x1f/0x40
[    2.611493] Kernel Offset: disabled
[    2.611493] Rebooting in 10 seconds..
[    2.611493] ACPI MEMORY or I/O RESET_REG.
 UEFI:START PEI          
 UEFI:START PEI          
 UEFI:MEM INIT           
<F1> System Setup     <F10> PXE Boot            
<F2> Diagnostic       <F12> One Time Boot Device
 UEFI:DXE INIT           

> It happens because of B.
> 
It happens because of: 
1. BIOS Option WHEA Memory Log Enabled, BIOS will provide a CPER error record with Panic severity for fatal memory UE
2. A fatal memory error happens.
3. This record is not processed in first kernel, mce handler do panic action.
4. Second kernel is started and the record is processed, panic.
5. vmcore and vmcore-dmesg.txt is not collected.

> Fix it by doing C.
> 
1. In the mce_panic(), dump the cper error records, ack and clear the related cper record.
   The cper record will not be leaked to second kernel. Then the kdump will work right.
   still the cper log is collected in vmcore-dmesg.txt.

> (Potentially do D).
1. Don't do panic in ghes module for Fatal Memory UE in x86 Platform when EMCA enabled.
When Fatal Memory UE is in process, the NMI watchdog may be triggered, then the ghes_notify_nmi() will be called. For x86 Platform
We don't know the source of NMI, we have no idea about this NMI is just for watchdog or other reason.
if ghes_notify_nmi() find the cper record with panic severity, then do panic.
This is not supposed to so.
2. In some senario, the un-expected NMI process will preempt the MCE, like following:
The NMI totally preempt MCE, we can collect vmcore-dmesg.txt this time,
But we have lost the mcelog in vmcore-dmesg.txt and erst pstore.

[  995.167270] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
[  995.167271] {1}[Hardware Error]: event severity: fatal
[  995.167271] {1}[Hardware Error]:  Error 0, type: fatal
[  995.167271] {1}[Hardware Error]:  fru_text: Card03, ChnA, DIMM0
[  995.167272] {1}[Hardware Error]:   section_type: memory error
[  995.167272] {1}[Hardware Error]:   error_status: 0x0000000000000000
[  995.167272] {1}[Hardware Error]:   physical_address: 0x00000046fe735000
[  995.167273] {1}[Hardware Error]:   node: 2 card: 0 module: 0 rank: 0 bank: 1 device: 0 row: 62761 column: 208
[  995.167273] {1}[Hardware Error]:   DIMM location: CPU 1 DIMM 4
[  995.167274] Kernel panic - not syncing: Fatal hardware error!
[  995.167274] CPU: 47 PID: 0 Comm: swapper/47 Kdump: loaded Not tainted 4.18.0+ #20
[  995.167274] Hardware name: Lenovo ThinkSystem SR650 -[7X06CTO1WW]-/-[7X06CTO1WW]-, BIOS -[IVE636Z-2.13]- 07/18/2019
[  995.167275] Call Trace:
[  995.167275]  <NMI>
[  995.167275]  dump_stack+0x5a/0x73
[  995.167275]  panic+0xe8/0x2bc
[  995.167276]  __ghes_panic+0x68/0x6a
[  995.167276]  ghes_notify_nmi+0x23b/0x290
[  995.167276]  nmi_handle+0x69/0x110
[  995.167276]  default_do_nmi+0x3e/0x110
[  995.167277]  do_nmi+0x116/0x190
[  995.167277]  end_repeat_nmi+0x16/0x6a
[  995.167277] RIP: 0010:machine_check+0x0/0x40
[  995.167278] Code: 00 00 48 89 e7 48 8b 74 24 78 48 c7 44 24 78 ff ff ff ff e8 b2 0e 66 ff e9 ed 02 00 00 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 <0f> 01 ca 6a ff f6 44 24 10 03 75 14 e8 2f 00 00 00 48 89 e7 31 f6
[  995.167278] RSP: 0018:fffffe00007effd8 EFLAGS: 00000046
[  995.167279] RAX: ffffffff97eac2c0 RBX: ffff8f8cc0ce5c40 RCX: 7fffff18a792c0bf
[  995.167279] RDX: 0000000000000001 RSI: 000000000000002f RDI: ffff8fa39fd5d600
[  995.167280] RBP: 000000000000002f R08: 0000000000000008 R09: ffffffdb56bbc181
[  995.167280] R10: 000000000000002f R11: 0000000000000000 R12: 0000000000000000
[  995.167280] R13: 0000000000000000 R14: ffff8f8cc0ce5c40 R15: ffff8f8cc0ce5c40
[  995.167280]  ? __sched_text_end+0x4/0x4
[  995.167281]  ? async_page_fault+0x30/0x30
[  995.167281]  ? async_page_fault+0x30/0x30
[  995.167281]  </NMI>
[  995.167281]  <#MC>
[  995.167282] RIP: 0010:native_safe_halt+0xe/0x10
[  995.167282] Code: ff ff eb bc 90 90 90 90 90 90 90 90 e9 07 00 00 00 0f 00 2d 76 c8 55 00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 66 c8 55 00 fb f4 <c3> 90 0f 1f 44 00 00 41 54 55 53 e8 e2 29 88 ff 65 8b 2d d3 2a 16
[  995.167283] RSP: 0018:ffffa2e4cca47ea0 EFLAGS: 00000246 </#MC>
[  995.167283]  default_idle+0x1a/0x130
[  995.167283]  do_idle+0x1a6/0x290
[  995.167283]  cpu_startup_entry+0x6f/0x80
[  995.167284]  start_secondary+0x1aa/0x200
[  995.167284]  secondary_startup_64+0xb7/0xc0

-- 
Best Regards!

Aili Yao
