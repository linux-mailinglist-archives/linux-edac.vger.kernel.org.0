Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A917D67CB
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 18:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbfJNQ4O (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 12:56:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbfJNQ4O (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 12:56:14 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4872ABD9755E61BFA34D;
        Tue, 15 Oct 2019 00:56:12 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 00:56:07 +0800
Subject: Re: edac KASAN warning in experimental arm64 allmodconfig boot
To:     James Morse <james.morse@arm.com>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
 <dc974549-6ea4-899d-7f3a-b2fcfafe1528@arm.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <tony.luck@intel.com>, Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a5e3c4eb-57ed-d4bc-a771-47472c5fb088@huawei.com>
Date:   Mon, 14 Oct 2019 17:56:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <dc974549-6ea4-899d-7f3a-b2fcfafe1528@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14/10/2019 17:15, James Morse wrote:
> Hi John,
>

Hi James,

> On 14/10/2019 16:18, John Garry wrote:
>> I'm experimenting by trying to boot an allmodconfig arm64 kernel, as mentioned here:
>
> Crumbs!
>
>
>> One thing that I noticed - it's hard to miss actually - is the amount of complaining from
>> KASAN about the EDAC/ghes code. Maybe this is something I should not care about/red
>> herring, or maybe something genuine. Let me know what you think.
>
> Hmmm, I thought I tested this recently...
>
>> Log snippet (I cut off after the first KASAN warning):
>>
>> [   70.471011][    T1] random: get_random_u32 called from new_slab+0x360/0x698 with
>> crng_init=0
>
>> [   70.478671][    T1] [Firmware Bug]: APEI: Invalid bit width + offset in GAR
>> [0x94110034/64/0/3/0]
>
> (this one's for you right?)

Yeah, I'll report it. It might be already fixed.

>
>> [   70.700412][    T1] ------------[ cut here ]------------
>
>> [   70.802080][    T1] Call trace:
>> [   70.802093][    T1]  debug_print_object+0xec/0x130
>> [   70.802106][    T1]  __debug_check_no_obj_freed+0x114/0x290
>> [   70.802119][    T1]  debug_check_no_obj_freed+0x18/0x28
>> [   70.802130][    T1]  slab_free_freelist_hook+0x18c/0x228
>> [   70.802140][    T1]  kfree+0x264/0x420
>> [   70.802157][    T1]  _edac_mc_free+0x6c/0x210
>> [   70.814163][    T1]  edac_mc_free+0x68/0x88
>> [   70.814177][    T1]  ghes_edac_unregister+0x44/0x70
>> [   70.814193][    T1]  ghes_remove+0x274/0x2a0
>
> Ugh. This must be the test driver remove thing.

Yeah, the probe, remove, probe again flow from 
CONFIG_DEBUG_TEST_DRIVER_REMOVE.

>
> I've reproduced this, but had to remove the parent GHES twice. It looks like it tries to
> use the first ghes_edac global variables when freeing the second. ghes_init prevents it
> from re-allocating over the top.
>
> The below diff fixes it for me.

And for me by the looks of it. That's with CONFIG_DEBUG_KOBJECT_RELEASE 
now unset, but I expect the same with it set.

(I'll post it as a proper patch once I've done the
> archaeology)
>
> -----------%<-----------
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index d413a0bdc9ad..955b59b6aade 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -554,6 +554,7 @@ void ghes_edac_unregister(struct ghes *ghes)
>                 return;
>
>         mci = ghes_pvt->mci;
> +       ghes_pvt = NULL;
>         edac_mc_del_mc(mci->pdev);
>         edac_mc_free(mci);
>  }
>
> -----------%<-----------
>

Thanks,
John

BTW, I am not sure if my response to Boris was rejected due to 
attachments, as but it is here:

https://lore.kernel.org/linux-edac/dc974549-6ea4-899d-7f3a-b2fcfafe1528@arm.com/T/#ma0e122ca0eda9d80e869af179352f75037146d3c

>
> Thanks!
>
> James
>
> .
>


