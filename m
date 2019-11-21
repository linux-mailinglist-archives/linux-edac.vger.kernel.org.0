Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523ED105251
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 13:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUMeZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 07:34:25 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2111 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfKUMeZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Nov 2019 07:34:25 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D03F698E43703977E066;
        Thu, 21 Nov 2019 12:34:23 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 21 Nov 2019 12:34:23 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 21 Nov
 2019 12:34:23 +0000
Subject: linuxnext-2019119 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
From:   John Garry <john.garry@huawei.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
Message-ID: <93bdc04e-9e8f-b766-6e97-9fd9e1460a8c@huawei.com>
Date:   Thu, 21 Nov 2019 12:34:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14/10/2019 16:18, John Garry wrote:


Hi guys,

JFYI, I see an issue on linuxnext-2019119, as follows:

    21.645388] io scheduler kyber registered
[   21.734011] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[   21.743295] ACPI: Power Button [PWRB]
[   21.809644] [Firmware Bug]: APEI: Invalid bit width + offset in GAR 
[0x94110034/64/0/3/0]
[   21.821974] EDAC MC0: Giving out device to module ghes_edac.c 
controller ghes_edac: DEV ghes (INTERRUPT)
[   21.831763] ------------[ cut here ]------------
[   21.836374] refcount_t: increment on 0; use-after-free.
[   21.841620] WARNING: CPU: 36 PID: 1 at lib/refcount.c:156 
refcount_inc_checked+0x44/0x50
[   21.849697] Modules linked in:
[   21.852745] CPU: 36 PID: 1 Comm: swapper/0 Not tainted 
5.4.0-rc8-next-20191119-00003-g141a9fef5092-dirty #650
[   21.862645] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[   21.871157] pstate: 60c00009 (nZCv daif +PAN +UAO)
[   21.875936] pc : refcount_inc_checked+0x44/0x50
[   21.880455] lr : refcount_inc_checked+0x44/0x50
[   21.884972] sp : ffff00236ffbf8a0
[   21.888274] x29: ffff00236ffbf8a0 x28: 0000000000000002
[   21.893576] x27: ffff00236cd07900 x26: ffff002369063010
[   21.898876] x25: 0000000000000000 x24: ffff00233c236824
[   21.904177] x23: ffffa000137b9000 x22: ffffa00016fbb7c0
[   21.909477] x21: ffffa00012dfd000 x20: 1fffe0046dff7f24
[   21.914777] x19: ffff00233c236000 x18: 0000000000000000
[   21.920077] x17: 0000000000000000 x16: 0000000000000000
[   21.925377] x15: 0000000000007700 x14: 64655f7365686720
[   21.930677] x13: 72656c6c6f72746e x12: 1ffff40002719618
[   21.935977] x11: ffff940002719618 x10: dfffa00000000000
[   21.941278] x9 : ffff940002719619 x8 : 0000000000000001
[   21.946578] x7 : 0000000000000000 x6 : 0000000000000001
[   21.951877] x5 : ffff940002719618 x4 : ffff00236ffb0010
[   21.957178] x3 : ffffa000112415e4 x2 : ffff80046dff7ede
[   21.962478] x1 : 5aff78756b1cf400 x0 : 0000000000000000
[   21.967779] Call trace:
[   21.970214]  refcount_inc_checked+0x44/0x50
[   21.974389]  ghes_edac_register+0x258/0x388
[   21.978562]  ghes_probe+0x28c/0x5f0
[   21.982041]  platform_drv_probe+0x70/0xd8
[   21.986039]  really_probe+0x174/0x468
[   21.989690]  driver_probe_device+0x7c/0x148
[   21.993862]  device_driver_attach+0x94/0xa0
[   21.998033]  __driver_attach+0xa4/0x110
[   22.001857]  bus_for_each_dev+0xe8/0x158
[   22.005768]  driver_attach+0x30/0x40
[   22.009331]  bus_add_driver+0x234/0x2f0
[   22.013156]  driver_register+0xbc/0x1d0
[   22.016981]  __platform_driver_register+0x7c/0x88
[   22.021675]  ghes_init+0xbc/0x14c
[   22.024979]  do_one_initcall+0xb4/0x254
[   22.028805]  kernel_init_freeable+0x248/0x2f4
[   22.033151]  kernel_init+0x10/0x118
[   22.036628]  ret_from_fork+0x10/0x18
[   22.040194] ---[ end trace 33655bb65a9835fe ]---
[   22.046666] EDAC MC: bug in low-level driver: attempt to assign
[   22.046666]     duplicate mc_idx 0 in add_mc_to_global_list()
[   22.058311] ghes_edac: Can't register at EDAC core
[   22.065402] EDAC MC: bug in low-level driver: attempt to assign
[   22.065402]     duplicate mc_idx 0 in add_mc_to_global_list()
[   22.077080] ghes_edac: Can't register at EDAC core
[   22.084140] EDAC MC: bug in low-level driver: attempt to assign
[   22.084140]     duplicate mc_idx 0 in add_mc_to_global_list()
[   22.095789] ghes_edac: Can't register at EDAC core
[   22.102873] EDAC MC: bug in low-level driver: attempt to assign
[   22.102873]     duplicate mc_idx 0 in add_mc_to_global_list()
[   22.115442] ghes_edac: Can't register at EDAC core
[   22.122536] EDAC MC: bug in low-level driver: attempt to assign
[   22.122536]     duplicate mc_idx 0 in add_mc_to_global_list()
[   22.134344] ghes_edac: Can't register at EDAC core
[   22.141441] EDAC MC: bug in low-level driver: attempt to assign
[   22.141441]     duplicate mc_idx 0 in add_mc_to_global_list()
[   22.153089] ghes_edac: Can't register at EDAC core
[   22.160161] EDAC MC: bug in low-level driver: attempt to assign
[   22.160161]     duplicate mc_idx 0 in add_mc_to_global_list()
[   22.171810] ghes_edac: Can't register at EDAC core
[   22.178933] GHES: APEI firmware first mode is enabled by APEI bit and 
WHEA _OSC.

This time I'm using a standard arm64 defconfig, except kasan and 
kmemleak is enabled (I need to enable them when developing software - 
joke). Maybe it's a known issue, I don't know.

Cheers,
John

> Hi guys,
> 
> I'm experimenting by trying to boot an allmodconfig arm64 kernel, as 
> mentioned here:
> https://lore.kernel.org/linux-arm-kernel/507325a3-030e-2843-0f46-7e18c60257de@huawei.com/ 
> 
> 
> One thing that I noticed - it's hard to miss actually - is the amount of 
> complaining from KASAN about the EDAC/ghes code. Maybe this is something 
> I should not care about/red herring, or maybe something genuine. Let me 
> know what you think.
> 
> The kernel is v5.4-rc3, and I raised the EDAC mc debug level to get 
> extra debug prints.
> 

[cut]
