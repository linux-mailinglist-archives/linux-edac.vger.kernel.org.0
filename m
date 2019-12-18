Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89351245C0
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2019 12:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfLRL22 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Dec 2019 06:28:28 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfLRL22 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Dec 2019 06:28:28 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7FC96B3626971AAABCE9;
        Wed, 18 Dec 2019 11:28:26 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 18 Dec 2019 11:28:25 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 11:28:25 +0000
Subject: Re: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
To:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191218062129.7400-1-rrichter@marvell.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0c7da2d7-1cab-f518-2309-f740d7ef36fa@huawei.com>
Date:   Wed, 18 Dec 2019 11:28:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191218062129.7400-1-rrichter@marvell.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 18/12/2019 06:22, Robert Richter wrote:
> A test kernel with the options set below revealed several issues when
> removing a mci device:
> 
>   DEBUG_TEST_DRIVER_REMOVE
>   KASAN
>   DEBUG_KMEMLEAK
> 
> Issues seen:
> 
> 1) Use-after-free:
> 
> On 27.11.19 17:07:33, John Garry wrote:
>> [   22.104498] BUG: KASAN: use-after-free in
>> edac_remove_sysfs_mci_device+0x148/0x180
> 
> The use-after-free is triggered in edac_remove_sysfs_mci_device(). It
> became an issue with commit c498afaf7df8 ("EDAC: Introduce an
> mci_for_each_dimm() iterator").
> 
> The reason for it is that device_unregister(&dimm->dev) not only
> removes the sysfs entry, it also frees the dimm struct in
> dimm_attr_release(). When incrementing the loop in
> mci_for_each_dimm(), the dimm struct is accessed again by the loop
> iterator which causes the use-after-free.
> 
> In function edac_remove_sysfs_mci_device() all the mci device's
> subsequent dimm and csrow objects are removed. When unregistering from
> sysfs, instead of removing that data it should be kept until it is
> removed together with the mci device. This keeps the data structures
> intact and the mci device can be fully used until it will be removed.
> 
> 2) Memory leaks:
> 
> Following memory leaks have been detected:
> 
>   # grep edac /sys/kernel/debug/kmemleak | sort | uniq -c
>         1     [<000000003c0f58f9>] edac_mc_alloc+0x3bc/0x9d0      # mci->csrows
>        16     [<00000000bb932dc0>] edac_mc_alloc+0x49c/0x9d0      # csr->channels
>        16     [<00000000e2734dba>] edac_mc_alloc+0x518/0x9d0      # csr->channels[chn]
>         1     [<00000000eb040168>] edac_mc_alloc+0x5c8/0x9d0      # mci->dimms
>        34     [<00000000ef737c29>] ghes_edac_register+0x1c8/0x3f8 # see edac_mc_alloc()
> 
> There are two implementions for device removal in the driver. One is
> used before edac_mc_add_mc(), the other afterwards after the device
> had been registered in sysfs. The later lacks the removal of some data
> allocated in edac_mc_alloc(). All the above issues are fixed as
> follows:
> 
> Unify release code in a single mci_release() function and use this one
> together with put_device() to release the struct mci once there are no
> users. Free all subsequent data structures of the children devices in
> that release function too. An effect of this is that no data is freed
> in edac_mc_sysfs.c (except the "mc" sysfs root node). All sysfs
> entries have the mci device as a parent, so its refcount will keep the
> struct from being removed as long as sysfs entries exist. Before
> freeing struct mci, all sysfs entries are removed now in edac_remove_
> sysfs_mci_device(). With the changes made the mci_for_each_dimm() loop
> is now save to remove dimm devices from sysfs.
> 
> The patch has been tested with the above kernel options, no issues
> seen any longer.
> 
> This patch should be marked as stable.

Not sure why you haven't...

> 
> Reported-by: John Garry <john.garry@huawei.com>

The splats and leaks have disappeared for when booting my arm64 machine:
Tested-by: John Garry <john.garry@huawei.com>

thanks
