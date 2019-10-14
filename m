Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81554D6606
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfJNPTA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 11:19:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56324 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733207AbfJNPS7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 11:18:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D111B845B18E5CFF5BA;
        Mon, 14 Oct 2019 23:18:55 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 23:18:54 +0800
From:   John Garry <john.garry@huawei.com>
Subject: edac KASAN warning in experimental arm64 allmodconfig boot
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
Date:   Mon, 14 Oct 2019 16:18:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi guys,

I'm experimenting by trying to boot an allmodconfig arm64 kernel, as 
mentioned here:
https://lore.kernel.org/linux-arm-kernel/507325a3-030e-2843-0f46-7e18c60257de@huawei.com/

One thing that I noticed - it's hard to miss actually - is the amount of 
complaining from KASAN about the EDAC/ghes code. Maybe this is something 
I should not care about/red herring, or maybe something genuine. Let me 
know what you think.

The kernel is v5.4-rc3, and I raised the EDAC mc debug level to get 
extra debug prints.

Log below, Thanks,
John

Log snippet (I cut off after the first KASAN warning):

[   70.471011][    T1] random: get_random_u32 called from 
new_slab+0x360/0x698 with crng_init=0
[   70.478671][    T1] [Firmware Bug]: APEI: Invalid bit width + offset 
in GAR [0x94110034/64/0/3/0]
[   70.526585][    T1] EDAC DEBUG: edac_mc_alloc: allocating 3524 bytes 
for mci data (32 dimms, 32 csrows/channels)
[   70.542013][    T1] EDAC DEBUG: ghes_edac_dmidecode: DIMM2: 
Registered-DDR4 size = 16384 MB(ECC)
[   70.551044][    T1] EDAC DEBUG: ghes_edac_dmidecode:         type 26, 
detail 0x2080, width 72(total 64)
[   70.559986][    T1] EDAC DEBUG: edac_mc_add_mc_with_groups:
[   70.567082][    T1] EDAC DEBUG: edac_create_sysfs_mci_device: device 
mc0 created
[   70.575608][    T1] EDAC DEBUG: edac_create_dimm_object: device dimm2 
created at location memory 2
[   70.585818][    T1] EDAC DEBUG: edac_create_csrow_object: device 
csrow2 created
[   70.594110][    T1] EDAC MC0: Giving out device to module ghes_edac.c 
controller ghes_edac: DEV ghes (INTERRUPT)
[   70.605936][    T1] EDAC DEBUG: edac_mc_del_mc:
[   70.611188][    T1] EDAC DEBUG: edac_remove_sysfs_mci_device:
[   70.619443][    T1] random: get_random_u32 called from 
kobject_put+0x8c/0x190 with crng_init=0
[   70.628163][    T1] kobject: 'csrow2' ((____ptrval____)): 
kobject_release, parent (____ptrval____) (delayed 750)
[   70.638477][    T1] EDAC DEBUG: edac_remove_sysfs_mci_device: 
unregistering device dimm2
[   70.647903][    T1] kobject: 'dimm2' ((____ptrval____)): 
kobject_release, parent (____ptrval____) (delayed 250)
[   70.658105][    T1] EDAC MC: Removed device 0 for ghes_edac.c 
ghes_edac: DEV ghes
[   70.665673][    T1] EDAC DEBUG: edac_mc_free:
[   70.670211][    T1] EDAC DEBUG: edac_unregister_sysfs: unregistering 
device mc0
[   70.679027][    T1] kobject: 'mc0' ((____ptrval____)): 
kobject_release, parent (____ptrval____) (delayed 500)
[   70.690987][    T1] EDAC DEBUG: edac_mc_del_mc:
[   70.695769][    T1] EDAC DEBUG: edac_mc_free:
[   70.700412][    T1] ------------[ cut here ]------------
[   70.705832][    T1] ODEBUG: free active (active state 0) object type: 
timer_list hint: delayed_work_timer_fn+0x0/0x48
[   70.716663][    T1] WARNING: CPU: 50 PID: 1 at lib/debugobjects.c:484 
debug_print_object+0xec/0x130
[   70.725721][    T1] Modules linked in:
[   70.729491][    T1] CPU: 50 PID: 1 Comm: swapper/0 Not tainted 
5.4.0-rc3+ #1146
[   70.736811][    T1] Hardware name: Huawei D06 /D06, BIOS Hisilicon 
D06 UEFI RC0 - V1.16.01 03/15/2019
[   70.746039][    T1] pstate: 80800009 (Nzcv daif -PAN +UAO)
[   70.746056][    T1] pc : debug_print_object+0xec/0x130
[   70.756681][    T1] lr : debug_print_object+0xec/0x130
[   70.756691][    T1] sp : ffff0020bf2c7740
[   70.756699][    T1] x29: ffff0020bf2c7740 x28: ffff0023242c5000
[   70.756715][    T1] x27: ffff0023242c5090 x26: ffffa00017543de0
[   70.756730][    T1] x25: ffffa000101cd558 x24: ffffa00012051fc0
[   70.756750][    T1] x23: ffffa000150d2200 x22: ffffa000120523a0
[   70.765894][    T1] x21: ffffa00012051640 x20: 0000000000000000
[   70.765910][    T1] x19: ffffa00015019000 x18: 00000000000025a8
[   70.765924][    T1] x17: 00000000000025a0 x16: 00000000000026b0
[   70.765939][    T1] x15: 0000000000001470 x14: 64203a746e696820
[   70.765954][    T1] x13: 7473696c5f72656d x12: 1fffe00417e58e5a
[   70.777974][    T1] x11: ffff800417e58e5a x10: dfffa00000000000
[   70.789995][    T1] x9 : ffff800417e58e5b x8 : 0000000000000001
[   70.790011][    T1] x7 : ffff0020bf2c72d7 x6 : ffff800417e58e5b
[   70.790026][    T1] x5 : 1fffe00417e57936 x4 : ffff0020bf2bc058
[   70.790041][    T1] x3 : ffffa00010000000 x2 : ffff800417e58eb0
[   70.790055][    T1] x1 : f8aafc30f531b000 x0 : 0000000000000000
[   70.802080][    T1] Call trace:
[   70.802093][    T1]  debug_print_object+0xec/0x130
[   70.802106][    T1]  __debug_check_no_obj_freed+0x114/0x290
[   70.802119][    T1]  debug_check_no_obj_freed+0x18/0x28
[   70.802130][    T1]  slab_free_freelist_hook+0x18c/0x228
[   70.802140][    T1]  kfree+0x264/0x420
[   70.802157][    T1]  _edac_mc_free+0x6c/0x210
[   70.814163][    T1]  edac_mc_free+0x68/0x88
[   70.814177][    T1]  ghes_edac_unregister+0x44/0x70
[   70.814193][    T1]  ghes_remove+0x274/0x2a0
[   70.814207][    T1]  platform_drv_remove+0x44/0x78
[   70.814217][    T1]  really_probe+0x404/0x840
[   70.814228][    T1]  driver_probe_device+0x190/0x1f0
[   70.814239][    T1]  device_driver_attach+0x7c/0xb0
[   70.814249][    T1]  __driver_attach+0x1b8/0x1d0
[   70.814261][    T1]  bus_for_each_dev+0xf8/0x190
[   70.814277][    T1]  driver_attach+0x34/0x40
[   70.826289][    T1]  bus_add_driver+0x1d8/0x340
[   70.826301][    T1]  driver_register+0x168/0x1e8
[   70.826312][    T1]  __platform_driver_register+0x80/0x90
[   70.826326][    T1]  ghes_init+0xc4/0x174
[   70.826338][    T1]  do_one_initcall+0x328/0x788
[   70.826356][    T1]  kernel_init_freeable+0x2fc/0x3d4
[   70.838361][    T1]  kernel_init+0x18/0x178
[   70.838373][    T1]  ret_from_fork+0x10/0x18
[   70.838381][    T1] irq event stamp: 4398006
[   70.838394][    T1] hardirqs last  enabled at (4398005): 
[<ffffa000100c0e78>] el1_irq+0x138/0x200
[   70.838409][    T1] hardirqs last disabled at (4398006): 
[<ffffa000100fd884>] debug_exception_enter+0x8c/0x190
[   70.838422][    T1] softirqs last  enabled at (4398004): 
[<ffffa000100bf4a4>] __do_softirq+0x894/0x920
[   70.838439][    T1] softirqs last disabled at (4397997): 
[<ffffa000101965e4>] irq_exit+0x114/0x1a0
[   70.875171][    T1] ---[ end trace a9b7b2cbbb0f7263 ]---
[   70.885805][    T1] ------------[ cut here ]------------
[   70.892929][    T1] ODEBUG: free active (active state 0) object type: 
timer_list hint: delayed_work_timer_fn+0x0/0x48
[   70.907197][    T1] WARNING: CPU: 50 PID: 1 at lib/debugobjects.c:484 
debug_print_object+0xec/0x130
[   70.916349][    T1] Modules linked in:
[   70.916368][    T1] CPU: 50 PID: 1 Comm: swapper/0 Tainted: G 
W         5.4.0-rc3+ #1146
[   70.916378][    T1] Hardware name: Huawei D06 /D06, BIOS Hisilicon 
D06 UEFI RC0 - V1.16.01 03/15/2019
[   70.916388][    T1] pstate: 80800009 (Nzcv daif -PAN +UAO)
[   70.916400][    T1] pc : debug_print_object+0xec/0x130
[   70.916412][    T1] lr : debug_print_object+0xec/0x130
[   70.916424][    T1] sp : ffff0020bf2c7740
[   70.925916][    T1] x29: ffff0020bf2c7740 x28: ffff00232427a000
[   70.925933][    T1] x27: ffff00232427a090 x26: ffffa00017543de0
[   70.925948][    T1] x25: ffffa000101cd558 x24: ffffa00012051fc0
[   70.925963][    T1] x23: ffffa000150d2200 x22: ffffa000120523a0
[   70.971505][    T1] x21: ffffa00012051640 x20: 0000000000000000
[   70.984654][    T1] x19: ffffa00015019000 x18: 00000000000025a8
[   70.984671][    T1] x17: 00000000000025a0 x16: 00000000000026b0
[   70.984685][    T1] x15: 0000000000001470 x14: 726f775f64657961
[   70.984701][    T1] x13: 6c6564203a746e69 x12: 1fffe00417e58e5a
[   71.004012][    T1] x11: ffff800417e58e5a x10: dfffa00000000000
[   71.004028][    T1] x9 : ffff800417e58e5b x8 : 0000000000000001
[   71.004043][    T1] x7 : ffff0020bf2c72d7 x6 : ffff800417e58e5b
[   71.004058][    T1] x5 : 1fffe00417e57936 x4 : ffff0020bf2bc058
[   71.034246][    T1] x3 : ffffa00010000000 x2 : ffff800417e58eb0
[   71.047049][    T1] x1 : f8aafc30f531b000 x0 : 0000000000000000
[   71.047065][    T1] Call trace:
[   71.047078][    T1]  debug_print_object+0xec/0x130
[   71.047090][    T1]  __debug_check_no_obj_freed+0x114/0x290
[   71.047103][    T1]  debug_check_no_obj_freed+0x18/0x28
[   71.047114][    T1]  slab_free_freelist_h    T1]  edac_mc_free+0x68/0x88
[   71.065065][    T1]  ghes_edac_unregister+0x44/0x70
[   71.065077][    T1]  ghes_remove+0x274/0x2a0
[   71.065088][    T1]  platform_drv_remove+0x44/0x78
[   71.065099][    T1]  really_probe+0x404/0x840
[   71.065112][    T1]  driver_probe_device+0x190/0x1f0
[   71.132887][    T1]  device_driver_attach+0x7c/0xb0
[   71.132898][    T1]  __driver_attach+0x1b8/0x1d0
[   71.132911][    T1]  bus_for_each_dev+0xf8/0x190
[   71.132921][    T1]  driver_attach+0x34/0x40
[   71.132931][    T1]  bus_add_driver+0x1d8/0x340
[   71.132942][    T1]  driver_register+0x168/0x1e8
[   71.132953][    T1]  __platform_driver_register+0x80/0x90
[   71.132964][    T1]  ghes_init+0xc4/0x174
[   71.132975][    T1]  do_one_initcall+0x328/0x788
[   71.132989][    T1]  kernel_init_freeable+0x2fc/0x3d4
[   71.144995][    T1]  kernel_init+0x18/0x178
[   71.145006][    T1]  ret_from_fork+0x10/0x18
[   71.145015][    T1] irq event stamp: 4398362
[   71.145027][    T1] hardirqs last  enabled at (4398361): 
[<ffffa000100c0e78>] el1_irq+0x138/0x200
[   71.145042][    T1] hardirqs last disabled at (4398362): 
[<ffffa000100fd884>] debug_exception_enter+0x8c/0x190
[   71.145056][    T1] softirqs last  enabled at (4398360): 
[<irq_exit+0x114/0x1a0
[   71.157069][    T1] ---[ end trace a9b7b2cbbb0f7264 ]---
[   71.158439][    T1] ------------[ cut here ]------------
[   71.194319][    T1] ODEBUG: free active (active state 0) object type: 
timer_list hint: delayed_work_timer_fn+0x0/0x48
[   71.203588][    T1] WARNING: CPU: 50 PID: 1 at lib/debugobjects.c:484 
debug_print_object+0xec/0x130
[   71.212094][    T1] Modules linked in:
[   71.212112][    T1] CPU: 50 PID: 1 Comm: swapper/0 Tainted: G 
W         5.4.0-rc3+ #1146
[   71.212121][    T1] Hardware name: Huawei D06 /D06, BIOS Hisilicon 
D06 UEFI RC0 - V1.16.01 03/15/2019
[   71.212131][    T1] pstate: 80800009 (Nzcv daif -PAN +UAO)
[   71.212144][    T1] pc : debug_print_object+0xec/0x130
[   71.212158][    T1] lr : debug_print_object+0xec/0x130
[   71.224447][  T830] kobject: 'brcm-gisb-arb' ((____ptrval____)): 
kobject_cleanup, parent (____ptrval____)
[   71.226086][    T1] sp : ffff0020bf2c7740
[   71.226099][    T1] x29: ffff0020bf2c7740 x28: ffff002324274000
[   71.230557][  T830] kobject: 'brcm-gisb-arb' ((____ptrval____)): auto 
cleanup 'remove' event
[   71.235419][    T1] x27: ffff002324274090 x26: ffffa00017543de0
[   71.235435][    T1] x25: ffffa000101cd558 x24: ffffa00012051fc0
[   71.235450][    T1] x23: ffffa000150d2200 x22: ffffa000120523a0
[   71.235465][    T1] x21: ffffa00012051640 x20: 0000000000000000
[   71.240402][  T830] kobject: 'brcm-gisb-arb' ((____ptrval____)): 
kobject_uevent_env
[   71.244968][    T1] x19: ffffa00015019000 x18: 00000000000025a8
[   71.244984][    T1] x17: 00000000000025a0 x16: 00000000000026b0
[   71.244999][    T1] x15: 0000000000001470 x14: 726f775f64657961
[   71.245014][    T1] x13: 6c6564203a746e69 x12: 1fffe00417e58e5a
[   71.249837][  T830] kobject: 'brcm-gisb-arb' ((____ptrval____)): 
fill_kobj_path: path = '/bus/platform/drivers/brcm-gisb-arb'
[   71.253908][    T1] x11: ffff800417e58e5a x10: dfffa00000000000
[   71.253925][    T1] x9 : ffff800417e58e5b x8 : 0000000000000001
[   71.253939][    T1] x7 : ffff0020bf2c72d7 x6 : ffff800417e58e5b
[   71.253954][    T1] x5 : 1fffe00417e57936 x4 : ffff0020bf2bc058
[   71.256447][  T832] kobject: 'wakeup40' ((____ptrval____)): 
kobject_cleanup, parent (____ptrval____)
[   71.256466][  T832] kobject: 'wakeup40' ((____ptrval____)): calling 
ktype release
[   71.256516][  T832] kobject: 'wakeup40': free name
[   71.258600][  T830] kobject: 'brcm-gisb-arb' ((____ptrval____)): auto 
cleanup kobject_del
[   71.263109][    T1] x3 : ffffa00010000000 x2 : ffff800417e58eb0
[   71.263125][    T1] x1 : f8aafc30f531b000 x0 : 0000000000000000
[   71.263139][    T1] Call trace:
[   71.263152][    T1]  debug_print_object+0xec/0x130
[   71.263169][    T1]  __debug_check_no_obj_freed+0x114/0x290
[   71.268667][  T830] kobject: 'brcm-gisb-arb' ((____ptrval____)): 
calling ktype release
[   71.272574][    T1]  debug_check_no_obj_freed+0x18/0x28
[   71.272586][    T1]  slab_free_freelist_hook+0x18c/0x228
[   71.272596][    T1]  kfree+0x264/0x420
[   71.272608][    T1]  _edac_mc_free+0x1f8/0x210
[   71.272619][    T1]  edac_mc_free+0x68/0x88
[   71.272632][    T1]  ghes_edac_unregister+0x44/0x70
[   71.277292][  T830] driver: 'brcm-gisb-arb': driver_release
[   71.282298][    T1]  ghes_remove+0x274/0x2a0
[   71.282310][    T1]  platform_drv_remove+0x44/0x78
[   71.282321][    T1]  really_probe+0x404/0x840
[   71.282331][    T1]  driver_probe_device+0x190/0x1f0
[   71.282342][    T1]  device_driver_attach+0x7c/0xb0
[   71.282352][    T1]  __driver_attach+0x1b8/0x1d0
[   71.282368][    T1]  bus_for_each_dev+0xf8/0x190
[   71.286608][  T830] kobject: 'brcm-gisb-arb': free name
[   71.290816][    T1]  driver_attach+0x34/0x40
[   71.290826][    T1]  bus_add_driver+0x1d8/0x340
[   71.290838][    T1]  driver_register+0x168/0x1e8
[   71.290849][    T1]  __platform_driver_register+0x80/0x90
[   71.290859][    T1]  ghes_init+0xc4/0x174
[   71.290872][    T1]  do_one_initcall+0x328/0x788
[   71.320457][  T833] kobject: 'wakeup' ((____ptrval____)): 
kobject_cleanup, parent (____ptrval____)
[   71.323307][    T1]  kernel_init_freeable+0x2fc/0x3d4
[   71.323324][    T1]  kernel_init+0x18/0x178
[   71.332431][  T833] kobject: 'wakeup' ((____ptrval____)): calling 
ktype release
[   71.337592][    T1]  ret_from_fork+0x10/0x18
[   71.337601][    T1] irq event stamp: 4399038
[   71.337613][    T1] hardirqs last  enabled at (4399037): 
[<ffffa000100c0e78>] el1_irq+0x138/0x200
[   71.337627][    T1] hardirqs last disabled at (4399038): 
[<ffffa000100fd884>] debug_exception_enter+0x8c/0x190
[   71.337640][    T1] softirqs last  enabled at (4399036): 
[<ffffa000100bf4a4>] __do_softirq+0x894/0x920
[   71.337655][    T1] softirqs last disabled at (4399029): 
[<ffffa000101965e4>] irq_exit+0x114/0x1a0
[   71.343025][  T833] kobject: 'wakeup': free name
[   71.352445][  T834] kobject: 'stmpe-pwm' ((____ptrval____)): 
kobject_cleanup, parent (____ptrval____)
[   71.352463][  T834] kobject: 'stmpe-pwm' ((____ptrval____)): auto 
cleanup 'remove' event
[   71.352481][  T834] kobject: 'stmpe-pwm' ((____ptrval____)): 
kobject_uevent_env
[   71.352587][  T834] kobject: 'stmpe-pwm' ((____ptrval____)): 
fill_kobj_path: path = '/bus/platform/drivers/stmpe-pwm'
[   71.352645][  T834] kobject: 'stmpe-pwm' ((____ptrval____)): auto 
cleanup kobject_del
[   71.352713][  T834] kobject: 'stmpe-pwm' ((____ptrval____)): calling 
ktype release
[   71.352730][  T834] driver: 'stmpe-pwm': driver_release
[   71.352763][  T834] kobject: 'stmpe-pwm': free name
[   71.353566][    T1] ---[ end trace a9b7b2cbbb0f7265 ]---
[   71.353899][    T1] GHES GHES.1: no default pinctrl state
[   71.384529][  T851] kobject: 'wakeup15' ((____ptrval____)): 
kobject_cleanup, parent (____ptrval____)
[   71.384654][  T848] kobject: 'wakeup' ((____ptrval____)): 
kobject_cleanup, parent (____ptrval____)
[   71.386131][    T1] driver: 'GHES': driver_bound: bound to device 
'GHES.1'
[   71.386163][    T1] kobject: 'GHES.1' ((____ptrval____)): 
kobject_uevent_env
[   71.386272][    T1] kobject: 'GHES.1' ((____ptrval____)): 
fill_kobj_path: path = '/devices/platform/GHES.1'
[   71.386334][    T1] bus: 'platform': really_probe: bound device 
GHES.1 to driver GHES
[   71.386378][    T1] bus: 'platform': driver_probe_device: matched 
device GHES.2 with driver GHES
[   71.386410][    T1] bus: 'platform': really_probe: probing driver 
GHES with device GHES.2
[   71.386512][    T1] GHES GHES.2: no default pinctrl state
[   71.390169][  T851] kobject: 'wakeup15' ((____ptrval____)): calling 
ktype release
[   71.395406][  T848] kobject: 'wakeup' ((____ptrval____)): calling 
ktype release
[   71.395681][    T1] 
==================================================================
[   71.395716][    T1] BUG: KASAN: use-after-free in 
ghes_edac_unregister+0x28/0x70
[   71.395728][    T1] Read of size 8 at addr ffff002324274bdc by task 
swapper/0/1
[   71.395735][    T1]
[   71.395749][    T1] CPU: 48 PID: 1 Comm: swapper/0 Tainted: G 
W         5.4.0-rc3+ #1146
[   71.395759][    T1] Hardware name: Huawei D06 /D06, BIOS Hisilicon 
D06 UEFI RC0 - V1.16.01 03/15/2019
[   71.395768][    T1] Call trace:
[   71.395780][    T1]  dump_backtrace+0x0/0x298
[   71.395790][    T1]  show_stack+0x20/0x30
[   71.395802][    T1]  dump_stack+0x190/0x21c
[   71.395815][    T1]  print_address_description.isra.6+0x80/0x3d0
[   71.395827][    T1]  __kasan_report+0x174/0x23c
[   71.395838][    T1]  kasan_report+0xc/0x18
[   71.395849][    T1]  __asan_load8+0xa4/0xb0
[   71.395861][    T1]  ghes_edac_unregister+0x28/0x70
[   71.395873][    T1]  ghes_remove+0x274/0x2a0
[   71.395884][    T1]  platform_drv_remove+0x44/0x78
[   71.395895][    T1]  really_probe+0x404/0x840
[   71.395905][    T1]  driver_probe_device+0x190/0x1f0
[   71.395916][    T1]  device_driver_attach+0x7c/0xb0
[   71.395927][    T1]  __driver_attach+0x1b8/0x1d0
[   71.395939][    T1]  bus_for_each_dev+0xf8/0x190
[   71.395949][    T1]  driver_attach+0x34/0x40
[   71.395960][    T1]  bus_add_driver+0x1d8/0x340
[   71.395970][    T1]  driver_register+0x168/0x1e8
[   71.395982][    T1]  __platform_driver_register+0x80/0x90
[   71.395993][    T1]  ghes_init+0xc4/0x174
[   71.396004][    T1]  do_one_initcall+0x328/0x788
[   71.396017][    T1]  kernel_init_freeable+0x2fc/0x3d4
[   71.396028][    T1]  kernel_init+0x18/0x178
[   71.396039][    T1]  ret_from_fork+0x10/0x18
[   71.396047][    T1]
[   71.396056][    T1] Allocated by task 1:
[   71.396068][    T1]  save_stack+0x28/0xb0
[   71.396080][    T1]  __kasan_kmalloc.isra.9+0xa0/0xc8
[   71.396091][    T1]  kasan_kmalloc+0xc/0x18
[   71.396102][    T1]  __kmalloc+0x2d0/0x338
[   71.396114][    T1]  edac_mc_alloc+0xaa8/0xb18
[   71.396125][    T1]  ghes_edac_register+0x164/0x398
[   71.396137][    T1]  ghes_probe+0x648/0x6d8
[   71.396148][    T1]  platform_drv_probe+0x8c/0x110
[   71.396159][    T1]  really_probe+0x32c/0x840
[   71.396170][    T1]  driver_probe_device+0x190/0x1f0
[   71.396181][    T1]  device_driver_attach+0x7c/0xb0
[   71.396192][    T1]  __driver_attach+0x1b8/0x1d0
[   71.396203][    T1]  bus_for_each_dev+0xf8/0x190
[   71.396214][    T1]  driver_attach+0x34/0x40
[   71.396224][    T1]  bus_add_driver+0x1d8/0x340
[   71.396235][    T1]  driver_register+0x168/0x1e8
[   71.396247][    T1]  __platform_driver_register+0x80/0x90
[   71.396257][    T1]  ghes_init+0xc4/0x174
[   71.396268][    T1]  do_one_initcall+0x328/0x788
[   71.396281][    T1]  kernel_init_freeable+0x2fc/0x3d4
[   71.396292][    T1]  kernel_init+0x18/0x178
[   71.396303][    T1]  ret_from_fork+0x10/0x18
[   71.396310][    T1]
[   71.396318][    T1] Freed by task 1:
[   71.396330][    T1]  save_stack+0x28/0xb0
[   71.396341][    T1]  __kasan_slab_free+0x140/0x170
[   71.396353][    T1]  kasan_slab_free+0x10/0x18
[   71.396364][    T1]  slab_free_freelist_hook+0x19c/0x228
[   71.396375][    T1]  kfree+0x264/0x420
[   71.396386][    T1]  _edac_mc_free+0x1f8/0x210
[   71.396398][    T1]  edac_mc_free+0x68/0x88
[   71.396409][    T1]  ghes_edac_unregister+0x44/0x70
[   71.396420][    T1]  ghes_remove+0x274/0x2a0
[   71.396432][    T1]  platform_drv_remove+0x44/0x78
[   71.396442][    T1]  really_probe+0x404/0x840
[   71.396453][    T1]  driver_probe_device+0x190/0x1f0
[   71.396464][    T1]  device_driver_attach+0x7c/0xb0
[   71.396475][    T1]  __driver_attach+0x1b8/0x1d0
[   71.396487][    T1]  bus_for_each_dev+0xf8/0x190
[   71.396497][    T1]  driver_attach+0x34/0x40
[   71.396508][    T1]  bus_add_driver+0x1d8/0x340
[   71.396519][    T1]  driver_register+0x168/0x1e8
[   71.396530][    T1]  __platform_driver_register+0x80/0x90
[   71.396541][    T1]  ghes_init+0xc4/0x174
[   71.396552][    T1]  do_one_initcall+0x328/0x788
[   71.396564][    T1]  kernel_init_freeable+0x2fc/0x3d4
[   71.396575][    T1]  kernel_init+0x18/0x178
[   71.396586][    T1]  ret_from_fork+0x10/0x18
[   71.396593][    T1]
[   71.396604][    T1] The buggy address belongs to the object at 
ffff002324274000
[   71.396604][    T1]  which belongs to the cache kmalloc-4k of size 4096
[   71.396615][    T1] The buggy address is located 3036 bytes inside of
[   71.396615][    T1]  4096-byte region [ffff002324274000, 
ffff002324275000)
[   71.396624][    T1] The buggy address belongs to the page:
[   71.396637][    T1] page:fffffe008c709c00 refcount:1 mapcount:0 
mapping:ffff0020bfc16980 index:0x0 compound_mapcount: 0
[   71.396655][    T1] flags: 0x1ffff00000010200(slab|head)
[   71.396671][    T1] raw: 1ffff00000010200 fffffe008c709a08 
fffffe008c70c408 ffff0020bfc16980
[   71.396685][    T1] raw: 0000000000000000 0000000000020002 
00000001ffffffff 0000000000000000
[   71.396693][    T1] page dumped because: kasan: bad access detected
[   71.396701][    T1]
[   71.396709][    T1] Memory state around the buggy address:
[   71.396721][    T1]  ffff002324274a80: fb fb fb fb fb fb fb fb fb fb 
fb fb fb fb fb fb
[   71.396732][    T1]  ffff002324274b00: fb fb fb fb fb fb fb fb fb fb 
fb fb fb fb fb fb
[   71.396743][    T1] >ffff002324274b80: fb fb fb fb fb fb fb fb fb fb 
fb fb fb fb fb fb
[   71.396751][    T1]                                                     ^
[   71.396762][    T1]  ffff002324274c00: fb fb fb fb fb fb fb fb fb fb 
fb fb fb fb fb fb
[   71.396773][    T1]  ffff002324274c80: fb fb fb fb fb fb fb fb fb fb 
fb fb fb fb fb fb
[   71.396781][    T1] 
==================================================================
[   71.396789][    T1] Disabling lock debugging due to kernel taint
[   71.396834][    T1] EDAC DEBUG: edac_mc_del_mc:
[   71.396846][    T1] EDAC DEBUG: edac_mc_free:
[   71.396866][    T1] 
==================================================================
[   71.396874][    T1] BUG: KASAN: double-free or invalid-free in 
kfree+0x264/0x420
[   71.396877][    T1]
[   71.396886][    T1] CPU: 48 PID: 1 Comm: swapper/0 Tainted: G    B 
W         5.4.0-rc3+ #1146
[   71.396891][    T1] Hardware name: Huawei D06 /D06, BIOS Hisilicon 
D06 UEFI RC0 - V1.16.01 03/15/2019
[   71.396895][    T1] Call trace:
[   71.396902][    T1]  dump_backtrace+0x0/0x298
[   71.396909][    T1]  show_stack+0x20/0x30
[   71.396915][    T1]  dump_stack+0x190/0x21c
[   71.396923][    T1]  print_address_description.isra.6+0x80/0x3d0
[   71.396931][    T1]  kasan_report_invalid_free+0x78/0xa0
[   71.396939][    T1]  __kasan_slab_free+0xbc/0x170
[   71.396946][    T1]  kasan_slab_free+0x10/0x18
[   71.396953][    T1]  slab_free_freelist_hook+0x19c/0x228
[   71.396959][    T1]  kfree+0x264/0x420
[   71.396967][    T1]  _edac_mc_free+0x6c/0x210
[   71.396974][    T1]  edac_mc_free+0x68/0x88
[   71.396981][    T1]  ghes_edac_unregister+0x44/0x70
[   71.396989][    T1]  ghes_remove+0x274/0x2a0
[   71.396996][    T1]  platform_drv_remove+0x44/0x78
[   71.397002][    T1]  really_probe+0x404/0x840
[   71.397009][    T1]  driver_probe_device+0x190/0x1f0
[   71.397016][    T1]  device_driver_attach+0x7c/0xb0
[   71.397022][    T1]  __driver_attach+0x1b8/0x1d0
[   71.397030][    T1]  bus_for_each_dev+0xf8/0x190
[   71.397037][    T1]  driver_attach+0x34/0x40
[   71.397043][    T1]  bus_add_driver+0x1d8/0x340
[   71.397049][    T1]  driver_register+0x168/0x1e8
[   71.397057][    T1]  __platform_driver_register+0x80/0x90
[   71.397063][    T1]  ghes_init+0xc4/0x174
[   71.397070][    T1]  do_one_initcall+0x328/0x788
[   71.397078][    T1]  kernel_init_freeable+0x2fc/0x3d4
[   71.397085][    T1]  kernel_init+0x18/0x178
[   71.397092][    T1]  ret_from_fork+0x10/0x18
[   71.397096][    T1]
[   71.397100][    T1] Allocated by task 1:
[   71.397108][    T1]  save_stack+0x28/0xb0
[   71.397116][    T1]  __kasan_kmalloc.isra.9+0xa0/0xc8
[   71.397123][    T1]  kasan_kmalloc+0xc/0x18
[   71.397130][    T1]  kmem_cache_alloc_trace+0x2a0/0x2e8
[   71.397138][    T1]  edac_mc_alloc+0x5d4/0xb18
[   71.397145][    T1]  ghes_edac_register+0x164/0x398
[   71.397152][    T1]  ghes_probe+0x648/0x6d8
[   71.397160][    T1]  platform_drv_probe+0x8c/0x110
[   71.397166][    T1]  really_probe+0x32c/0x840
[   71.397173][    T1]  driver_probe_device+0x190/0x1f0
[   71.397180][    T1]  device_driver_attach+0x7c/0xb0
[   71.397186][    T1]  __driver_attach+0x1b8/0x1d0
[   71.397194][    T1]  bus_for_each_dev+0xf8/0x190
[   71.397201][    T1]  driver_attach+0x34/0x40
[   71.397207][    T1]  bus_add_driver+0x1d8/0x340
[   71.397213][    T1]  driver_register+0x168/0x1e8
[   71.397221][    T1]  __platform_driver_register+0x80/0x90
[   71.397227][    T1]  ghes_init+0xc4/0x174
[   71.397235][    T1]  do_one_initcall+0x328/0x788
[   71.397243][    T1]  kernel_init_freeable+0x2fc/0x3d4
[   71.397250][    T1]  kernel_init+0x18/0x178
[   71.397257][    T1]  ret_from_fork+0x10/0x18
[   71.397260][    T1]
[   71.397264][    T1] Freed by task 1:
[   71.397272][    T1]  save_stack+0x28/0xb0
[   71.397279][    T1]  __kasan_slab_free+0x140/0x170
[   71.397286][    T1]  kasan_slab_free+0x10/0x18
[   71.397294][    T1]  slab_free_freelist_hook+0x19c/0x228
[   71.397300][    T1]  kfree+0x264/0x420
[   71.397307][    T1]  _edac_mc_free+0x15c/0x210
[   71.397315][    T1]  edac_mc_free+0x68/0x88
[   71.397322][    T1]  ghes_edac_unregister+0x44/0x70
[   71.397329][    T1]  ghes_remove+0x274/0x2a0
[   71.397337][    T1]  platform_drv_remove+0x44/0x78
[   71.397343][    T1]  really_probe+0x404/0x840
[   71.397350][    T1]  driver_probe_device+0x190/0x1f0
[   71.397357][    T1]  device_driver_attach+0x7c/0xb0
[   71.397363][    T1]  __driver_attach+0x1b8/0x1d0
[   71.397371][    T1]  bus_for_each_dev+0xf8/0x190
[   71.397377][    T1]  driver_attach+0x34/0x40
[   71.397384][    T1]  bus_add_driver+0x1d8/0x340
[   71.397391][    T1]  driver_register+0x168/0x1e8
[   71.397398][    T1]  __platform_driver_register+0x80/0x90
[   71.397404][    T1]  ghes_init+0xc4/0x174
[   71.397411][    T1]  do_one_initcall+0x328/0x788
[   71.397419][    T1]  kernel_init_freeable+0x2fc/0x3d4
[   71.397427][    T1]  kernel_init+0x18/0x178
[   71.397433][    T1]  ret_from_fork+0x10/0x18
[   71.397437][    T1]
[   71.397443][    T1] The buggy address belongs to the object at 
ffff0023245a9200
[   71.397443][    T1]  which belongs to the cache kmalloc-128 of size 128
[   71.397451][    T1] The buggy address is located 0 bytes inside of
[   71.397451][    T1]  128-byte region [ffff0023245a9200, ffff0023245a9280)
[   71.397455][    T1] The buggy address belongs to the page:
[   71.397462][    T1] page:fffffe008c716a00 refcount:1 mapcount:0 
mapping:ffff0020bfc10580 index:0xffff0023245ada80 compound_mapcount: 0
[   71.397471][    T1] flags: 0x1ffff00000010200(slab|head)
[   71.397482][    T1] raw: 1ffff00000010200 fffffe008c716808 
fffffe008c70a008 ffff0020bfc10580
[   71.397492][    T1] raw: ffff0023245ada80 0000000000330016 
00000001ffffffff 0000000000000000
[   71.397496][    T1] page dumped because: kasan: bad access detected
[   71.397499][    T1]
[   71.397503][    T1] Memory state around the buggy address:
[   71.397510][    T1]  ffff0023245a9100: fc fc fc fc fc fc fc fc fc fc 
fc fc fc fc fc fc
[   71.397517][    T1]  ffff0023245a9180: fc fc fc fc fc fc fc fc fc fc 
fc fc fc fc fc fc
[   71.397523][    T1] >ffff0023245a9200: fb fb fb fb fb fb fb fb fb fb 
fb fb fb fb fb fb
[   71.397527][    T1]                    ^
[   71.397534][    T1]  ffff0023245a9280: fc fc fc fc fc fc fc fc fc fc 
fc fc fc fc fc fc
[   71.397541][    T1]  ffff0023245a9300: fc fc fc fc fc fc fc fc fc fc 
fc fc fc fc fc fc
[   71.397545][    T1] 
==================================================================






