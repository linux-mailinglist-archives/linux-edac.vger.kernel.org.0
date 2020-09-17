Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2488426DAD0
	for <lists+linux-edac@lfdr.de>; Thu, 17 Sep 2020 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgIQLyk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 07:54:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbgIQLy2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Sep 2020 07:54:28 -0400
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:54:27 EDT
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D8C347362039763D03B9;
        Thu, 17 Sep 2020 19:38:59 +0800 (CST)
Received: from [10.174.178.16] (10.174.178.16) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 19:38:57 +0800
Subject: Re: [PATCH v2] EDAC/mc_sysfs: Add missing newlines when printing
 {max,dimm}_location
To:     Borislav Petkov <bp@alien8.de>
CC:     <mchehab@kernel.org>, <tony.luck@intel.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1600051734-8993-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200916170052.GO2643@zn.tnic>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <591e613e-0b53-028f-08fd-3d62a35b8c4f@huawei.com>
Date:   Thu, 17 Sep 2020 19:38:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200916170052.GO2643@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.16]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi ,

On 2020/9/17 1:00, Borislav Petkov wrote:
> On Mon, Sep 14, 2020 at 10:48:54AM +0800, Xiongfeng Wang wrote:
>> @@ -813,15 +817,21 @@ static ssize_t mci_max_location_show(struct device *dev,
>>  				     char *data)
>>  {
>>  	struct mem_ctl_info *mci = to_mci(dev);
>> -	int i;
>> +	int i, n;
>>  	char *p = data;
>> +	unsigned int len = PAGE_SIZE;
>>  
>>  	for (i = 0; i < mci->n_layers; i++) {
>> -		p += sprintf(p, "%s %d ",
>> +		n = snprintf(p, len, "%s %d ",
>>  			     edac_layer_name[mci->layers[i].type],
>>  			     mci->layers[i].size - 1);
>> +		p += n;
>> +		len -= n;
> 
> What happens if that subtraction causes len to wrap around and become a
> huge positive unsigned integer?
> 
>> +		if (!len)
> 
> Would that test still work?

I am not sure if snprintf will return a value larger than its second input
paramter 'size'. But we can also check if 'len' is less than 0. It's better.

> 
> IOW, I did this to your patch ontop. Note that I've moved the "p"
> pointer incrementation after the length check so that the pointer
> doesn't overflow too:

Thanks. I will add it in the next version.

> 
> ---
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index bf0e075fb635..fa0551c81e63 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -817,19 +817,22 @@ static ssize_t mci_max_location_show(struct device *dev,
>  				     char *data)
>  {
>  	struct mem_ctl_info *mci = to_mci(dev);
> -	int i, n;
> +	int len = PAGE_SIZE;
>  	char *p = data;
> -	unsigned int len = PAGE_SIZE;
> +	int i, n;
>  
>  	for (i = 0; i < mci->n_layers; i++) {
>  		n = snprintf(p, len, "%s %d ",
>  			     edac_layer_name[mci->layers[i].type],
>  			     mci->layers[i].size - 1);
> -		p += n;
> +
>  		len -= n;
> -		if (!len)
> +		if (len < 0)

Not sure whether we need to check 'len' equals to 0.
if (len <= 0) ?


>  			goto out;
> +
> +		p += n;
>  	}
> +
>  	p += snprintf(p, len, "\n");
>  out:
>  	return p - data;
> 

Thanks,
XIongfeng
