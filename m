Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10C310B41E
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 18:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfK0RII (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 12:08:08 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfK0RII (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 12:08:08 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A14D03C3D4B1114CD4FC;
        Wed, 27 Nov 2019 17:08:05 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 27 Nov 2019 17:07:34 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 17:07:34 +0000
Subject: Re: linuxnext-2019127 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
From:   John Garry <john.garry@huawei.com>
To:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Huangming (Mark)" <huangming23@huawei.com>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
 <93bdc04e-9e8f-b766-6e97-9fd9e1460a8c@huawei.com>
 <20191121142302.rhvgkgqpiubidhtu@rric.localdomain>
 <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
 <20191122112842.tmf4lkj52hpv6tqd@rric.localdomain>
 <4c1bd075-75ec-8445-9595-467b88a406b3@huawei.com>
Message-ID: <957a809b-9efd-0979-df5d-a4f095da6147@huawei.com>
Date:   Wed, 27 Nov 2019 17:07:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4c1bd075-75ec-8445-9595-467b88a406b3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 26/11/2019 09:59, John Garry wrote:
> On 22/11/2019 11:28, Robert Richter wrote:
>> On 21.11.19 15:23:42, John Garry wrote:
>>> On 21/11/2019 14:23, Robert Richter wrote:
>>>> On 21.11.19 12:34:22, John Garry wrote:
>>
>>>>> [   22.046666] EDAC MC: bug in low-level driver: attempt to assign
>>>>> [   22.046666]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>>> [   22.058311] ghes_edac: Can't register at EDAC core
>>>>> [   22.065402] EDAC MC: bug in low-level driver: attempt to assign
>>>>> [   22.065402]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>>> [   22.077080] ghes_edac: Can't register at EDAC core
>>>>> [   22.084140] EDAC MC: bug in low-level driver: attempt to assign
>>>>> [   22.084140]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>>> [   22.095789] ghes_edac: Can't register at EDAC core
>>>>> [   22.102873] EDAC MC: bug in low-level driver: attempt to assign
>>>>> [   22.102873]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>>> [   22.115442] ghes_edac: Can't register at EDAC core
>>>>> [   22.122536] EDAC MC: bug in low-level driver: attempt to assign
>>>>> [   22.122536]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>>> [   22.134344] ghes_edac: Can't register at EDAC core
>>>>> [   22.141441] EDAC MC: bug in low-level driver: attempt to assign
>>>>> [   22.141441]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>>> [   22.153089] ghes_edac: Can't register at EDAC core
>>>>> [   22.160161] EDAC MC: bug in low-level driver: attempt to assign
>>>>> [   22.160161]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>>> [   22.171810] ghes_edac: Can't register at EDAC core
>>>>
>>>> What I am more concerned is this here. In total this implies 8 ghes
>>>> users that all try to register a (single-instance) ghes mc device. For
>>>> non-x86 only one instance is allowed (see ghes_edac_register(), idx =
>>>> 0).
>>
>> I also looked into this: With refcount_inc_checked() enabled, the
>> refcount is *not* increased from 0 to 1. 
> 
> Yeah, I had quickly checked this back then and I think you're right.
> 
> Thanks,
> John

Hi guys,

Me again ... For linux-next 27 Nov, I now see this on my same arm64 system:

[   21.936616] ACPI: Power Button [PWRB]
[   22.074582] [Firmware Bug]: APEI: Invalid bit width + offset in GAR 
[0x94110034/64/0/3/0]
[   22.086095] EDAC MC0: Giving out device to module ghes_edac.c 
controller ghes_edac: DEV ghes (INTERRUPT)
[   22.097276] 
==================================================================
[   22.104498] BUG: KASAN: use-after-free in 
edac_remove_sysfs_mci_device+0x148/0x180
[   22.112055] Read of size 4 at addr ffff00233bc69338 by task swapper/0/1
[   22.118656]
[   22.120139] CPU: 33 PID: 1 Comm: swapper/0 Not tainted 
5.4.0-next-20191127-dirty #667
[   22.127956] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[   22.136467] Call trace:
[   22.138907]  dump_backtrace+0x0/0x290
[   22.142558]  show_stack+0x14/0x20
[   22.145865]  dump_stack+0xf0/0x14c
[   22.149258]  print_address_description.isra.11+0x6c/0x3b8
[   22.154645]  __kasan_report+0x12c/0x23c
[   22.158470]  kasan_report+0xc/0x18
[   22.161860]  __asan_load4+0x94/0xb8
[   22.165338]  edac_remove_sysfs_mci_device+0x148/0x180
[   22.170378]  edac_mc_del_mc+0x154/0x1b8
[   22.174203]  ghes_edac_unregister+0xa0/0x188
[   22.178465]  ghes_remove+0x11c/0x1f8
[   22.182033]  platform_drv_remove+0x3c/0x68
[   22.186119]  really_probe+0x174/0x548
[   22.189770]  driver_probe_device+0x7c/0x148
[   22.193942]  device_driver_attach+0x94/0xa0
[   22.198113]  __driver_attach+0xa4/0x110
[   22.201938]  bus_for_each_dev+0xe8/0x158
[   22.205849]  driver_attach+0x30/0x40
[   22.209413]  bus_add_driver+0x234/0x2f0
[   22.213237]  driver_register+0xbc/0x1d0
[   22.217063]  __platform_driver_register+0x7c/0x88
[   22.221757]  ghes_init+0xbc/0x14c
[   22.225060]  do_one_initcall+0xb4/0x254
[   22.228887]  kernel_init_freeable+0x248/0x2f4
[   22.233233]  kernel_init+0x10/0x118
[   22.236710]  ret_from_fork+0x10/0x18
[   22.240273]
[   22.241753] Allocated by task 1:
[   22.244971]  save_stack+0x28/0xc8
[   22.248274]  __kasan_kmalloc.isra.9+0xbc/0xd8
[   22.252619]  kasan_kmalloc+0xc/0x18
[   22.256096]  edac_mc_alloc+0x62c/0x888
[   22.259834]  ghes_edac_register+0x1c8/0x3f0
[   22.264006]  ghes_probe+0x28c/0x5f0
[   22.267484]  platform_drv_probe+0x70/0xd8
[   22.271482]  really_probe+0x118/0x548
[   22.275133]  driver_probe_device+0x7c/0x148
[   22.279305]  device_driver_attach+0x94/0xa0
[   22.283476]  __driver_attach+0xa4/0x110
[   22.287301]  bus_for_each_dev+0xe8/0x158
[   22.291212]  driver_attach+0x30/0x40
[   22.294776]  bus_add_driver+0x234/0x2f0
[   22.298600]  driver_register+0xbc/0x1d0
[   22.302425]  __platform_driver_register+0x7c/0x88
[   22.307118]  ghes_init+0xbc/0x14c
[   22.310421]  do_one_initcall+0xb4/0x254
[   22.314246]  kernel_init_freeable+0x248/0x2f4
[   22.318591]  kernel_init+0x10/0x118
[   22.322068]  ret_from_fork+0x10/0x18
[   22.325630]
[   22.327109] Freed by task 1:
[   22.329978]  save_stack+0x28/0xc8
[   22.333282]  __kasan_slab_free+0x118/0x180
[   22.337366]  kasan_slab_free+0x10/0x18
[   22.341106]  kfree+0x110/0x2b0
[   22.344150]  dimm_attr_release+0xc/0x18
[   22.347978]  device_release+0x7c/0xe0
[   22.351629]  kobject_put+0xb0/0x180
[   22.355106]  device_unregister+0x20/0x30
[   22.359018]  edac_remove_sysfs_mci_device+0x140/0x180
[   22.364057]  edac_mc_del_mc+0x154/0x1b8
[   22.367882]  ghes_edac_unregister+0xa0/0x188
[   22.372140]  ghes_remove+0x11c/0x1f8
[   22.375705]  platform_drv_remove+0x3c/0x68
[   22.379789]  really_probe+0x174/0x548
[   22.383440]  driver_probe_device+0x7c/0x148
[   22.387612]  device_driver_attach+0x94/0xa0
[   22.391783]  __driver_attach+0xa4/0x110
[   22.395608]  bus_for_each_dev+0xe8/0x158
[   22.399519]  driver_attach+0x30/0x40
[   22.403083]  bus_add_driver+0x234/0x2f0
[   22.406907]  driver_register+0xbc/0x1d0
[   22.410732]  __platform_driver_register+0x7c/0x88
[   22.415424]  ghes_init+0xbc/0x14c
[   22.418728]  do_one_initcall+0xb4/0x254
[   22.422553]  kernel_init_freeable+0x248/0x2f4
[   22.426898]  kernel_init+0x10/0x118
[   22.430375]  ret_from_fork+0x10/0x18
[   22.433937]
[   22.435417] The buggy address belongs to the object at ffff00233bc69000
[   22.435417]  which belongs to the cache kmalloc-1k of size 1024
[   22.447922] The buggy address is located 824 bytes inside of
[   22.447922]  1024-byte region [ffff00233bc69000, ffff00233bc69400)
[   22.459731] The buggy address belongs to the page:
[   22.464512] page:fffffe008ccf1a00 refcount:1 mapcount:0 
mapping:ffff00237080f600 index:0x0 compound_mapcount: 0
[   22.474590] raw: 2ffff00000010200 dead000000000100 dead00000000012ge 
dumped because: kasan: bad access detected
[   22.495608]
[   22.497087] Memory state around the buggy address:
[   22.501867]  ffff00233bc69200: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   22.509076]  ffff00233bc69280: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   22.516286] >ffff00233bc69300: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   22.523494]                                         ^
[   22.528534]  ffff00233bc69380: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   22.535744]  ffff00233bc69400: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   22.542952] 
==================================================================
[   22.550161] Disabling lock debugging due to kernel taint
[   22.555511] EDAC MC: Removed device 0 for ghes_edac.c ghes_edac: DEV ghes
[   22.564893] EDAC MC0: Giving out device to module ghes_edac.c 
controller ghes_edac: DEV ghes (INTERRUPT)
[   22.578292] GHES: APEI firmware first mode is enabled by APEI bit and 
WHEA _OSC.
[   22.586264] EINJ: Error INJection is initialized.


