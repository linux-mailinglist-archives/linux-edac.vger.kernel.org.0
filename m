Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92704D2704
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 12:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfJJKSY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 06:18:24 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:2443 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJJKSY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 06:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570702703; x=1602238703;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gzt3BjERRKwc4CaUYcTEPU+kmi2VWRj9rm7SI3fPcl0=;
  b=XDWKo5u6/miMwRab6aFZ6FGzvh7T3HN5XcjBrtpFQ0kiryTUkENJ6qRQ
   WZ6lWHn4o8Ht0GEwZh+ef69RggH39k3epeS26wpAmxyre6gw/4ftKtL/T
   Tb/X6PkGR4fafEMM4DXY1UL3PN099mcCX4e+T8U8f7+1KAd8lMB/A/Iiw
   M=;
X-IronPort-AV: E=Sophos;i="5.67,279,1566864000"; 
   d="scan'208";a="421467619"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 Oct 2019 10:18:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 9360FC5A7D;
        Thu, 10 Oct 2019 10:18:17 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 10:18:17 +0000
Received: from [10.125.238.52] (10.43.160.180) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 10:18:08 +0000
Subject: Re: [PATCH v3 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
To:     Rob Herring <robh@kernel.org>
CC:     <mark.rutland@arm.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <paulmck@linux.ibm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <hhhawa@amazon.com>,
        <ronenk@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <amirkl@amazon.com>, <barakw@amazon.com>
References: <1570103363-21486-1-git-send-email-talel@amazon.com>
 <1570103363-21486-2-git-send-email-talel@amazon.com>
 <20191009191625.GA8179@bogus>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <645f7af1-cefc-0af2-9fbd-e73e5305a268@amazon.com>
Date:   Thu, 10 Oct 2019 13:18:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191009191625.GA8179@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D08UWC002.ant.amazon.com (10.43.162.168) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 10/9/2019 10:16 PM, Rob Herring wrote:
> On Thu, Oct 03, 2019 at 02:49:22PM +0300, Talel Shenhar wrote:
>> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> ---
>>   .../bindings/edac/amazon,al-mc-edac.yaml           | 40 ++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>> new file mode 100644
>> index 0000000..33da051
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/edac/amazon,al-mc-edac.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amazon's Annapurna Labs Memory Controller EDAC
>> +
>> +maintainers:
>> +  - Talel Shenhar <talel@amazon.com>
>> +  - Talel Shenhar <talelshenhar@gmail.com>
>> +
>> +description: |
>> +  EDAC node is defined to describe on-chip error detection and correction for
>> +  Amazon's Annapurna Labs Memory Controller.
>> +
>> +properties:
>> +
>> +  compatible:
>> +    - const: "amazon,al-mc-edac"
> Fails 'make dt_binding_check'. Drop the '-' as a property is not a list.
>
> The "" are also unnecessary.
ack, shall be part of v4
>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    edac@f0080000 {
>> +      compatible = "amazon,al-mc-edac";
>> +      reg = <0x0 0xf0080000 0x0 0x00010000>;
>> +      interrupt-parent = <&amazon_al_system_fabric>;
>> +      interrupt-names = "ue";
> Need to document the name or drop as -names on a single entry is
> pointless.

actually, there are 2 interrupts possible here. so will also fix the 
maxItems of interrupts. will also add the documentation.

shall be part of v4.

>
>> +      interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
>> +    };
>> -- 
>> 2.7.4
>>
