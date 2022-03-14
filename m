Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858554D7C0A
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 08:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiCNHha (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Mar 2022 03:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiCNHh3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Mar 2022 03:37:29 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0864940E51
        for <linux-edac@vger.kernel.org>; Mon, 14 Mar 2022 00:36:19 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4C0E33F32D
        for <linux-edac@vger.kernel.org>; Mon, 14 Mar 2022 07:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647243378;
        bh=iAtSOaeLKxQsN9oiK9IKSKgSGPin9K0zGNTzo54gjLk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ejJ1McrfEU8hBrkyg9HYVguxj9Ylx7vnA1gvJSacWKkxNcaMpB3+GGVONaJg6ZiJd
         SsdzFwrRTf/skmDfOtZ0p6M+7Gg3ZOVW3jLqnttFuy6bLZE4jj/We1x1GheOwUC9KI
         lCB3UXDfpdHMBMD5h/mpSGO8JwJRbm8Um4rf13cl03rkQIlySUYmM1n40DMdbhewkc
         3Hq24WAxYGV4OO3sLM0+tMFzv2njr2YEeEJQzNcLOyCt516n5SPLGTMwHO3Si7NkkV
         0Wfu39dfl+KmyrYdruN7wtTXHCO2QalQOS9R8UsYkpz9XkZUpAmFtJeOp6Cfby2+zI
         s7hbpw1ls5T3g==
Received: by mail-ej1-f71.google.com with SMTP id hr26-20020a1709073f9a00b006d6d1ee8cf8so7435198ejc.19
        for <linux-edac@vger.kernel.org>; Mon, 14 Mar 2022 00:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iAtSOaeLKxQsN9oiK9IKSKgSGPin9K0zGNTzo54gjLk=;
        b=zVSZ7x/WzQXTrjIGxu4l8gfmx3zmQYc7xBACgaLr6XsjNjyAwVhqhD13XfsWDdBHtj
         Pgt3W6KY9BWB8+6tQfoLZcc2JLrGLEEX1YVLGZ40ZN2Ywn/pooEuHBSPcWbTF2UdN9Bg
         Nd0vKO/jX2C1ji1JcqL/kdazbIrDoQfPxCFt6jaxOC1rdpF37n6j3qx+Y/N33+r2w0ud
         pIj9ovuK62WA3MvQVAiVH+f77mwJ7mjOrR6N8U3oPijduA/tWRngbzRysolE7ag8cKOY
         +MJclkkzaYbe4EFAbdiDJV3PZDRwjvCnttxJjv3wxZp4ut9VvFS/LQkCTEQUOvgrhDVY
         RlHg==
X-Gm-Message-State: AOAM532G2GaO5DlNk7pfTIUonSYfbP4KNrZNK2rMCQqDBb57Wp2p+5nw
        QjR0F2FpWMa+/loflu35ZzRvn7Fka9LtN/f6u/M2WJinXO8/CmT83RPQ/Xq6TlFWAtVfBolXLrd
        SXUeMa7Njy+9BFBsofLBuMhxMu5P8ebpilbptw4o=
X-Received: by 2002:a17:907:1614:b0:6db:e3f7:2cb4 with SMTP id hb20-20020a170907161400b006dbe3f72cb4mr255441ejc.435.1647243377968;
        Mon, 14 Mar 2022 00:36:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycCN76EHq9M0eAQGZvA10vpA52jlIoM5/wMGxfvQsd+ClzDaAgk2gAPmK0IIzzn0h6WBnHrQ==
X-Received: by 2002:a17:907:1614:b0:6db:e3f7:2cb4 with SMTP id hb20-20020a170907161400b006dbe3f72cb4mr255415ejc.435.1647243377741;
        Mon, 14 Mar 2022 00:36:17 -0700 (PDT)
Received: from [192.168.0.152] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id z21-20020a1709063a1500b006da6436819dsm6448816eje.173.2022.03.14.00.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 00:36:17 -0700 (PDT)
Message-ID: <143db512-0223-1553-c141-2dc24a23c430@canonical.com>
Date:   Mon, 14 Mar 2022 08:36:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Content-Language: en-US
To:     Medad Young <medadyoung@gmail.com>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20220311014245.4612-1-ctcchien@nuvoton.com>
 <20220311014245.4612-4-ctcchien@nuvoton.com>
 <1f5e1e49-4ab0-5e06-fa8f-2a11b0fd1df9@canonical.com>
 <CAHpyw9dHau348qJB6g+fCcKqWByUsRHAGwb_mdUg=hjhW+xNsw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAHpyw9dHau348qJB6g+fCcKqWByUsRHAGwb_mdUg=hjhW+xNsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14/03/2022 06:32, Medad Young wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> 於 2022年3月11日
> 週五 下午5:15寫道：
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
> this driver is used for two nuvoton SOCs, one is NPCM845 and the other
> is NPCM750

Yes and how NULL can happen for OF-only driver? Unless I missed
something and this is not an OF-only driver? Do you allow any other
matching methods?

Best regards,
Krzysztof
