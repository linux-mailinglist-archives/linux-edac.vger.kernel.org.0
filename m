Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1725A08A3
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 08:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiHYGGs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 02:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiHYGGr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 02:06:47 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2199F741
        for <linux-edac@vger.kernel.org>; Wed, 24 Aug 2022 23:06:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s8so946568ljj.5
        for <linux-edac@vger.kernel.org>; Wed, 24 Aug 2022 23:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=olx/ATZA2V0ZzWbXgDfIkW1Q9WuG7O6K9lzCa3iTnVQ=;
        b=K7hkRlQGQAhrZwDVl0snou7VU3K79DIdp+9pBegNC7RbACR4+X7EJs3kPP14UHgsyE
         pxVZVQb1T42Zf6Bddds/dlIvsLtZmSWY7IjO8uY8tTAaoiEIXuO/ijNF6cC4EpIBQ0kb
         3nwcDAjmh7ns4PtwRfudGTkQqhe4mFeUlSt4t5FoF1ONA5nb9NpSU1B+jmvwyAwN3Wig
         3qBjzJRG0U4O/p3BR0XWhrcZhZL9P+XW50t44CW53Gmtw3RaRQbMJiXweTTpRcQMhpJr
         6uXstAIrkvvtxIhT43ZHV0jnuP0ujcBthinSkEz94Nu0J2ocvdibhRNJRDLEQGKyIYYr
         fuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=olx/ATZA2V0ZzWbXgDfIkW1Q9WuG7O6K9lzCa3iTnVQ=;
        b=y8GR8yOeMECKEz52Ru1TcDg1e/B+XKTtm5XukhZkvEEiqd3/LL7gOhwuskgGZSJoK4
         7xF3TdYhinyCuE+BWnjJBOqRL0ZFG23OWWNGve1cO6/G3msPb5SP6ff5QR4hvzu5AnfH
         zWyVKir3OoRcAxSMy1oScGF8mZ/s0KOvoVMa7jOtdZZnRQot+rhwMSZRDXgK79pWq/AB
         X2gyY5uopW5iF8sYb1d8WvV4ScUk+/AZcVVb6zqp5m8ed3x1iPkbq/7nt9t2uLet0jZh
         Rw0RbJr9/Oj6Rbq3X98nLYt420PkLw7fhGtepr3DMwEepSE5CnX1wW5F42o/jtDfkeTT
         Ob4A==
X-Gm-Message-State: ACgBeo1XweVHyltAWJSECKFpzU63zw3g1nDzC5rY3AU4Wc78mVhwUP/k
        Z7D5KC3e/d7LEhGW5MpX9JBh9Q==
X-Google-Smtp-Source: AA6agR5QBRKXZanSA8gmZ93Z6gOnhbSvg9XlOxZ5KCEOkCJ1wttIow4xsE77cP3aGxYyw1o/Zm4siw==
X-Received: by 2002:a05:651c:4d1:b0:261:c74b:ca6a with SMTP id e17-20020a05651c04d100b00261c74bca6amr609991lji.294.1661407604483;
        Wed, 24 Aug 2022 23:06:44 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512215000b0048b17852938sm312759lfr.162.2022.08.24.23.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 23:06:43 -0700 (PDT)
Message-ID: <a04f6b56-4bca-cc86-c51f-3a7c6c7ef02a@linaro.org>
Date:   Thu, 25 Aug 2022 09:06:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 16/20] dt-bindings: memory: snps: Detach Zynq DDRC
 controller support
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
 <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
 <20220823083243.aovlgu22j7uv73qv@mobilestation>
 <166c0198-17c4-3b19-77fe-632d65f17cb0@linaro.org>
 <20220823114516.4mcufkbmzy5gjdcr@mobilestation>
 <6661dcc1-cc93-efbb-b248-0d93f681a1bf@linaro.org>
 <20220824172724.ny2xpryn76h6ftv6@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824172724.ny2xpryn76h6ftv6@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 24/08/2022 20:27, Serge Semin wrote:

> 
> Note what Rob said concerned the generic compatible "fallback" case,
> not the generic compatible string in general. It's ok to have a
> generic device name defined irrespective to the platform vendor.
> Moreover it's applicable in case of the DW uMCTL2 DDRC IP-core since
> first IP-core version is auto-detectable starting from v3.20a and
> second I managed to implement auto-detection solutions for almost
> all the DDR/ECC-specific parameters. So I am more inclined to the
> solution 1) suggested by me in the previous email message:
> - deprecate "snps,ddrc-3.80a" string.
> - add new generic "snps,dw-umctl2-ddrc" compatible string.
> - rename the DT-bindings file.

Sounds ok.

> 
>>
>> Here the Linux driver also binds to generic synopsys compatible, so I
>> would assume it has a meaning and use case on its own.
> 
> Please see my messages above regarding the current Synopsys DW uMCTL2
> EDAC driver implementation.
> 
>>
>>>
>>> What do you think?
>>>
>>> * Note I've got it you'd prefer the renaming being performed in a
>>> separate patch.
>>
>> The rename could be in the split patch as here, but then I assume the
>> rename part to be detected by git and be a pure rename. However:
>> 1. The git did not mark it as rename (you might need to use custom
>> arguments to -M/-B/-C),
> 
> Of course git hasn't detected it as rename, because aside with renaming
> I've split the bindings up. Splitting these two updates up into two
> patches will give us what you said. So to speak I suggest the next
> updates for v2:
> PATCH X. Detach the Zynq A05 DDRC DT-bindings to a separate schema.
> PATCH X + 1. Rename the Synopsys DW uMCTL2 DDRC bindings file and add a more
> descriptive generic compatible string name.
> 
> What do you think?

Regardless of the split the rename can be and should be detected by Git.
That's why we have these options. If it is not detected, you changed too
much during rename, so it is not a rename anymore. Relatively small
amount of changes would still be detected.

> 
>> 2. There were also changes in the process (allOf:if:then).
> 
> Right. But this is in another patchset. I'll address your notes in there.


Best regards,
Krzysztof
