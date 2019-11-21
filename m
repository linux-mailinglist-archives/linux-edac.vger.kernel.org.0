Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B910555D
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 16:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKUPX7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 10:23:59 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbfKUPX7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Nov 2019 10:23:59 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 14B122CFF16E18440849;
        Thu, 21 Nov 2019 15:23:57 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 21 Nov 2019 15:23:43 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 21 Nov
 2019 15:23:43 +0000
Subject: Re: linuxnext-2019119 edac warns (was Re: edac KASAN warning in
 experimental arm64 allmodconfig boot)
To:     Robert Richter <rrichter@marvell.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
Date:   Thu, 21 Nov 2019 15:23:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191121142302.rhvgkgqpiubidhtu@rric.localdomain>
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

On 21/11/2019 14:23, Robert Richter wrote:
> Hi John,
> 
> thanks for testing and reporting this. See inline.
> 
> On 21.11.19 12:34:22, John Garry wrote:
>> On 14/10/2019 16:18, John Garry wrote:
>> JFYI, I see an issue on linuxnext-2019119, as follows:
>>
>>     21.645388] io scheduler kyber registered
>> [   21.734011] input: Power Button as
>> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
>> [   21.743295] ACPI: Power Button [PWRB]
>> [   21.809644] [Firmware Bug]: APEI: Invalid bit width + offset in GAR
>> [0x94110034/64/0/3/0]
>> [   21.821974] EDAC MC0: Giving out device to module ghes_edac.c controller
>> ghes_edac: DEV ghes (INTERRUPT)
>> [   21.831763] ------------[ cut here ]------------
>> [   21.836374] refcount_t: increment on 0; use-after-free.
>> [   21.841620] WARNING: CPU: 36 PID: 1 at lib/refcount.c:156
>> refcount_inc_checked+0x44/0x50
>> [   21.849697] Modules linked in:
>> [   21.852745] CPU: 36 PID: 1 Comm: swapper/0 Not tainted
>> 5.4.0-rc8-next-20191119-00003-g141a9fef5092-dirty #650
>> [   21.862645] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 -
>> V1.16.01 03/15/2019
>> [   21.871157] pstate: 60c00009 (nZCv daif +PAN +UAO)
>> [   21.875936] pc : refcount_inc_checked+0x44/0x50
>> [   21.880455] lr : refcount_inc_checked+0x44/0x50
> 
> This is a warning from the refcount framework. It warns if we
> increment from zero. This is reasonable as typically a kernel object
> is created with a refcount of 1 and thrown away once the refcount is
> zero. Afterwards the object is used-after-free.
> 
> For ghes the refcount is initialized with zero, and that is why we see
> this message. However, we protect the refcount with the ghes_reg_mutex
> and thus there is no use after free. The device is allocated and
> registered if the refcount is zero. So this works fine.
> 
> Enclosed a fix that avoids the warning, please test.
> 
> But see below...
> 
>> [   21.884972] sp : ffff00236ffbf8a0
>> [   21.888274] x29: ffff00236ffbf8a0 x28: 0000000000000002
>> [   21.893576] x27: ffff00236cd07900 x26: ffff002369063010
>> [   21.898876] x25: 0000000000000000 x24: ffff00233c236824
>> [   21.904177] x23: ffffa000137b9000 x22: ffffa00016fbb7c0
>> [   21.909477] x21: ffffa00012dfd000 x20: 1fffe0046dff7f24
>> [   21.914777] x19: ffff00233c236000 x18: 0000000000000000
>> [   21.920077] x17: 0000000000000000 x16: 0000000000000000
>> [   21.925377] x15: 0000000000007700 x14: 64655f7365686720
>> [   21.930677] x13: 72656c6c6f72746e x12: 1ffff40002719618
>> [   21.935977] x11: ffff940002719618 x10: dfffa00000000000
>> [   21.941278] x9 : ffff940002719619 x8 : 0000000000000001
>> [   21.946578] x7 : 0000000000000000 x6 : 0000000000000001
>> [   21.951877] x5 : ffff940002719618 x4 : ffff00236ffb0010
>> [   21.957178] x3 : ffffa000112415e4 x2 : ffff80046dff7ede
>> [   21.962478] x1 : 5aff78756b1cf400 x0 : 0000000000000000
>> [   21.967779] Call trace:
>> [   21.970214]  refcount_inc_checked+0x44/0x50
>> [   21.974389]  ghes_edac_register+0x258/0x388
>> [   21.978562]  ghes_probe+0x28c/0x5f0
>> [   21.982041]  platform_drv_probe+0x70/0xd8
>> [   21.986039]  really_probe+0x174/0x468
>> [   21.989690]  driver_probe_device+0x7c/0x148
>> [   21.993862]  device_driver_attach+0x94/0xa0
>> [   21.998033]  __driver_attach+0xa4/0x110
>> [   22.001857]  bus_for_each_dev+0xe8/0x158
>> [   22.005768]  driver_attach+0x30/0x40
>> [   22.009331]  bus_add_driver+0x234/0x2f0
>> [   22.013156]  driver_register+0xbc/0x1d0
>> [   22.016981]  __platform_driver_register+0x7c/0x88
>> [   22.021675]  ghes_init+0xbc/0x14c
>> [   22.024979]  do_one_initcall+0xb4/0x254
>> [   22.028805]  kernel_init_freeable+0x248/0x2f4
>> [   22.033151]  kernel_init+0x10/0x118
>> [   22.036628]  ret_from_fork+0x10/0x18
>> [   22.040194] ---[ end trace 33655bb65a9835fe ]---
>> [   22.046666] EDAC MC: bug in low-level driver: attempt to assign
>> [   22.046666]     duplicate mc_idx 0 in add_mc_to_global_list()
>> [   22.058311] ghes_edac: Can't register at EDAC core
>> [   22.065402] EDAC MC: bug in low-level driver: attempt to assign
>> [   22.065402]     duplicate mc_idx 0 in add_mc_to_global_list()
>> [   22.077080] ghes_edac: Can't register at EDAC core
>> [   22.084140] EDAC MC: bug in low-level driver: attempt to assign
>> [   22.084140]     duplicate mc_idx 0 in add_mc_to_global_list()
>> [   22.095789] ghes_edac: Can't register at EDAC core
>> [   22.102873] EDAC MC: bug in low-level driver: attempt to assign
>> [   22.102873]     duplicate mc_idx 0 in add_mc_to_global_list()
>> [   22.115442] ghes_edac: Can't register at EDAC core
>> [   22.122536] EDAC MC: bug in low-level driver: attempt to assign
>> [   22.122536]     duplicate mc_idx 0 in add_mc_to_global_list()
>> [   22.134344] ghes_edac: Can't register at EDAC core
>> [   22.141441] EDAC MC: bug in low-level driver: attempt to assign
>> [   22.141441]     duplicate mc_idx 0 in add_mc_to_global_list()
>> [   22.153089] ghes_edac: Can't register at EDAC core
>> [   22.160161] EDAC MC: bug in low-level driver: attempt to assign
>> [   22.160161]     duplicate mc_idx 0 in add_mc_to_global_list()
>> [   22.171810] ghes_edac: Can't register at EDAC core
> 
> What I am more concerned is this here. In total this implies 8 ghes
> users that all try to register a (single-instance) ghes mc device. For
> non-x86 only one instance is allowed (see ghes_edac_register(), idx =
> 0).
> 

