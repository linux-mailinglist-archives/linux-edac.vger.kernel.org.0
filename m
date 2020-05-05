Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513C31C5053
	for <lists+linux-edac@lfdr.de>; Tue,  5 May 2020 10:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgEEIaM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 May 2020 04:30:12 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:37554 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEIaM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 May 2020 04:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588667412; x=1620203412;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=DB9DoB4dAy+tSnSPYNEN9V0bWmWAez3y3wdWalkVI28=;
  b=SFAkZMtUg5437tJkyaAkUwpBwgD3+MhqYc/icE9iGSwTJLJUrNv6WHGj
   CJyHD4dcbWtK9C4lOqdjx2aWSKLFAwoHshqaj9rFxan13KwR2nAOSz8JT
   hv2ibk0bad86MFAGCZansOPwiyfVOf0Z0hDRdK8WLryD1y3w4J0duiZC6
   A=;
IronPort-SDR: m8F2JJq921i8U2hTPFX0OwXLwYDtpl5tpc29M2DH+3KrOTRiknwDPZ2TJ0WOTyoRcP0j5qH4tC
 TRGUvBBx98GA==
X-IronPort-AV: E=Sophos;i="5.73,354,1583193600"; 
   d="scan'208";a="32985955"
Subject: Re: [PATCH v9 3/3] edac: Add support for Amazon's Annapurna Labs L2 EDAC
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 05 May 2020 08:30:08 +0000
Received: from EX13MTAUEB002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 77E8EA1D93;
        Tue,  5 May 2020 08:30:07 +0000 (UTC)
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 08:30:05 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 08:30:05 +0000
Received: from [192.168.17.227] (10.1.213.30) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 5 May 2020 08:30:02 +0000
To:     Robert Richter <rrichter@marvell.com>, <bp@alien8.de>
CC:     <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <barakw@amazon.com>
References: <20200129195016.956-1-hhhawa@amazon.com>
 <20200129195016.956-4-hhhawa@amazon.com>
 <20200310134713.n4gtrgtjdjymmgm5@rric.localdomain>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <8bd3e95c-c45e-383a-f1a3-d60be5c2ff19@amazon.com>
Date:   Tue, 5 May 2020 11:30:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200310134713.n4gtrgtjdjymmgm5@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 3/10/2020 3:47 PM, Robert Richter wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On 29.01.20 21:50:16, Hanna Hawa wrote:
>> Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
>> report L2 errors.
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
>> ---
>>   MAINTAINERS               |   5 +
>>   drivers/edac/Kconfig      |   8 ++
>>   drivers/edac/Makefile     |   1 +
>>   drivers/edac/al_l2_edac.c | 270 ++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 284 insertions(+)
>>   create mode 100644 drivers/edac/al_l2_edac.c
> 
> Hanna, most of the review comments by Boris for patch #1 (al_l1_edac)
> apply here too. Please address them.

Hi Boris, Robert,

Sorry for not getting back to you sooner, will address comments on both 
files and upload new patchset ASAP.

Thanks,
Hanna

> 
> Thanks,
> 
> -Robert
> 
