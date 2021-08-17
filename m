Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252583EEB59
	for <lists+linux-edac@lfdr.de>; Tue, 17 Aug 2021 13:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhHQLHT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Aug 2021 07:07:19 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:49458
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236185AbhHQLHT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Aug 2021 07:07:19 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id A7E543F367
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 11:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629198405;
        bh=c4ywsmDTEvlxUcF8dP/+dEAsBM2GBk3icpnawYYHap4=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=aASZRYVmSFkVccjtHdAy0OMWOuD9zlMR28QBW8m18XAbYprniWka543AfaP03GurE
         ogelD0lKeOi6Skq/ucOLT1u+taoOV/Rt9SEtFpUzsnUh/m5gLOKCzm/Y8o0qaHsIBH
         5i5n4UZN+hr8P87Bm9MER2Arl8ajOC+cWwJZbPQWnTpm7LWLWGBkGChL7e+HN8OVas
         /W6rwjb6iQ6PJLJ0TOCnCHGpQYYYhtTBEXEixcs3kVniU5E5dJYUPx+FyOSroj+Q8w
         1s4zCvytnou4UdWS87rxPnYu4fdOTI0FYDozZuEoWdWU03WBJzTdh3iP+f3Hz+yX8p
         Qfm3eovuRdPCw==
Received: by mail-ed1-f72.google.com with SMTP id y39-20020a50bb2a0000b02903bc05daccbaso10419760ede.5
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 04:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c4ywsmDTEvlxUcF8dP/+dEAsBM2GBk3icpnawYYHap4=;
        b=mvu31CF/pE1gRuiCFtbv1FxDBag9JFAtmUGPnjIqfL52uY9Z4cGmQFiivTCZGwQNnx
         CVEjWWqAH4FnTHOoty29xKA4ThSCcC5P9b5ls2G+vH/bpAJxTHfpk0zOnhG9ys/6+kb5
         8XBZPD4oUQKMsONAws79Z4pBqRe4GxP/dLZbnXeWKNhYqoYeifvYDyB55acGK7G5Hk8V
         PXIJb2PyYc+vcyeGY1OcFi9mh5CE8bxAPAYz9AUKRNbaswveUYVm7MIXbdAL/eZv6ZUh
         ERtt5sq3s/Vcin3D1w6yFmwFOZCHjYWe1PSW5Wek3mVGzqebksMGRVA2/Whgl4831naq
         JhBQ==
X-Gm-Message-State: AOAM532le/FGJjgyOYDpAUMaGHg3sNsBv8N638w25fC6uOZ84pAqnBFP
        pkP6Yj8H3dA2xv7FkbQOqWJkN1fKFIaObDf86a4Ks7XtFZMrrKZt51qCPx3iPcuGLBzjQh+dJxI
        DQcLB65HrfetqD4b3teWw8AwHek7gewD1LJJNhPw=
X-Received: by 2002:a05:6402:254b:: with SMTP id l11mr3557751edb.268.1629198405444;
        Tue, 17 Aug 2021 04:06:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx19QKJabwM2gOaQdXajDaLyPfd/5Hi89/A0fIkwewCVXd43P5TMarmId4/Bv96wEZFpkOVaw==
X-Received: by 2002:a05:6402:254b:: with SMTP id l11mr3557732edb.268.1629198405313;
        Tue, 17 Aug 2021 04:06:45 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id n13sm608663ejk.97.2021.08.17.04.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 04:06:44 -0700 (PDT)
To:     =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
 <17798cb01c5d699738f57118d4deb53504759818.camel@pengutronix.de>
 <9872ed05-28d6-15aa-dc61-228776d20819@canonical.com>
 <294664184613324453f34ee581d9c5e97bab4f31.camel@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 1/2] dt-bindings: memory: convert Marvell MVEBU SDRAM
 controller to dtschema
Message-ID: <75d49c7d-764d-4416-1899-a7d5d7c955e6@canonical.com>
Date:   Tue, 17 Aug 2021 13:06:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <294664184613324453f34ee581d9c5e97bab4f31.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 17/08/2021 12:58, Jan Lübbe wrote:
> On Tue, 2021-08-17 at 12:52 +0200, Krzysztof Kozlowski wrote:
>> On 17/08/2021 12:46, Jan Lübbe wrote:
>>> On Tue, 2021-08-17 at 11:38 +0200, Krzysztof Kozlowski wrote:
>>>> Convert Marvell MVEBU SDRAM controller bindings to DT schema format
>>>> using json-schema.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> ---
>>>>  .../marvell,mvebu-sdram-controller.yaml       | 31 +++++++++++++++++++
>>>>  .../mvebu-sdram-controller.txt                | 21 -------------
>>>>  2 files changed, 31 insertions(+), 21 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
>>>>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml b/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
>>>> new file mode 100644
>>>> index 000000000000..14a6bc8f421f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
>>>> @@ -0,0 +1,31 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/memory-controllers/marvell,mvebu-sdram-controller.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Marvell MVEBU SDRAM controller
>>>> +
>>>> +maintainers:
>>>> +  - Jan Luebbe <jlu@pengutronix.de>
>>>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: marvell,armada-xp-sdram-controller
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    memory-controller@1400 {
>>>> +        compatible = "marvell,armada-xp-sdram-controller";
>>>> +        reg = <0x1400 0x500>;
>>>> +    };
>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt b/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
>>>> deleted file mode 100644
>>>> index 89657d1d4cd4..000000000000
>>>> --- a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
>>>> +++ /dev/null
>>>> @@ -1,21 +0,0 @@
>>>> -Device Tree bindings for MVEBU SDRAM controllers
>>>> -
>>>> -The Marvell EBU SoCs all have a SDRAM controller. The SDRAM controller
>>>> -differs from one SoC variant to another, but they also share a number
>>>> -of commonalities.
>>>> -
>>>> -For now, this Device Tree binding documentation only documents the
>>>> -Armada XP SDRAM controller.
>>>
>>> Please keep the description, otherwise it would be confusing why the binding is
>>> named marvell,mvebu-sdram-controller.yaml although it (currenly) only applies to
>>> the Armada XP.
>>>
>>
>> The description does not explain why it only documents Armada XP, so it
>> just duplicates what is in "compatible" part of bindings. How is the
>> confusion removed by saying "we document currently only Armada XP"? What
>> changes?
> 
> Then perhaps the binding should be named marvell,armada-xp-sdram-
> controller.yaml? It find it unlikely that support for the other SoC's
> controllers will be added, given their age.

Sure, could be like this but there is no confusion here and no need to
fix anything. It is understandable and common to name bindings file as
general (e.g. for group of devices) even though only limited amount of
devices are currently documented/described. It's almost everywhere like
this, when the bindings are not complete. I don't see where is the
confusion.

Look at: arm/marvell/armada-cpu-reset.txt which mentions several SoCs
while only three compatibles are documented.
arm/marvell/armada-cpu-reset.txt has generic name and describes only one
reset controller (370) while being used on multiple SoC (370, 375, 38x,
39x). I could go like this all over the bindings...


Best regards,
Krzysztof
