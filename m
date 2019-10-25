Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F06E525C
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2019 19:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505888AbfJYRbp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Oct 2019 13:31:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37692 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505882AbfJYRbo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Oct 2019 13:31:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id p13so1596860pll.4;
        Fri, 25 Oct 2019 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GnT6FwiHwead4VOZNmhBSr7ANR+aaNkYQiIOZPp8rq4=;
        b=Rn8L72ZtqYgKPeYtAFmvVLHs3nC5fJjz+0PUfwpGaSgE1722NOOl7L91urX0fJ6N6i
         b+FTMITlHxMnKVcC7rswIYvOf6I1xmTE35htnCpHkERWaKjhzCklnPP7W/TEHuQK8Xct
         QfnvUU3Mu6lOMav3YgKcS4FTmE0s6kaoYjGowYRB86oO4XTb27XLeFS/O+njazHh+3Jb
         LImib3Qn/Q9vUk2XZejM9l5gXnTPDT/DGXHEyhvua8D98WZ4JfXAdYnjtdTqwEi5x64h
         sBJkibu5NZKovxdZKnrMLvUcZquGJZJJoOXK71rwjj9s24OHhg1OfZ6pvh0HfCvXQx0r
         Akdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GnT6FwiHwead4VOZNmhBSr7ANR+aaNkYQiIOZPp8rq4=;
        b=jqDUrN8m2a4nC2kupPEyPiuUvrFXCPzTyZNmlua4o7Ix7hSrUzxWoBhJvvR9eujS79
         IC/KFzHqE+JT+N/5IKt5t7r1WcuUlq5SJDF6qpQv21+67YqhiB3PWj7rgdkKgOUJakWE
         VmNLcOgBRv/rGmV/2+gvBDs20JutKvQj83bfK/34LScOM+pzPiLtYmoQGtE5nKDFXhiL
         +KuWJD6LoXmhJFFKROyJX9gDbRvfQgAWK9/+JjmhY+FonCm9zKHqrDKvpuE0Mp9984yk
         MYDXp7P8a33szBVV8+foz0b3NzVEkpKEvHqC52/n64Vzz5/5UqfX66qZ0is92dsB1qI3
         YpJA==
X-Gm-Message-State: APjAAAVA2J7QruOZC5qVpNm9XWGu5HayshiJH3IONP/BhRj2wRGYZzL/
        P9Fr34iPqi6ynWT1wjlviUA=
X-Google-Smtp-Source: APXvYqwydM0+1e5/QHpMzyIncTA89uP4w6jdFp+a8+6qamGM8TW/ebqbIv5KTaTwl0doE7h2/mqbAg==
X-Received: by 2002:a17:902:b095:: with SMTP id p21mr5031126plr.159.1572024703643;
        Fri, 25 Oct 2019 10:31:43 -0700 (PDT)
Received: from [172.16.1.40] ([131.107.147.218])
        by smtp.gmail.com with ESMTPSA id b14sm2897182pfi.95.2019.10.25.10.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 10:31:43 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: arm-dmc520.txt
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "yuqing.shen@broadcom.com" <yuqing.shen@broadcom.com>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>,
        "wangglei@gmail.com" <wangglei@gmail.com>, leiwang_git@outlook.com
References: <BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com>
 <CAL_JsqJxcUr06+O_Ht5Kw0KXCWfSVC+6WMQqNxt-JehHh874hw@mail.gmail.com>
From:   Lei Wang <wangglei@gmail.com>
Message-ID: <f4b2c4b9-4999-6736-31eb-a63781013664@gmail.com>
Date:   Fri, 25 Oct 2019 10:31:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJxcUr06+O_Ht5Kw0KXCWfSVC+6WMQqNxt-JehHh874hw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Thanks James/Rob/Borislav for pointing out the email list issue. My work 
email does not work good either for this exercise. Going forward I'll 
switch to my gmail account.

And Thanks Rob for reviewing! Please see below.

>> +++ b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
>> @@ -0,0 +1,26 @@
>> +* ARM DMC-520 EDAC node
>> +
>> +Required properties:
>> +- compatible           : "brcm,dmc-520", "arm,dmc-520".
>> +- reg                  : Address range of the DMC-520 registers.
>> +- interrupts           : DMC-520 interrupt numbers. The example below specifies
>> +                         two interrupt lines for dram_ecc_errc_int and
>> +                         dram_ecc_errd_int.
>> +- interrupt-config     : This is an array of interrupt masks. For each of the
> 
> Not a standard property, so would need a vendor prefix...

Would dmc-interrupt-config as the property name work? Thanks!

> 
>> +                         above interrupt line, add one interrupt mask element to
>> +                         it. That is, there is a 1:1 mapping from each interrupt
>> +                         line to an interrupt mask. An interrupt mask can represent
>> +                         multiple interrupts being enabled. Refer to interrupt_control
>> +                         register in DMC-520 TRM for interrupt mapping. In the example
>> +                         below, the interrupt configuration enables dram_ecc_errc_int
>> +                         and dram_ecc_errd_int. And each interrupt is connected to
>> +                         a separate interrupt line.
> 
> I've gone and read thru the TRM some. This binding doesn't seem to
> correspond to the TRM at all. There are a bunch of interrupts and a
> combined interrupt, and then there's the same set for 'overflow'
> interrupts.
> 
> There's only one 'interrupt_control' reg. How do you have more that 1
> 32-bit value?

There is only one 'interrupt_control' register, for multiple interrupt 
sources. Then depending on platform hardware design, these interrupt 
sources can be wired to different physical interrupt lines.

That is, it is possible to mux interrupt sources into  interrupt lines 
for dmc520 in different ways. For example, in this particular brcm 
implementation,

Line 841: source dram_ecc_errc_int
Line 843: source dram_ecc_errd_int
Line 839: source dram_ecc_errc_int and dram_ecc_errd_int

There are two possibilities for implementing ecc counts for ce/ue. And 
we chose to use the single source line: as below, two interrupt lines 
0x349 and 0x34B, with interrupt masks 0x4 and 0x8 respectively.

Also, it's possible to implement using the combined-source line too: 
that would be one interrupt line 0x347, with interrupt mask 0xC.

This dt binding can support both by modifying the properties, without 
having to modify driver code.

 >> +
 >> +Example:
 >> +
 >> +dmc0: dmc@200000 {
 >> +       compatible = "brcm,dmc-520", "arm,dmc-520";
 >> +       reg = <0x200000 0x80000>;
 >> +       interrupts = <0x0 0x349 0x4>, <0x0 0x34B 0x4>;
 >> +       interrupt-config = <0x4>, <0x8>;
 >> +};
 >> --
 >> 2.17.1

Thanks!

-Lei

