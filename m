Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3BC4AA2
	for <lists+linux-edac@lfdr.de>; Wed,  2 Oct 2019 11:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfJBJ2H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Oct 2019 05:28:07 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:29812 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJBJ2H (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Oct 2019 05:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570008484; x=1601544484;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pakAPBrVlVMGqVOKoh2qW8SL/VWSbaRCbk8sgD+X+W8=;
  b=izX4SKGDZeJ1oVK0aupvfwt+09CiUwu95BHy7WxFv5JVi1mBU8BVq5XB
   DdHVZq8qM5Qond9n7Oid8BrZZkxx65EgoKj5nDZWp7rQ+2/dZTvR+o1Ga
   vf3Q5OyKt9E5+ae2XaGTkI6YcQKdBc/Gu7pOokjvLFgyEco8JsnVsWhz6
   g=;
X-IronPort-AV: E=Sophos;i="5.64,573,1559520000"; 
   d="scan'208";a="838652386"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 02 Oct 2019 09:26:18 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 68A25C05B3;
        Wed,  2 Oct 2019 09:26:00 +0000 (UTC)
Received: from EX13D08UEB004.ant.amazon.com (10.43.60.142) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 2 Oct 2019 09:25:59 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D08UEB004.ant.amazon.com (10.43.60.142) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 2 Oct 2019 09:25:59 +0000
Received: from [10.95.86.195] (10.95.86.195) by mail-relay.amazon.com
 (10.43.60.129) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Wed, 2 Oct 2019 09:25:56 +0000
Subject: Re: [PATCH v4 1/2] edac: Add an API for edac device to report for
 multiple errors
To:     Borislav Petkov <bp@alien8.de>
CC:     <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>
References: <20190923191741.29322-1-hhhawa@amazon.com>
 <20190923191741.29322-2-hhhawa@amazon.com> <20190930145046.GH29694@zn.tnic>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <5263edad-e0c9-a05a-72d7-e69c59d78d8f@amazon.com>
Date:   Wed, 2 Oct 2019 12:25:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190930145046.GH29694@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/30/2019 5:50 PM, Borislav Petkov wrote:
> On Mon, Sep 23, 2019 at 08:17:40PM +0100, Hanna Hawa wrote:
>> +void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>> +			int inst_nr, int block_nr, const char *msg)
>> +{
>> +	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
>> +}
>> +EXPORT_SYMBOL_GPL(edac_device_handle_ce);
> 
> Eww, I don't like that: exporting the function *and* the __ counterpart.
> The user will get confused and that is unnecessary.
> 
> See below for a better version. This way you solve the whole deal with a
> single patch.
I'm okay with this version, minor comment below.

