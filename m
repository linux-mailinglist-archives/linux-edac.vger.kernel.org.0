Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2AB2FBBA
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2019 14:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfE3MwS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 08:52:18 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:50270 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3MwS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 30 May 2019 08:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559220737; x=1590756737;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=O4eMaMbEMmqb10KzGuvzyUaJ2EVJ+M/kW9KVSV6qXKU=;
  b=ArXgolZZFHDwKJ+koSulk8zmrsZMqcQi6IsZ9EY2JVEl5hMPCr67tb1x
   wLWwnf81nNdl5MVt7ZO6gur7CgKoL3I5L9lvnuwyCHnkBTeossGezYgSz
   4pgQ3NRpdlZgZtzO+Dg9NGOubmqMKbwGo8AL8ubGEq5WsqU+8AbeNkI+m
   M=;
X-IronPort-AV: E=Sophos;i="5.60,531,1549929600"; 
   d="scan'208";a="677188830"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 30 May 2019 12:52:11 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 18792A221B;
        Thu, 30 May 2019 12:52:07 +0000 (UTC)
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 12:52:05 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 12:52:04 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.125.236.61) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 30 May 2019 12:52:01 +0000
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <paulmck@linux.ibm.com>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <20190530115732.GB14088@kroah.com>
From:   <hhhawa@amazon.com>
Message-ID: <0ebfe8d7-3e0c-e0be-abd5-5e10b7d4b6aa@amazon.com>
Date:   Thu, 30 May 2019 15:52:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530115732.GB14088@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/30/19 2:57 PM, Greg KH wrote:
> On Thu, May 30, 2019 at 01:15:29PM +0300, Hanna Hawa wrote:
>> +static void al_a57_edac_cpumerrsr(void *arg)
>> +{
>> +	struct edac_device_ctl_info *edac_dev =
>> +		(struct edac_device_ctl_info *)arg;
> No need for casting anything here, just assign it.  Doesn't checkpatch
> catch this type of thing these days?  You did run it, right?

I did, but checkpatch didn't catch this. I'll fix in next patch-set.

Thanks for your review.


Hanna

>
> Please fix that up everywhere you do this in the driver.
>
>
> thanks,
>
> greg k-h


