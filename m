Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC407DB78
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2019 14:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfHAM3R (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Aug 2019 08:29:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:5741 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfHAM3R (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Aug 2019 08:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564662555; x=1596198555;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4AmOigJ4ocZphYjcxGxHhBcudLJNjIgIxaYh+OpsGYM=;
  b=bkE4uUL43/YAF/adymUcxKLCZKzA8bquOuVr3Gs18TP8hkFoYCvX0x31
   ooahV21YZ7vwz/kDYbZGHNJwXymJzTUlioMIRjDdIxkkVw/vW/a8QgSK5
   E5y/3UpU152wW9HozS6E/LyKy3EoCf81no5n1xwBMzahQuvK4fhP6Gqww
   c=;
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="689935103"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 01 Aug 2019 12:29:13 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id DB8EEA27A4;
        Thu,  1 Aug 2019 12:29:12 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 12:29:12 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 12:29:11 +0000
Received: from [10.107.3.19] (10.107.3.19) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Thu, 1 Aug 2019 12:29:05 +0000
Subject: Re: [RFC 1/1] edac: Add a counter parameter for
 edac_device_handle_ue/ce()
To:     Robert Richter <rric@kernel.org>
CC:     <thor.thayer@linux.intel.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <morbidrsa@gmail.com>,
        <ralf@linux-mips.org>, <david.daney@cavium.com>,
        <andy.gross@linaro.org>, <david.brown@linaro.org>,
        <ckadabi@codeaurora.org>, <vnkgutta@codeaurora.org>,
        <jglauber@cavium.com>, <khuong@os.amperecomputing.com>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
 <20190801113548.7leooh57gihixen5@rric.localdomain>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <7d6aac9e-20e5-3901-a423-d76ac917b251@amazon.com>
Date:   Thu, 1 Aug 2019 15:29:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801113548.7leooh57gihixen5@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 8/1/2019 2:35 PM, Robert Richter wrote:
> On 15.07.19 13:53:07, Hanna Hawa wrote:
>> Add a counter parameter in order to avoid losing errors count for edac
>> device, the error count reports the number of errors reported by an edac
>> device similar to the way MC_EDAC do.
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
>> ---
>>   drivers/edac/altera_edac.c      | 20 ++++++++++++--------
>>   drivers/edac/amd8111_edac.c     |  6 +++---
>>   drivers/edac/cpc925_edac.c      |  4 ++--
>>   drivers/edac/edac_device.c      | 18 ++++++++++--------
>>   drivers/edac/edac_device.h      |  8 ++++++--
>>   drivers/edac/highbank_l2_edac.c |  4 ++--
>>   drivers/edac/mpc85xx_edac.c     |  4 ++--
>>   drivers/edac/mv64x60_edac.c     |  4 ++--
>>   drivers/edac/octeon_edac-l2c.c  | 20 ++++++++++----------
>>   drivers/edac/octeon_edac-pc.c   |  6 +++---
>>   drivers/edac/qcom_edac.c        |  8 ++++----
>>   drivers/edac/thunderx_edac.c    | 10 +++++-----
>>   drivers/edac/xgene_edac.c       | 26 +++++++++++++-------------
>>   13 files changed, 74 insertions(+), 64 deletions(-)
> 
>> diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
>> index 1aaba74..cf1a1da 100644
>> --- a/drivers/edac/edac_device.h
>> +++ b/drivers/edac/edac_device.h
>> @@ -290,23 +290,27 @@ extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
>>    *	perform a common output and handling of an 'edac_dev' UE event
>>    *
>>    * @edac_dev: pointer to struct &edac_device_ctl_info
>> + * @error_count: number of errors of the same type
>>    * @inst_nr: number of the instance where the UE error happened
>>    * @block_nr: number of the block where the UE error happened
>>    * @msg: message to be printed
>>    */
>>   extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>> -				int inst_nr, int block_nr, const char *msg);
>> +				  u16 error_count, int inst_nr, int block_nr,
>> +				  const char *msg);
>>   /**
>>    * edac_device_handle_ce():
>>    *	perform a common output and handling of an 'edac_dev' CE event
>>    *
>>    * @edac_dev: pointer to struct &edac_device_ctl_info
>> + * @error_count: number of errors of the same type
>>    * @inst_nr: number of the instance where the CE error happened
>>    * @block_nr: number of the block where the CE error happened
>>    * @msg: message to be printed
>>    */
>>   extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> 
> How about renaming this to __edac_device_handle_ce() and then have 2
> macros for:
> 
>   * edac_device_handle_ce() to keep old i/f.
> 
>   * edac_device_handle_ce_count(), with count parameter added.
> 
> Same for uncorrectable errors.
> 
> Code of other driver can be kept as it is then.

Don't you think it'll be confused to have different APIs between EDAC_MC 
and EDAC_DEVICE?
(in MC the count passed as part of edac_mc_handle_error())

I don't have strong objection, the change for other drivers is not that 
hard.

> 
> Thanks,
> 
> -Robert
> 
>> -				int inst_nr, int block_nr, const char *msg);
>> +				  u16 error_count, int inst_nr, int block_nr,
>> +				  const char *msg);