[cc some guys about HEST]

> So on your platform, when parsing the HEST table
> (hest_ghes_dev_register()), more than one "GHES" device is parsed,
> allocated and registered. Mind sending me your HEST table
> (/sys/firmware/acpi/tables/HEST), or explain what happens here? 

I think that this should be the same:
https://github.com/tianocore/edk2-platforms/tree/master/Silicon/Hisilicon/Hi1620/Drivers/Apei/Hest


If
> this is a valid use case, we need to change ghes_edac_register() to
> support more than one instance.
> 
> Again, please try the patch below.
> 
> Thanks,
> 
> -Robert
> 
> 
>>From 6962f8af4a7c1051c9e87a5ac60571f70d2b6814 Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@marvell.com>
> Date: Thu, 21 Nov 2019 15:01:28 +0100
> Subject: [PATCH] EDAC/ghes: Do not warn on when increment refcount on 0
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>   drivers/edac/ghes_edac.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 47f4e7f90ef0..b99080d8a10c 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -556,8 +556,8 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>   	ghes_pvt = pvt;
>   	spin_unlock_irqrestore(&ghes_lock, flags);
>   
> -	/* only increment on success */
> -	refcount_inc(&ghes_refcount);
> +	/* only set on success */
> +	refcount_set(&ghes_refcount, 1);

Yep, that seems to have silenced it all:

[   21.739895] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[   21.749848] ACPI: Power Button [PWRB]
[   21.816977] [Firmware Bug]: APEI: Invalid bit width + offset in GAR 
[0x94110034/64/0/3/0]
[   21.827880] EDAC MC0: Giving out device to module ghes_edac.c 
controller ghes_edac: DEV ghes (INTERRUPT)
[   21.841313] GHES: APEI firmware first mode is enabled by APEI bit and 
WHEA _OSC.
[   21.849176] EINJ: Error INJection is initialized.
[   21.855135] ACPI GTDT: found 1 SBSA generic Watchdog(s).

Thanks,
John

>   
>   unlock:
>   	mutex_unlock(&ghes_reg_mutex);
> 


Cheers,
John
