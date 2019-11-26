Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF081109BA3
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 10:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfKZJ7J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 04:59:09 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2115 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727731AbfKZJ7J (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Nov 2019 04:59:09 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BEDD7F409889221F4407;
        Tue, 26 Nov 2019 09:59:07 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 26 Nov 2019 09:59:07 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 09:59:06 +0000
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
 <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
 <20191122112842.tmf4lkj52hpv6tqd@rric.localdomain>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4c1bd075-75ec-8445-9595-467b88a406b3@huawei.com>
Date:   Tue, 26 Nov 2019 09:59:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191122112842.tmf4lkj52hpv6tqd@rric.localdomain>
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

On 22/11/2019 11:28, Robert Richter wrote:
> On 21.11.19 15:23:42, John Garry wrote:
>> On 21/11/2019 14:23, Robert Richter wrote:
>>> On 21.11.19 12:34:22, John Garry wrote:
> 
>>>> [   22.046666] EDAC MC: bug in low-level driver: attempt to assign
>>>> [   22.046666]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>> [   22.058311] ghes_edac: Can't register at EDAC core
>>>> [   22.065402] EDAC MC: bug in low-level driver: attempt to assign
>>>> [   22.065402]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>> [   22.077080] ghes_edac: Can't register at EDAC core
>>>> [   22.084140] EDAC MC: bug in low-level driver: attempt to assign
>>>> [   22.084140]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>> [   22.095789] ghes_edac: Can't register at EDAC core
>>>> [   22.102873] EDAC MC: bug in low-level driver: attempt to assign
>>>> [   22.102873]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>> [   22.115442] ghes_edac: Can't register at EDAC core
>>>> [   22.122536] EDAC MC: bug in low-level driver: attempt to assign
>>>> [   22.122536]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>> [   22.134344] ghes_edac: Can't register at EDAC core
>>>> [   22.141441] EDAC MC: bug in low-level driver: attempt to assign
>>>> [   22.141441]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>> [   22.153089] ghes_edac: Can't register at EDAC core
>>>> [   22.160161] EDAC MC: bug in low-level driver: attempt to assign
>>>> [   22.160161]     duplicate mc_idx 0 in add_mc_to_global_list()
>>>> [   22.171810] ghes_edac: Can't register at EDAC core
>>>
>>> What I am more concerned is this here. In total this implies 8 ghes
>>> users that all try to register a (single-instance) ghes mc device. For
>>> non-x86 only one instance is allowed (see ghes_edac_register(), idx =
>>> 0).
> 
> I also looked into this: With refcount_inc_checked() enabled, the
> refcount is *not* increased from 0 to 1. 

Yeah, I had quickly checked this back then and I think you're right.

Thanks,
John

Under the hood only
> refcount_inc_not_zero() is called instead of refcount_inc(). So the
> refcount is still zero after an edac mc device was registered. Instead
> of sharing the edac mc device, the driver tries to allocate another mc
> device for each GHESv2 entry in the HEST table. This causes the
> 'duplicate mc_idx' message. Also, it is ok to have multiple GHESv2
> entries (your system seems to have 8 entries), e.g. to serve different
> kind of errors in the system.
> 
> Thanks,
> 
> -Robert
> .
> 