> 
> ---
> From: Hanna Hawa <hhhawa@amazon.com>
> Date: Mon, 23 Sep 2019 20:17:40 +0100
> Subject: [PATCH] EDAC/device: Rework error logging API
> 
> Make the main workhorse the "count" functions which can log a @count
> of errors. Have the current APIs edac_device_handle_{ce,ue}() call
> the _count() variants and this way keep the exported symbols number
> unchanged.
> 
>   [ bp: Rewrite. ]
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: benh@amazon.com
> Cc: dwmw@amazon.co.uk
> Cc: hanochu@amazon.com
> Cc: James Morse <james.morse@arm.com>
> Cc: jonnyc@amazon.com
> Cc: linux-edac <linux-edac@vger.kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: ronenk@amazon.com
> Cc: talel@amazon.com
> Cc: Tony Luck <tony.luck@intel.com>
> Link: https://lkml.kernel.org/r/20190923191741.29322-2-hhhawa@amazon.com
> ---
>   drivers/edac/edac_device.c | 44 ++++++++++++++++---------------
>   drivers/edac/edac_device.h | 54 ++++++++++++++++++++++++++++++--------
>   2 files changed, 66 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 65cf2b9355c4..d4d8bed5b55d 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -555,8 +555,9 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
>   	return edac_dev->panic_on_ue;
>   }
>   
> -void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> -			int inst_nr, int block_nr, const char *msg)
> +void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
> +				 unsigned int count, int inst_nr, int block_nr,
> +				 const char *msg)
>   {
>   	struct edac_device_instance *instance;
>   	struct edac_device_block *block = NULL;

Missing count check, same in *_ue_count():
if (count)
	return;

> @@ -582,23 +583,24 @@ void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>   
>   	if (instance->nr_blocks > 0) {
>   		block = instance->blocks + block_nr;
> -		block->counters.ce_count++;
> +		block->counters.ce_count += count;
>   	}
>   
>   	/* Propagate the count up the 'totals' tree */
> -	instance->counters.ce_count++;
> -	edac_dev->counters.ce_count++;
> +	instance->counters.ce_count += count;
> +	edac_dev->counters.ce_count += count;
>   
>   	if (edac_device_get_log_ce(edac_dev))
>   		edac_device_printk(edac_dev, KERN_WARNING,
> -				"CE: %s instance: %s block: %s '%s'\n",
> -				edac_dev->ctl_name, instance->name,
> -				block ? block->name : "N/A", msg);
> +				   "CE: %s instance: %s block: %s count: %d '%s'\n",
> +				   edac_dev->ctl_name, instance->name,
> +				   block ? block->name : "N/A", count, msg);
>   }
> -EXPORT_SYMBOL_GPL(edac_device_handle_ce);
> +EXPORT_SYMBOL_GPL(edac_device_handle_ce_count);
>   
> -void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
> -			int inst_nr, int block_nr, const char *msg)
> +void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
> +				 unsigned int count, int inst_nr, int block_nr,
> +				 const char *msg)
>   {
>   	struct edac_device_instance *instance;
>   	struct edac_device_block *block = NULL;
> @@ -624,22 +626,22 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>   
>   	if (instance->nr_blocks > 0) {
>   		block = instance->blocks + block_nr;
> -		block->counters.ue_count++;
> +		block->counters.ue_count += count;
>   	}
>   
>   	/* Propagate the count up the 'totals' tree */
> -	instance->counters.ue_count++;
> -	edac_dev->counters.ue_count++;
> +	instance->counters.ue_count += count;
> +	edac_dev->counters.ue_count += count;
>   
>   	if (edac_device_get_log_ue(edac_dev))
>   		edac_device_printk(edac_dev, KERN_EMERG,
> -				"UE: %s instance: %s block: %s '%s'\n",
> -				edac_dev->ctl_name, instance->name,
> -				block ? block->name : "N/A", msg);
> +				   "UE: %s instance: %s block: %s count: %d '%s'\n",
> +				   edac_dev->ctl_name, instance->name,
> +				   block ? block->name : "N/A", count, msg);
>   
>   	if (edac_device_get_panic_on_ue(edac_dev))
> -		panic("EDAC %s: UE instance: %s block %s '%s'\n",
> -			edac_dev->ctl_name, instance->name,
> -			block ? block->name : "N/A", msg);
> +		panic("EDAC %s: UE instance: %s block %s count: %d '%s'\n",
> +		      edac_dev->ctl_name, instance->name,
> +		      block ? block->name : "N/A", count, msg);
>   }
> -EXPORT_SYMBOL_GPL(edac_device_handle_ue);
> +EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
> diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
> index 1aaba74ae411..c4c0e0bdce14 100644
> --- a/drivers/edac/edac_device.h
> +++ b/drivers/edac/edac_device.h
> @@ -286,27 +286,60 @@ extern int edac_device_add_device(struct edac_device_ctl_info *edac_dev);
>   extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
>   
>   /**
> - * edac_device_handle_ue():
> - *	perform a common output and handling of an 'edac_dev' UE event
> + * Log correctable errors.
>    *
>    * @edac_dev: pointer to struct &edac_device_ctl_info
> - * @inst_nr: number of the instance where the UE error happened
> - * @block_nr: number of the block where the UE error happened
> + * @inst_nr: number of the instance where the CE error happened
> + * @count: Number of errors to log.
> + * @block_nr: number of the block where the CE error happened
> + * @msg: message to be printed
> + */
> +void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
> +				 unsigned int count, int inst_nr, int block_nr,
> +				 const char *msg);
> +
> +/**
> + * Log uncorrectable errors.
> + *
> + * @edac_dev: pointer to struct &edac_device_ctl_info
> + * @inst_nr: number of the instance where the CE error happened
> + * @count: Number of errors to log.
> + * @block_nr: number of the block where the CE error happened
>    * @msg: message to be printed
>    */
> -extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
> -				int inst_nr, int block_nr, const char *msg);
> +void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
> +				 unsigned int count, int inst_nr, int block_nr,
> +				 const char *msg);
> +
>   /**
> - * edac_device_handle_ce():
> - *	perform a common output and handling of an 'edac_dev' CE event
> + * edac_device_handle_ce(): Log a single correctable error
>    *
>    * @edac_dev: pointer to struct &edac_device_ctl_info
>    * @inst_nr: number of the instance where the CE error happened
>    * @block_nr: number of the block where the CE error happened
>    * @msg: message to be printed
>    */
> -extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> -				int inst_nr, int block_nr, const char *msg);
> +static inline void
> +edac_device_handle_ce(struct edac_device_ctl_info *edac_dev, int inst_nr,
> +		      int block_nr, const char *msg)
> +{
> +	edac_device_handle_ce_count(edac_dev, 1, inst_nr, block_nr, msg);
> +}
> +
> +/**
> + * edac_device_handle_ue(): Log a single uncorrectable error
> + *
> + * @edac_dev: pointer to struct &edac_device_ctl_info
> + * @inst_nr: number of the instance where the UE error happened
> + * @block_nr: number of the block where the UE error happened
> + * @msg: message to be printed
> + */
> +static inline void
> +edac_device_handle_ue(struct edac_device_ctl_info *edac_dev, int inst_nr,
> +		      int block_nr, const char *msg)
> +{
> +	edac_device_handle_ue_count(edac_dev, 1, inst_nr, block_nr, msg);
> +}
>   
>   /**
>    * edac_device_alloc_index: Allocate a unique device index number
> @@ -316,5 +349,4 @@ extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>    */
>   extern int edac_device_alloc_index(void);
>   extern const char *edac_layer_name[];
> -
>   #endif
> 
