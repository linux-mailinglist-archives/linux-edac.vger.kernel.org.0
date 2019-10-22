Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D17DFF32
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2019 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbfJVIO1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Oct 2019 04:14:27 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:59546 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388055AbfJVIO1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Oct 2019 04:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571732066; x=1603268066;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uZ1Nc7xFlhZlA6hWP8C46y6MYqzMnnimoCEDMdoW5BA=;
  b=docP2kVWCzaIyCDL4vdH0+GJWPTf5Eu6ZfKLMr1t7aa+x409A018Ogvt
   ZhTi4dzq16wSQcTapQ+3SQWIjzpgNRDa0em33a3FbGAgcslOKKVwQbSHZ
   37UgVzXJrPjN60sUEpbwIzj7RGrH9fRa1wPDjz+4qgowdkjzBgLIcFKDv
   s=;
X-IronPort-AV: E=Sophos;i="5.67,326,1566864000"; 
   d="scan'208";a="425788157"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 22 Oct 2019 08:14:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id 0E5F6A22B7;
        Tue, 22 Oct 2019 08:14:20 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 22 Oct 2019 08:14:20 +0000
Received: from [10.125.238.52] (10.43.160.153) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 22 Oct
 2019 08:14:11 +0000
Subject: Re: [PATCH v4 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
To:     Rob Herring <robh@kernel.org>
CC:     <maz@kernel.org>, <mark.rutland@arm.com>, <arnd@arndb.de>,
        <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <paulmck@linux.ibm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
References: <1570708454-10784-1-git-send-email-talel@amazon.com>
 <1570708454-10784-2-git-send-email-talel@amazon.com>
 <20191011132904.GA15595@bogus>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <9e1a863c-9523-4e67-b000-4b429ae7616e@amazon.com>
Date:   Tue, 22 Oct 2019 11:14:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011132904.GA15595@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.153]
X-ClientProxiedBy: EX13D11UWB001.ant.amazon.com (10.43.161.53) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Thanks Rob,

On 10/11/2019 4:29 PM, Rob Herring wrote:
> On Thu, Oct 10, 2019 at 02:54:13PM +0300, Talel Shenhar wrote:
>> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> ---
>>   .../bindings/edac/amazon,al-mc-edac.yaml           | 50 ++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>> new file mode 100644
>> index 00000000..f66b094
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: GPL-2.0
> Forgot to mention, please make new bindings (GPL-2.0-only OR BSD-2-Clause).
ack, shall be part of v5
> + interrupts:
>> +    maxItems: 2
>> +    items:
>> +      - description: uncorrectable error interrupt
>> +      - description: correctable error interrupt
>> +
>> +  interrupt-names:
>> +    maxItems: 2
>> +    items:
>> +      - const: ue
>> +      - const: ce
> Now the example fails to build:
>
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.example.dt.yaml:
> edac@f0080000: interrupt-names: ['ue'] is too short
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.example.dt.yaml:
> edac@f0080000: interrupts: [[20, 4]] is too short
>
> You either need to always have the CE irq or add 'minItems: 1' to both.

Indeed adding the minItems to 1 solves this.

However, shouldn't it really be 0? interrupts are not mandatory?

What is the way to capture this in the new binding?

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    edac@f0080000 {
> +      compatible = "amazon,al-mc-edac";
> +      reg = <0x0 0xf0080000 0x0 0x00010000>;
> +      interrupt-parent = <&amazon_al_system_fabric>;
> +      interrupt-names = "ue";
> +      interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> -- 
> 2.7.4
>