root@(none)$  cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff00236c273600 (size 256):
   comm "swapper/0", pid 1, jiffies 4294897813 (age 177.596s)
   hex dump (first 32 bytes):
     00 00 c5 3b 23 00 ff ff 00 08 c5 3b 23 00 ff ff  ...;#......;#...
     00 10 c5 3b 23 00 ff ff 00 18 c5 3b 23 00 ff ff  ...;#......;#...
   backtrace:
     [<000000007144931a>] __kmalloc+0x1e0/0x2c0
     [<00000000ffb454a9>] edac_mc_alloc+0x31c/0x888
     [<00000000f71ac8ce>] ghes_edac_register+0x1c8/0x3f0
     [<00000000c9708978>] ghes_probe+0x28c/0x5f0
     [<0000000082688646>] platform_drv_probe+0x70/0xd8
     [<0000000040ba35c7>] really_probe+0x118/0x548
     [<00000000603befc1>] driver_probe_device+0x7c/0x148
     [<000000002b50a9eb>] device_driver_attach+0x94/0xa0
     [<000000000d74ae48>] __driver_attach+0xa4/0x110
     [<0000000080f51922>] bus_for_each_dev+0xe8/0x158
     [<00000000300e9429>] driver_attach+0x30/0x40
     [<00000000721f69ab>] bus_add_driver+0x234/0x2f0
     [<00000000bc8fe749>] driver_register+0xbc/0x1d0
     [<000000001cc8671e>] __platform_driver_register+0x7c/0x88
     [<00000000324890ef>] ghes_init+0xbc/0x14c
     [<00000000bbe18b33>] do_one_initcall+0xb4/0x254
