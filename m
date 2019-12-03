Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD206111B4F
	for <lists+linux-edac@lfdr.de>; Tue,  3 Dec 2019 23:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfLCWEz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Dec 2019 17:04:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39523 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfLCWEz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Dec 2019 17:04:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so2234623plk.6;
        Tue, 03 Dec 2019 14:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U0Zdh1W8YT0/olhw1BoU9rQF6IK87SH/WsTNkT7lsS0=;
        b=g/vCifTPoAWVc8oyZoGmNOfDZRRaIHZEevlL0fkqsv6VtvBAbJGLmdmjrOsB+qDtoP
         5IIjaNVPnNUavp8IrO5OzPBXz7oD8qkQ3Vz6rhXbVKNT2GHcFziIAAn0Q0ncuHJoV00o
         4LN4IQgja2CntGjXgvKAr5LwQYiF46cmugwBMqCYg3FsdJOqOxlODuFnDkatgSwuiUbd
         E1Bv3zHyot6Pwgjo5/4gKhueiVc57ttnXApgQvWo0W7x5EO64ifeBpNwfrp9q/8VR1KF
         4vEHiC4Ctc5c5v1jdoZWCuCeguU4oJgxBv8OfsYv2LAKiCIjNFNsDwDfjnP7LQF4yISC
         gcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U0Zdh1W8YT0/olhw1BoU9rQF6IK87SH/WsTNkT7lsS0=;
        b=PjWn9uyAQkwR/i7Ba4OBDbzdXa74zVAr2L7b/04lP0IKyGmTPrQ+gWfZS+ONfJAk9D
         9FJKYtO/RavMil26tdXVmy37eJEhHGLZBnvZqj0bBzCFr5Rg1uz1I2DziRaPFb1s3gnK
         To9UHUOtXQkhzEb4PIMBvRxteC+ybTrZEkDhvWeMe+79NNezlICzYHeAXFHtsimapZGn
         L+ogi3lZHscFzwUQB0ZIG9QOPsJ3o39n9XWGaWx0oJGz6dS71mUP/Nc82IZWR9uqWHoC
         +ao5tP2MC0qC8m+4Lypx23hxWOjML0Ogt15+gBS9w/bd1mDBp0Fo0edKQTo/3TvomQnz
         q0nQ==
X-Gm-Message-State: APjAAAV9N1UfCg0VWzSciYKqW2kKnbc3zuirKbuFEn6VIOoj4xJ+eLO2
        Adqx7Avjd5bG2/ScAMxc+Qw=
X-Google-Smtp-Source: APXvYqwH5p1pdvT3ai1jo+LMmmdPT7SPC5sK4b5ZBOokc1cDiEtQrVREoJtQYrcsD0p0AQ4Rb+uUEg==
X-Received: by 2002:a17:902:59c9:: with SMTP id d9mr180612plj.184.1575410694389;
        Tue, 03 Dec 2019 14:04:54 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:1009:24f7:1d2:3fb0:320e? ([2001:4898:80e8:1:b4ee:1d2:3fb0:320e])
        by smtp.gmail.com with ESMTPSA id i5sm721512pgj.58.2019.12.03.14.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 14:04:53 -0800 (PST)
From:   Shiping Ji <shiping.linux@gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: edac: arm-dmc520.txt
To:     Rob Herring <robh@kernel.org>
Cc:     bp@alien8.de, james.morse@arm.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, linux-edac@vger.kernel.org, sashal@kernel.org,
        hangl@microsoft.com, lewan@microsoft.com, ruizhao@microsoft.com,
        scott.branden@broadcom.com, yuqing.shen@broadcom.com,
        ray.jui@broadcom.com, shji@microsoft.com, wangglei@gmail.com
References: <f947d821-8e67-dcc7-d753-5b04d099792d@gmail.com>
 <20191121204350.GA26174@bogus>
Message-ID: <87af6922-41d6-c017-b31b-75eaa2c5551b@gmail.com>
Date:   Tue, 3 Dec 2019 14:04:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121204350.GA26174@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 11/21/2019 12:43 PM, Rob Herring wrote:
> On Sun, Nov 17, 2019 at 06:10:43PM -0800, Shiping Ji wrote:
>> This is the device tree bindings for new EDAC driver dmc520_edac.c.
>>
>> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
>> Reviewed-by: James Morse <james.morse@arm.com>
>>
>> ---
>>      Changes in v7:
>>          - Added arm prefix to the interrupt-config property
>>
>> ---
>>  .../devicetree/bindings/edac/arm-dmc520.txt   | 26 +++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/edac/arm-dmc520.txt
>>
>> diff --git a/Documentation/devicetree/bindings/edac/arm-dmc520.txt b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
>> new file mode 100644
>> index 000000000000..476cf8b76f2a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
>> @@ -0,0 +1,26 @@
>> +* ARM DMC-520 EDAC node
>> +
>> +Required properties:
>> +- compatible  : "brcm,dmc-520", "arm,dmc-520".
>> +- reg   : Address range of the DMC-520 registers.
>> +- interrupts  : DMC-520 interrupt numbers. The example below specifies
>> +     two interrupt lines for dram_ecc_errc_int and
>> +     dram_ecc_errd_int.
>> +- arm,interrupt-config : This is an array of interrupt masks. For each of the
>> +     above interrupt line, add one interrupt mask element to
>> +     it. That is, there is a 1:1 mapping from each interrupt
>> +     line to an interrupt mask. An interrupt mask can represent
>> +     multiple interrupts being enabled. Refer to interrupt_control
>> +     register in DMC-520 TRM for interrupt mapping. In the example
>> +     below, the interrupt configuration enables dram_ecc_errc_int
>> +     and dram_ecc_errd_int. And each interrupt is connected to
>> +     a separate interrupt line.
> 
> Looking at this again, I think I now understand what you are trying to 
> do. Your mask is just what interrupt line each one is. We have a 
> standard way of doing this either by using indices of 'interrupts' or 
> with interrupt-names. The latter probably works best in this case.
> 
> You need to define *all* the interrupt-names:
> combined
> ram_ecc_errc
> ram_ecc_errd
> dram_ecc_errc
> dram_ecc_errd
> failed_access
> failed_prog
> link_err
> temperature_event
> arch_fsm
> phy_request

Thanks for interrupt-names suggestion!

We did experiments and it looks cleaner now. In the device tree we define only the interrupts and interrupt-names that are of interest:

dmc0: dmc@200000 {
 compatible = "brcm,dmc-520", "arm,dmc-520";
 reg = <0x200000 0x80000>;
 interrupts = <0x0 0x349 0x4>, <0x0 0x34B 0x4>;
 interrupt-names = "dram_ecc_errc", "dram_ecc_errd";
};

In the driver code, we maintain an interrupt table with all known interrupts (name, irq, mask, etc.) Upon probing, we go through every known interrupt name and call platform_get_irq_byname(). If any interrupt has been defined then we update the interrupt number in the table.

In isr function we lookup the mask and perform specific logic.
 
> I'm not sure if all the '*_oflow' interrupts should be listed too. It 
> doesn't seem all that useful to get a 2nd interrupt.

No, we do not list them.

> Your node should list all that are hooked up in the h/w, not just the > ones you need for EDAC.

Do you suggest to list all of them in the device tree node? Currently we list only the enabled ones and update the mask accordingly.

Please let us know whether our approach makes sense, we will submit new patch after your confirmation.
 
> Rob
> 

-- 
Best regards,
Shiping Ji
