Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718DB26EFB6
	for <lists+linux-edac@lfdr.de>; Fri, 18 Sep 2020 04:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgIRChf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 22:37:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgIRChe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Sep 2020 22:37:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8BFCC36520A4953305A4;
        Fri, 18 Sep 2020 10:37:31 +0800 (CST)
Received: from [10.174.178.16] (10.174.178.16) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 10:37:28 +0800
Subject: Re: [PATCH v2] EDAC/mc_sysfs: Add missing newlines when printing
 {max,dimm}_location
To:     Borislav Petkov <bp@alien8.de>
CC:     <mchehab@kernel.org>, <tony.luck@intel.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1600051734-8993-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200916170052.GO2643@zn.tnic>
 <591e613e-0b53-028f-08fd-3d62a35b8c4f@huawei.com>
 <20200917162537.GL31960@zn.tnic>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <8ac6d481-e1c4-108e-dbec-b1e86b2d0e86@huawei.com>
Date:   Fri, 18 Sep 2020 10:37:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200917162537.GL31960@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.16]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2020/9/18 0:25, Borislav Petkov wrote:
> On Thu, Sep 17, 2020 at 07:38:57PM +0800, Xiongfeng Wang wrote:
>> I am not sure if snprintf will return a value larger than its second input
>> paramter 'size'.
> 
> The comment over snprintf() says
> 
>  * The return value is the number of characters which would be
>  * generated for the given input, excluding the trailing null,
>  * as per ISO C99.  If the return is greater than or equal to
>  * @size, the resulting string is truncated.
> 
> And let's try it, see diff at the end. Now look what that produces:
> 
> [    2.594796] kernel_init: len: 16, str: [A lo]
> 
> it returns 16 for len even though the buffer is 5 chars long. So in our
> patch, we'd increment by 16 which would be wrong.
> 
> Now let's use scnprintf():
> 
> [    2.700142] kernel_init: len: 4, str: [A lo]
> 
> Much better. Lemme do that.
> 
>> Not sure whether we need to check 'len' equals to 0.
>> if (len <= 0) ?
> 
> Yeah, lemme fix that too, so we have now incrementally ontop:


Thansk a lot. I will send another version. Also I will change the 'snprintf' in
'dimmdev_location_show()' to 'scnprintf'

Thanks,
Xiongfeng

> 
> ---
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index fa0551c81e63..c56e0004b39e 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -822,18 +822,17 @@ static ssize_t mci_max_location_show(struct device *dev,
>  	int i, n;
>  
>  	for (i = 0; i < mci->n_layers; i++) {
> -		n = snprintf(p, len, "%s %d ",
> -			     edac_layer_name[mci->layers[i].type],
> -			     mci->layers[i].size - 1);
> -
> +		n = scnprintf(p, len, "%s %d ",
> +			      edac_layer_name[mci->layers[i].type],
> +			      mci->layers[i].size - 1);
>  		len -= n;
> -		if (len < 0)
> +		if (len <= 0)
>  			goto out;
>  
>  		p += n;
>  	}
>  
> -	p += snprintf(p, len, "\n");
> +	p += scnprintf(p, len, "\n");
>  out:
>  	return p - data;
>  }
> ---
> 
> Test diff:
> 
> ---
> diff --git a/init/main.c b/init/main.c
> index ae78fb68d231..e2d6110d3a3d 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1397,7 +1397,8 @@ void __weak free_initmem(void)
>  
>  static int __ref kernel_init(void *unused)
>  {
> -	int ret;
> +	char str[5];
> +	int ret, len;
>  
>  	kernel_init_freeable();
>  	/* need to finish all async __init code before freeing the memory */
> @@ -1419,6 +1420,11 @@ static int __ref kernel_init(void *unused)
>  
>  	do_sysctl_args();
>  
> +	len = snprintf(str, 5, "A longer string\n");
> +
> +	pr_info("%s: len: %d, str: [%s]\n",
> +		__func__, len, str);
> +
>  	if (ramdisk_execute_command) {
>  		ret = run_init_process(ramdisk_execute_command);
>  		if (!ret)
> 
