Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C75CE08B
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2019 13:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfJGLeZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Oct 2019 07:34:25 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:13994 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfJGLeZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Oct 2019 07:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570448063; x=1601984063;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1YbtA/WEl6PxCyNf7o7k7KSePi3o5gW3urK3q2YrmNg=;
  b=aG4VfqZUCGr5E15Vka+p/o9cv+SBuoN+AumejQtaq5Bx0Tn6bJcDh9BU
   ePMro4KkQDB3uDukc7hwjyhqWTxqxfJAKX1lt/XgPpWspG5rxasLNSQys
   cnySjOoUk5fqKBA00vIQOpTfvrTzGpHWZ53M+uQrusVvWvaU1ne750xrg
   c=;
X-IronPort-AV: E=Sophos;i="5.67,268,1566864000"; 
   d="scan'208";a="426527686"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 07 Oct 2019 11:34:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id AFDCDA1F08;
        Mon,  7 Oct 2019 11:34:18 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 11:34:18 +0000
Received: from [10.125.238.52] (10.43.162.245) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 7 Oct
 2019 11:34:09 +0000
Subject: Re: [UNVERIFIED SENDER] Re: [PATCH v4 2/2] soc: amazon: al-pos-edac:
 Introduce Amazon's Annapurna Labs POS EDAC driver
To:     Marc Zyngier <maz@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <arnd@arndb.de>,
        <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <paulmck@linux.ibm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
References: <1570102361-11696-1-git-send-email-talel@amazon.com>
 <1570102361-11696-3-git-send-email-talel@amazon.com>
 <86k19gztil.wl-maz@kernel.org>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <6815f9e9-f250-bd62-33b3-e3ab30aa47e2@amazon.com>
Date:   Mon, 7 Oct 2019 14:34:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <86k19gztil.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.162.245]
X-ClientProxiedBy: EX13D03UWA001.ant.amazon.com (10.43.160.141) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

thanks for the review

On 10/7/2019 2:26 PM, Marc Zyngier wrote:
> On Thu, 03 Oct 2019 12:32:41 +0100,
> Talel Shenhar <talel@amazon.com> wrote:
>> +	log1 = readl(al_pos->mmio_base + AL_POS_ERROR_LOG_1);
> I already commented on the misuse of strict accesses. Unless you can
> explain and document *why* you need the extra ordering, please use
> relaxed accesses.
agreeing on relaxed, shall be part of v5
>
>> +
>> +	if (al_pos->irq > 0) {
>> +		ret = devm_request_irq(&pdev->dev,
>> +				       al_pos->irq,
>> +				       al_pos_irq_handler,
>> +				       0,
>> +				       pdev->name,
>> +				       pdev);
>> +		if (ret != 0) {
>> +			dev_err(&pdev->dev,
>> +				"failed to register to irq %d (%d)\n",
>> +				al_pos->irq, ret);
>> +			goto err_remove_edac;
> Would it be worth continuing without interrupts? After all, the
> interrupt seems to be an optional part of the device...

indeed interrupts are optional, however, this is optional for some of 
the systems.

in some cases (and some systems), this error event is critical and 
should cause fast handling. for those, we define the interrupts.

so bottom line, i would like to keep this error in case of error in 
interrupt.

>
> Thanks,
>
> 	M.
>
