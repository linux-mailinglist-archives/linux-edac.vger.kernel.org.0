Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBA210C7A3
	for <lists+linux-edac@lfdr.de>; Thu, 28 Nov 2019 12:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfK1LCh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Nov 2019 06:02:37 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbfK1LCh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Nov 2019 06:02:37 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id AEB06E27E06C92C1AF82;
        Thu, 28 Nov 2019 11:02:35 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 28 Nov 2019 11:02:34 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 28 Nov
 2019 11:02:33 +0000
Subject: Re: linuxnext-20191127 edac warns (was Re: edac KASAN warning in
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
 <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
 <20191122112842.tmf4lkj52hpv6tqd@rric.localdomain>
 <4c1bd075-75ec-8445-9595-467b88a406b3@huawei.com>
 <957a809b-9efd-0979-df5d-a4f095da6147@huawei.com>
 <20191127205400.cip7hdbhcdokofel@rric.localdomain>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7131f2b9-d4c3-b858-2d17-c56003789df2@huawei.com>
Date:   Thu, 28 Nov 2019 11:02:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191127205400.cip7hdbhcdokofel@rric.localdomain>
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


Hi Robert,

> thank you for testing.

I'm just stumbling across these, TBH.

> 
> On 27.11.19 17:07:33, John Garry wrote:
> 
>> [snip]
>>
>> I have test enabled:
>> +CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
>> +CONFIG_KASAN=y
>> +CONFIG_DEBUG_KMEMLEAK=y
> 
> Is this a regression (did it work before?), or a new test that you
> newly run?

linuxnext-20191119 does not look to have the issue - that's when I 
cherry-pick your refcount fix - but has lots of memory leaks:

root@(none)$
root@(none)$ echo scan > /sys/kernel/debug/kmemleak
root@(none)$ [  121.639978] kmemleak: 128 new suspected memory leaks 
(see /sys/kernel/debug/kmemleak)

root@(none)$ cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff00236c24ba00 (size 256):
   comm "swapper/0", pid 1, jiffies 4294897826 (age 107.824s)
   hex dump (first 32 bytes):
     00 40 2d 3c 23 00 ff ff 00 48 2d 3c 23 00 ff ff  .@-<#....H-<#...
     00 50 2d 3c 23 00 ff ff 00 58 2d 3c 23 00 ff ff  .P-<#....X-<#...
   backtrace:
     [<0000000009aed8e3>] __kmalloc+0x1e0/0x2c0
     [<00000000bf599427>] edac_mc_alloc+0x31c/0x888
     [<00000000c070e314>] ghes_edac_register+0x15c/0x390
     [<00000000e4aad1c2>] ghes_probe+0x28c/0x5f0
     [<0000000079c357cb>] platform_drv_probe+0x70/0xd8
     [<00000000d4ab9188>] really_probe+0x118/0x548
     [<00000000763d50f1>] driver_probe_device+0x7c/0x148
     [<0000000058e623c3>] device_driver_attach+0x94/0xa0
     [<00000000d7cb679d>] __driver_attach+0xa4/0x110
     [<000000007d0942a0>] bus_for_each_dev+0xe8/0x158
     [<000000004cf734d1>] driver_attach+0x30/0x40
     [<000000009aa3536e>] bus_add_driver+0x234/0x2f0
     [<00000000d163cfe0>] driver_register+0xbc/0x1d0
     [<000000007e4f0ac1>] __platform_driver_register+0x7c/0x88
     [<00000000a63c8dd0>] ghes_init+0xbc/0x14c
     [<00000000356c8a7f>] do_one_initcall+0xb4/0x254
unreferenced object 0xffff00233c2d4000 (size 1024):
   comm "swapper/0", pid 1, jiffies 4294897826 (age 107.824s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000004945469f>] kmem_cache_alloc+0x188/0x260
     [<0000000032ea779d>] edac_mc_alloc+0x38c/0x888

Unfortunately v5.4 has similar memory leaks.

Thanks,
John
