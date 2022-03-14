Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA74D7C04
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 08:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiCNHgc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Mar 2022 03:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiCNHgb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Mar 2022 03:36:31 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CBC40E4F
        for <linux-edac@vger.kernel.org>; Mon, 14 Mar 2022 00:35:21 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D40F73F79B
        for <linux-edac@vger.kernel.org>; Mon, 14 Mar 2022 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647243316;
        bh=7XD/ZCIPD+pSa/ajluyXSHrFnnLxPbj9dv4H6XXzi7o=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=RRjxuZriAsaR77So9xWe6U3lKguXv3h8zPlDoRWaGCNefBEj2hLvSsREqM4viYOna
         4ax02wxx1bMBZ/0eSeoAatw5HU9rSkW2HY86ZeDuz/u10Oqo184enCuPAUDxegRywC
         4DDB5qVlzDVl6cepdg1TqmTyERUwyuvLJJe8k0Rrr5VHdKktOx65Z85OTuIyII4lDG
         hrF9Jch2pR2Vh5jTjKYrH+JZvd7wxy3EvqNYHeM3pKDX1WLYXY97tmweNmljhCDZCi
         1RmRMn3mDk65Q+cZepjqpHFgG19K2X1hhsEJcObiNFI6cmcS9TJWok1khtl2fgc29x
         8wBk0NwPz2q4g==
Received: by mail-ed1-f72.google.com with SMTP id l24-20020a056402231800b00410f19a3103so8173346eda.5
        for <linux-edac@vger.kernel.org>; Mon, 14 Mar 2022 00:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7XD/ZCIPD+pSa/ajluyXSHrFnnLxPbj9dv4H6XXzi7o=;
        b=O4P1RFVZUzua+09gHm3kmtl9M3keijZSlXgxvDiqHY4KcOlvPT26i42N05Iu+VeUIh
         R+T5REe18dJVtGUXK4XXWN0V7NvOy+2WILZL/XAFacdSziaXh7P6I7+8yFwcEJ+YzE+P
         MTQ4031gjCJRvz1C1XICEC9e2VMT6NoD8gHjyJLUSHoj0tb5X/t00hhR9fwh/66SDlPJ
         SUlfvfjpmUDFt/jV4IyohqLu0X4n5KuJ+hUDz6wUzWPk7dWmy/Yup9jbZD6+H5YSzHnV
         +Pi5Ejs2AwUgedk505hD/UfC+BUsoYYaEFJKfRI6mSZHGHCVK6l861an7GwObW7/k7yU
         7bEA==
X-Gm-Message-State: AOAM533R/Ow9gZFycmXWefiEpSsMuIP9zDcG+drKh6myBnY08HIT9Un0
        dcCqXWUCdgD6WO+OA196KEkSSuJc0YaDXcbYtqWqgh5teX1fXkyYj1p1O03PBfKBUQ05//WVTe+
        qYS6XdELelUweMmbAILNOvjDwb4zFDW5LdhwyPew=
X-Received: by 2002:a05:6402:4301:b0:418:585b:cfe1 with SMTP id m1-20020a056402430100b00418585bcfe1mr9566748edc.250.1647243316378;
        Mon, 14 Mar 2022 00:35:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQjBMUwRWUV4MpFNb8hzB27BfL/O3/uSgyWyC0crEVt9Qfy2ep0MNaTkAJB5rcza+jxkL4Mg==
X-Received: by 2002:a05:6402:4301:b0:418:585b:cfe1 with SMTP id m1-20020a056402430100b00418585bcfe1mr9566734edc.250.1647243316197;
        Mon, 14 Mar 2022 00:35:16 -0700 (PDT)
Received: from [192.168.0.152] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id l9-20020a1709066b8900b006daa6015a0dsm6336356ejr.89.2022.03.14.00.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 00:35:15 -0700 (PDT)
Message-ID: <4f8fffa7-631a-9b87-ee0a-0fb7dc1fec66@canonical.com>
Date:   Mon, 14 Mar 2022 08:35:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Content-Language: en-US
To:     Avi Fishman <avifishman70@gmail.com>
Cc:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        James Morse <james.morse@arm.com>, tony.luck@intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
References: <20220311014245.4612-1-ctcchien@nuvoton.com>
 <20220311014245.4612-4-ctcchien@nuvoton.com>
 <1f5e1e49-4ab0-5e06-fa8f-2a11b0fd1df9@canonical.com>
 <CAKKbWA7Pr8Gi-rU5_BZ32y5aiLV0tSM19WkRe+zF8spWdk5zMg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAKKbWA7Pr8Gi-rU5_BZ32y5aiLV0tSM19WkRe+zF8spWdk5zMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 13/03/2022 21:22, Avi Fishman wrote:
> On Fri, Mar 11, 2022 at 11:15 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 11/03/2022 02:42, Medad CChien wrote:
>>> Add support for Nuvoton NPCM SoC.
>>>
>>> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
>>> ---
>>>  drivers/edac/Kconfig     |   9 +
>>>  drivers/edac/Makefile    |   1 +
>>>  drivers/edac/npcm_edac.c | 714 +++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 724 insertions(+)
>>>  create mode 100644 drivers/edac/npcm_edac.c
>>>
>>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>>> index 58ab63642e72..757e1d160640 100644
>>> --- a/drivers/edac/Kconfig
>>> +++ b/drivers/edac/Kconfig
>>> @@ -539,4 +539,13 @@ config EDAC_DMC520
>>>         Support for error detection and correction on the
>>>         SoCs with ARM DMC-520 DRAM controller.
>>>
>>> +config EDAC_NPCM
>>> +     tristate "Nuvoton NPCM DDR Memory Controller"
>>> +     depends on ARCH_NPCM
>>
>> || COMPILE_TEST
>> (and test if it compiles)
>>
>> (...)
>>
>>> +
>>> +MODULE_DEVICE_TABLE(of, npcm_edac_of_match);
>>> +
>>> +static int npcm_edac_mc_probe(struct platform_device *pdev)
>>> +{
>>> +     const struct npcm_edac_platform_data *npcm_chip;
>>> +     struct device *dev = &pdev->dev;
>>> +     struct edac_mc_layer layers[1];
>>> +     const struct of_device_id *id;
>>> +     struct priv_data *priv_data;
>>> +     struct mem_ctl_info *mci;
>>> +     struct resource *res;
>>> +     void __iomem *reg;
>>> +     int ret = -ENODEV;
>>> +     int irq;
>>> +
>>> +     id = of_match_device(npcm_edac_of_match, &pdev->dev);
>>> +     if (!id)
>>> +             return -ENODEV;
>>
>> Why do you need it? How such case is even possible?
>>
>>> +
>>> +     npcm_chip = of_device_get_match_data(&pdev->dev);
>>> +     if (!npcm_chip)
>>> +             return -ENODEV;
>>
>> I wonder, how is it possible to have here NULL?
>>
> Both of_match_device() and of_device_get_match_data() can return NULL,
> are we missing something?

I think your driver is OF-only, right? If yes, how is it possible to be
here in probe() (meaning: being matched by of_device_id) and a few lines
later do not match the same of_device_id?

Best regards,
Krzysztof
