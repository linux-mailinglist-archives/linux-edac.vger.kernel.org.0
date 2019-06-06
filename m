Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCE23730E
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2019 13:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfFFLiB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jun 2019 07:38:01 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17325 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfFFLiB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jun 2019 07:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559821080; x=1591357080;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Ce2wemERCNuhe1r8FDKdwgvoDhrRfIiwIFwMCaHmYng=;
  b=GeGeXRa4xrreIU0xvVwTJV2SqBYxzEbea3CxlpvhLNKaXlHHD/dumdAQ
   sfY5ogRjdcO/Qx577b1Kra6KVIP8oQLkVWJ1d3J3cwm9cKY3BOyFIVRlf
   I37zYW6wg9ZaxiZmKPjVnzz7SmlX3k1cRsE3ukPzCExwre157e5J3Tgfn
   Y=;
X-IronPort-AV: E=Sophos;i="5.60,559,1549929600"; 
   d="scan'208";a="769248080"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 06 Jun 2019 11:37:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id DB23CA2881;
        Thu,  6 Jun 2019 11:37:56 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 6 Jun 2019 11:37:56 +0000
Received: from [10.125.238.52] (10.43.160.177) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 6 Jun
 2019 11:37:48 +0000
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     James Morse <james.morse@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>, Borislav Petkov <bp@alien8.de>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
 <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
 <20190531051400.GA2275@cz.tnic>
 <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
 <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <71da083e-1a74-cf86-455d-260a34ee01fd@amazon.com>
Date:   Thu, 6 Jun 2019 14:37:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.177]
X-ClientProxiedBy: EX13D14UWC003.ant.amazon.com (10.43.162.19) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


>> Disagree. The various drivers don't depend on each other.
>> I think we should keep the drivers separated as they are distinct and independent IP blocks.
> But they don't exist in isolation, they both depend on the integration-choices/firmware
> that makes up your platform.
>
> Other platforms may have exactly the same IP blocks, configured differently, or with
> different features enabled in firmware. This means we can't just probe the driver based on
> the presence of the IP block, we need to know the integration choices and firmware
> settings match what the driver requires.
>
> (Case in point, that A57 ECC support is optional, another A57 may not have it)
>
> Descriptions of what firmware did don't really belong in the DT. Its not a hardware property.
>
> This is why its better to probe this stuff based on the machine-compatible/platform-name,
> not the presence of the IP block in the DT.
>
>
> Will either of your separate drivers ever run alone? If they're probed from the same
> machine-compatible this won't happen.
>
>
> How does your memory controller report errors? Does it send back some data with an invalid
> checksum, or a specific poison/invalid flag? Will the cache report this as a cache error
> too, if its an extra signal, does the cache know what it is?
>
> All these are integration choices between the two IP blocks, done as separate drivers we
> don't have anywhere to store that information. Even if you don't care about this, making
> them separate drivers should only be done to make them usable on other platforms, where
> these choices may have been different.

James,

Thanks for the prompt responses.

 From our perspective, l1/l2 has nothing to do with the ddr memory 
controller.

Its right that they both use same edac subsystem but they are using 
totally different APIs of it.

We also even want to have separate control for enabling/disabling l1/l2 
edac vs memory controller edac.

Even from technical point-of-view L1/L2 UE collection method is totally 
different from collecting memory-controller UE. (CPU exception vs actual 
interrupts).

So there is less reason why to combine them vs giving each one its own 
file, e.g. al_mc_edac, al_l1_l2_edac (I even don't see why Hanna 
combined l1 and l2...)

As we don't have any technical relation between the two we would rather 
avoid this combination.

Also, Lets assume we have different setups with different memory 
controllers, having a dt binding to control the difference is super easy 
and flexible.

Would having a dedicated folder for amazon ease the move to separate files?

Thanks,

Talel.

>
> Thanks,
>
> James
