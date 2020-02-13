Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF515BD66
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2020 12:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgBMLKs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Feb 2020 06:10:48 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMLKs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Feb 2020 06:10:48 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D08D67F2D926FD9CBAD9;
        Thu, 13 Feb 2020 11:10:45 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Feb 2020 11:10:45 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 13 Feb
 2020 11:10:45 +0000
Subject: Re: [PATCH v3 0/4] EDAC/mc: Fixes for mci device removal
To:     Borislav Petkov <bp@alien8.de>,
        Robert Richter <rrichter@marvell.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200212120340.4764-1-rrichter@marvell.com>
 <20200213110512.GH31799@zn.tnic>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6617867c-f9e1-b7b8-d605-d273b8dd7f69@huawei.com>
Date:   Thu, 13 Feb 2020 11:10:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200213110512.GH31799@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
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

On 13/02/2020 11:05, Borislav Petkov wrote:
>> Robert Richter (4):
>>    Revert parts of "EDAC/mc_sysfs: Make debug messages consistent"
>>    EDAC/mc: Fix use-after-free and memleaks during device removal
>>    EDAC/sysfs: Remove csrow objects on errors
>>    EDAC/mc: Change mci device removal to use put_device()
>>
>>   drivers/edac/edac_mc.c       |  20 +++----
>>   drivers/edac/edac_mc_sysfs.c | 100 +++++++++++++----------------------
>>   drivers/edac/edac_module.h   |   1 -
>>   3 files changed, 48 insertions(+), 73 deletions(-)
> Thanks, first three (1+2 squashed) pushed here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-urgent
> 
> @John: if you could run them one more time on your machines, that would
> be great!

ok, give me a little while and I'll test that branch

Cheers

> 
> Thx.
> 
> -- Regards/Gruss, Boris. 
> https://people.kernel.org/tglx/notes-about-netiquette .