unreferenced object 0xffff00233bc50000 (size 1024):
   comm "swapper/0", pid 1, jiffies 4294897813 (age 177.596s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000f51a8341>] kmem_cache_alloc+0x188/0x260
     [<000000006c66db0a>] edac_mc_alloc+0x38c/0x888
     [<00000000f71ac8ce>] ghes_edac_register+0x1c8/0x3f0
     [<00000000c9708978>] ghes_probe+0x28c/0x5f0
     [<0000000082688646>] platform_drv_probe+0x70/0xd8
     [<0000000040ba35c7>] really_probe+0x118/0x548
     [<00000000603befc1>] driver_probe_device+0x7c/0x148
     [<000000002b50a9eb>] device_driver_attach+0x94/0xa0
     [<000000000d74ae48>] __driver_attach+0xa4/0x110
     [<0000000080f51922>] bus_for_each_dev+0xe8/0x158
     [<00000000300e9429>] driver_attach+0x30/0x40
     [<00000000721f69ab>] bus_add_driver+0x234/0x2f0
     [<00000000bc8fe749>] driver_register+0xbc/0x1d0
     [<000000001cc8671e>] __platform_driver_register+0x7c/0x88
     [<00000000324890ef>] ghes_init+0xbc/0x14c
     [<00000000bbe18b33>] do_one_initcall+0xb4/0x254
unreferenced object 0xffff00236daa2b00 (size 128):
   comm "swapper/0", pid 1, jiffies 4294897813 (age 177.596s)
   hex dump (first 32 bytes):
     00 2a aa 6d 23 00 ff ff 00 00 00 00 00 00 00 00  .*.m#...........
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000007144931a>] __kmalloc+0x1e0/0x2c0
     [<000000003b8ce7e7>] edac_mc_alloc+0x400/0x888
     [<00000000f71ac8ce>] ghes_edac_register+0x1c8/0x3f0
     [<00000000c9708978>] ghes_probe+0x28c/0x5f0
     [<0000000082688646>] platform_drv_probe+0x70/0xd8
     [<0000000040ba35c7>] really_probe+0x118/0x548
     [<00000000603befc1>] driver_probe_device+0x7c/0x148
     [<000000002b50a9eb>] device_driver_attach+0x94/0xa0
     [<000000000d74ae48>] __driver_attach+0xa4/0x110
     [<0000000080f51922>] bus_for_each_dev+0xe8/0x158
     [<00000000300e9429>] driver_attach+0x30/0x40
     [<00000000721f69ab>] bus_add_driver+0x234/0x2f0
     [<00000000bc8fe749>] driver_register+0xbc/0x1d0
     [<000000001cc8671e>] __platform_driver_register+0x7c/0x88
     [<00000000324890ef>] ghes_init+0xbc/0x14c
     [<00000000bbe18b33>] do_one_initcall+0xb4/0x254
unreferenced object 0xffff00236daa2a00 (size 128):

[snip]

I have test enabled:
+CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
+CONFIG_KASAN=y
+CONFIG_DEBUG_KMEMLEAK=y

Cheers,
John
