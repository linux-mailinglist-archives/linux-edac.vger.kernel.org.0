Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61F827099F
	for <lists+linux-edac@lfdr.de>; Sat, 19 Sep 2020 03:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgISBVz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Sep 2020 21:21:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13311 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISBVz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Sep 2020 21:21:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B05845E416AE71A14D3F;
        Sat, 19 Sep 2020 09:21:50 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 09:21:47 +0800
Subject: Re: [PATCH -next] RAS/CEC: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Borislav Petkov <bp@alien8.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200716085834.11484-1-miaoqinglang@huawei.com>
 <20200817103121.GF549@zn.tnic>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <9198adbd-4da7-7cdf-76a2-8b10b5f0f9d3@huawei.com>
Date:   Sat, 19 Sep 2020 09:21:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200817103121.GF549@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



在 2020/8/17 18:31, Borislav Petkov 写道:
> On Thu, Jul 16, 2020 at 04:58:34PM +0800, Qinglang Miao wrote:
>> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>>
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> ---
>>   drivers/ras/cec.c | 17 +++--------------
>>   1 file changed, 3 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
>> index a992bb426..ed47b59e4 100644
>> --- a/drivers/ras/cec.c
>> +++ b/drivers/ras/cec.c
>> @@ -435,7 +435,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, u64_get, action_threshold_set, "%
>>   
>>   static const char * const bins[] = { "00", "01", "10", "11" };
>>   
>> -static int array_dump(struct seq_file *m, void *v)
>> +static int array_show(struct seq_file *m, void *v)
>>   {
>>   	struct ce_array *ca = &ce_arr;
>>   	int i;
>> @@ -467,18 +467,7 @@ static int array_dump(struct seq_file *m, void *v)
>>   	return 0;
>>   }
>>   
>> -static int array_open(struct inode *inode, struct file *filp)
>> -{
>> -	return single_open(filp, array_dump, NULL);
>> -}
>> -
>> -static const struct file_operations array_ops = {
>> -	.owner	 = THIS_MODULE,
>> -	.open	 = array_open,
>> -	.read_iter	 = seq_read_iter,
> 
> $ test-apply.sh /tmp/01-ras-cec-convert_to_define_show_attribute.patch
> checking file drivers/ras/cec.c
> Hunk #2 FAILED at 467.
> 1 out of 3 hunks FAILED
> Apply? (y/n) n
> 
> Where did this .read_iter come from?
> 
Hi Borislav,

.read_iter come from <4d4901c6d7> which has been reverted in Linux-next.

So I resent a new patch against linux-next(20200917), and it can
be applied to mainline cleanly now.

Thanks.

