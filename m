Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2782DA63D9
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2019 10:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfICI26 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Sep 2019 04:28:58 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:22125 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfICI26 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Sep 2019 04:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567499336; x=1599035336;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=P6z13MI1ARt5SXT8pi9jJIecTNyGVKt5gyr5rY/6iws=;
  b=bz+mTsoFUChshbRTg7pjlPidR+ZfOrJTTmT6pSJKo3vaMVX/zu8w3LxZ
   a/l9qNgjX1nVNQtx5b9PT2TmieWrFO5CbXyys091ZbYJ57eGNN6UK9IU+
   Y9dVPqDypoi3smv0c7uLAAMSBDr2c4bcOmUvjpXqBEWEzF+Q2od+ewuac
   0=;
X-IronPort-AV: E=Sophos;i="5.64,462,1559520000"; 
   d="scan'208";a="419144230"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 03 Sep 2019 08:28:55 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id F1608A1D4E;
        Tue,  3 Sep 2019 08:28:50 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 08:28:50 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 08:28:50 +0000
Received: from [10.85.97.90] (10.85.97.90) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Tue, 3 Sep 2019 08:28:43 +0000
Subject: Re: [PATCH v3 4/4] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
To:     Robert Richter <rrichter@marvell.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
 <1563197049-12679-5-git-send-email-hhhawa@amazon.com>
 <20190903072655.kz5x7n3477dg4yap@rric.localdomain>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <2bce020a-bf7e-1d54-48c3-0aa6d23c84d8@amazon.com>
Date:   Tue, 3 Sep 2019 11:28:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903072655.kz5x7n3477dg4yap@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/3/2019 10:27 AM, Robert Richter wrote:
> On 15.07.19 16:24:09, Hanna Hawa wrote:
>> Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
>> report L2 errors.
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
>> ---
>>   MAINTAINERS               |   6 ++
>>   drivers/edac/Kconfig      |   8 ++
>>   drivers/edac/Makefile     |   1 +
>>   drivers/edac/al_l2_edac.c | 187 ++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 202 insertions(+)
>>   create mode 100644 drivers/edac/al_l2_edac.c
> 
>  From a brief look at it, it seems some of my comments from 2/4 apply
> here too. Please look through it.

Thanks for your review, will look and fix on top of v5.

Thanks,
Hanna

> 
> -Robert
> 
