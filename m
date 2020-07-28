Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9FE2305CC
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jul 2020 10:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgG1Iw2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Jul 2020 04:52:28 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:59844 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgG1Iw1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Jul 2020 04:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595926346; x=1627462346;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=O/7K7U+F4Hb9vBOmcbLlJMixNNgJMZmG2fifr+2GFKA=;
  b=c9srD6dU/0MjULvx9YelTSIMnxQ9VHC1GI18qaf5FalkjdAJMqFINV+r
   10NL/cQf9O1I0EEWERGVWWvZzKy/k+vp0c8cvWeId1I5UoOwjZIzZEAEF
   FHpPZnDwoWaA5u0AARfSozzFbaOD4IDkUWEb3OawK7b7deFhtBePaR/MP
   Y=;
IronPort-SDR: v5AyA2WaLe/fVEXJlCh/dAYzaCRzy9KqDqZk8MHTdyswVU5rz0vbDEfC+9dZA+H0U+yEWI5vzp
 JsrIxpes6BgQ==
X-IronPort-AV: E=Sophos;i="5.75,405,1589241600"; 
   d="scan'208";a="44426518"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 28 Jul 2020 08:52:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 04A21A2704;
        Tue, 28 Jul 2020 08:52:22 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 08:52:22 +0000
Received: from [192.168.5.124] (10.43.161.145) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 28 Jul
 2020 08:52:13 +0000
Subject: Re: [PATCH v8 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
To:     Rob Herring <robh@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <mchehab@kernel.org>, <davem@davemloft.net>,
        <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>,
        <ronenk@amazon.com>, <james.morse@arm.com>, <bp@alien8.de>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <hhhawa@amazon.com>, <hanochu@amazon.com>, <mark.rutland@arm.com>,
        <eitan@amazon.com>, <will@kernel.org>,
        <nicolas.ferre@microchip.com>, <jonnyc@amazon.com>,
        <gregkh@linuxfoundation.org>
References: <20200726191555.5210-1-talel@amazon.com>
 <20200726191555.5210-2-talel@amazon.com> <20200727181424.GA639053@bogus>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <a07d6f7e-eae7-aa14-972c-72e69460b1e9@amazon.com>
Date:   Tue, 28 Jul 2020 11:52:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727181424.GA639053@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D10UWB001.ant.amazon.com (10.43.161.111) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 7/27/2020 9:14 PM, Rob Herring wrote:
> On Sun, 26 Jul 2020 22:15:54 +0300, Talel Shenhar wrote:
>> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../bindings/edac/amazon,al-mc-edac.yaml      | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.example.dt.yaml: example-0: edac@f0080000:reg:0: [0, 4027056128, 0, 65536] is too long
>
>
> See https://patchwork.ozlabs.org/patch/1336532
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>
> Please check and re-submit.

Thanks Rob,

Indeed I am not able to see this error.

Even tried updating dt-schema.

Even targeted check didn't give anything:

linux-ras$ make dt_binding_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
   CHKDT Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
   DTC 
Documentation/devicetree/bindings/edac/amazon,al-mc-edac.example.dt.yaml
   CHECK 
Documentation/devicetree/bindings/edac/amazon,al-mc-edac.example.dt.yaml

ill look into it and publish v9.

>
