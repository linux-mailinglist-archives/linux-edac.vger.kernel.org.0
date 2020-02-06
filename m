Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C57154505
	for <lists+linux-edac@lfdr.de>; Thu,  6 Feb 2020 14:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBFNfU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Feb 2020 08:35:20 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2388 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbgBFNfT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Feb 2020 08:35:19 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 4AA88E637377685659F8;
        Thu,  6 Feb 2020 13:35:17 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 6 Feb 2020 13:35:16 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 13:35:16 +0000
Subject: Re: [PATCH v2] EDAC/mc: Fix use-after-free and memleaks during device
 removal
To:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Aristeu Rozanski <aris@redhat.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200205212444.10382-1-rrichter@marvell.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b5c40201-4521-b9c8-3adb-ee227bf2ffb4@huawei.com>
Date:   Thu, 6 Feb 2020 13:35:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200205212444.10382-1-rrichter@marvell.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 05/02/2020 21:24, Robert Richter wrote:
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
> The use-after-free is caused by the mci_for_each_dimm() iterator that
> is called in edac_remove_sysfs_mci_device(). The iterator was
> introduced with commit c498afaf7df8 ("EDAC: Introduce an
> mci_for_each_dimm() iterator"). The iterator loop calls function
> device_unregister(&dimm->dev), which removes the sysfs entry of the
> device, but also frees the dimm struct in dimm_attr_release(). When
> incrementing the loop in mci_for_each_dimm(), the dimm struct is
> accessed again, but it is already freed.
> 
> The fix is to free all the mci device's subsequent dimm and csrow
> objects at a later point when the mci device is freed. This keeps the
> data structures intact and the mci device can be fully used until its
> removal.
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
> All leaks are from memory created by edac_mc_alloc().
> 
> Note: The test above shows that edac_mc_alloc() was called here from
> ghes_edac_register(), thus both functions show up in the stack dump,
> but the driver causing the leaks is edac_mc. The comments with the
> data structures involved were made manually by analyzing the objdump.
> 
> The data structures listed above and created by edac_mc_alloc() are
> not properly removed during device removal, which is done in
> edac_mc_free(). There are two paths implemented to remove the device
> depending on device registration, _edac_mc_free() is called if the
> device is not registered and edac_unregister_sysfs() otherwise. The
> implemenations differ. For the sysfs case the mci device removal lacks
> the removal of subsequent data structures (csrows, channels, dimms).
> This causes the memory leaks (see mci_attr_release()).
> 
> Fixing this as follows:
> 
> Unify code and implement a mci_release() function which is used to
> remove a struct mci regardless of the device registration status. Use
> put_device() to release the struct. Free all subsequent data structs
> of the mci's children in that release function. An effect of this is
> that no data is freed in edac_mc_sysfs.c (except the "mc" sysfs root
> node). All sysfs entries have the mci device as a parent, so its
> refcount will keep the mci parent as long as sysfs entries exist. This
> prevents struct mci from being freed until all sysfs entries have been
> removed which is done in edac_remove_sysfs_mci_device(). With the
> changes made the mci_for_each_dimm() loop is now save to release dimm
> devices from sysfs.
> 
> The patch has been tested with the above kernel options, no issues
> seen any longer.
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Fixes: c498afaf7df8 ("EDAC: Introduce an mci_for_each_dimm() iterator")
> Fixes: faa2ad09c01c ("edac_mc: edac_mc_free() cannot assume mem_ctl_info is registered in sysfs.")
> Fixes: 7a623c039075 ("edac: rewrite the sysfs code to use struct device")
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> Acked-by: Aristeu Rozanski <aris@redhat.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
> V2:

Kasan warnings and leak reports are gone:
Tested-by: John Garry <john.garry@huawei.com>

Cheers


