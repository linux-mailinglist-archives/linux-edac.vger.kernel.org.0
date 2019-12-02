Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAEE10E8AF
	for <lists+linux-edac@lfdr.de>; Mon,  2 Dec 2019 11:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLBKXc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Dec 2019 05:23:32 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2145 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfLBKXc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 2 Dec 2019 05:23:32 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7AC43DCEC5967BE6F81D;
        Mon,  2 Dec 2019 10:23:30 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 2 Dec 2019 10:23:30 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 10:23:29 +0000
Subject: Re: linuxnext-2019127 edac warns (was Re: edac KASAN warning in
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
 <20191128211240.yuuhf4xkzhl2jvfw@rric.localdomain>
From:   John Garry <john.garry@huawei.com>
Message-ID: <49bb86d8-a7ad-e66d-9796-799ee0bdd605@huawei.com>
Date:   Mon, 2 Dec 2019 10:23:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191128211240.yuuhf4xkzhl2jvfw@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 28/11/2019 21:12, Robert Richter wrote:
> On 27.11.19 17:07:33, John Garry wrote:
>> [   22.104498] BUG: KASAN: use-after-free in
>> edac_remove_sysfs_mci_device+0x148/0x180
> 
> It is triggered in edac_remove_sysfs_mci_device().
> 
> device_unregister(&dimm->dev) not only removes the sysfs entry, it
> also frees the dimm struct in dimm_attr_release(). When incrementing
> the loop in mci_for_each_dimm(), the dimm struct is accessed again
> which causes the use-after-free. But, the dimm struct shouln'd be
> released here already.
> 
> edac_remove_sysfs_mci_device() should not release the devices at this
> point. We need clean release functions for mci and dimm_info and
> refcounts to protect pdev/dev mappings. And mci_for_each_dimm() must
> be checked how it handles device removals and if it is safe.
> 
> Let's see how this can be fixed.
> 
> Thanks for reporting the issue.

Fine, and would any fix also deal with the v5.4 mem leak which I 
mentioned also?

Cheers,
John
