Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003FA59D690
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348272AbiHWJMe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 05:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348930AbiHWJLB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 05:11:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0099186B67
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 01:31:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m5so8014836lfj.4
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jI4L08/oOi3vA6hn+7winSookomnCC3p3C6fWDFU1ZQ=;
        b=sKEa4J+60AjbFouLxhTZ7FFrLc6wToA+E8YHmbFvZKo4SNSLs+EiU9GJmHLCt4QR0c
         HBtnq/hax4zB6jlmw27N1BmPMQ6LtYwySctUfJGJzMamv9dvZMbLNe+31qlsAxJ4ROXE
         vNMgTwPwEIua5mq8CI+tEUOZI8z81IHQ3zaoy4nCw6k3Hvxc8PZk9dwV8FZBX8N6VNM5
         VOoaMV9eTmyN8POtmN/8p1ar6EH5oVaR0ZmL7scKHq2m6MYW+r3L0i7zSrLvuC21jzqm
         AAwwAE0RhlVqTcG/Qy3CW/jMd5n/C7ZC3nX6mjfOvYXFQG/W9fiEHDrCITIDqWkreEB9
         GCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jI4L08/oOi3vA6hn+7winSookomnCC3p3C6fWDFU1ZQ=;
        b=hb0PpC9PGmzPzU1lWyvsUchNi1xmvW+3xHlfJ5/kfKY85QVVTMqrN3shRmNScGnw80
         Pr4KYrsHlRq5SpGzSeJdoU2Kmgt1GrxBS2AcElGY6/vISLWAlEqYCD06w7CWhrMaCCXi
         Fp0s51HwU8nuRZJ2BwjQYOHOd0AsOvXc3Epn0TJAn6n45PrAEg6O7UhGDzeMKHUIOOHD
         phgz+OKlhYojH1IbCTk/V4IeWz0ZqWnD5uNFYAW6VhQW1wec6DZ6vs1yfbaMg6C7fHsN
         0XcadKdFCsTvcknAL3V1H5QikUO5AMCtBL4zm3w5rIFpFqOzBtBCAOM7LxqrH2dn4tr/
         JyOQ==
X-Gm-Message-State: ACgBeo2Evm/wOGe92Boqd6GgH85iSxeF2N8WB3AxLja4g3eCgpcGa1lS
        5QH5Cj+IfIEfBlCJLBxpD2QURg==
X-Google-Smtp-Source: AA6agR4c69hJpYe3G1HTqpbA3I/nOr5UehBAs7HWoQA/fd2Rt83G8RXxKWKGkcJln0g0NwpVQx+QSg==
X-Received: by 2002:a05:6512:b87:b0:492:d829:36bf with SMTP id b7-20020a0565120b8700b00492d82936bfmr5558125lfv.193.1661243424994;
        Tue, 23 Aug 2022 01:30:24 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id v20-20020a056512349400b0047f6b4f82d1sm2387521lfr.250.2022.08.23.01.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:30:24 -0700 (PDT)
Message-ID: <afc181cd-46b7-4c69-d27a-d2005904f48a@linaro.org>
Date:   Tue, 23 Aug 2022 11:30:22 +0300
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
 <835938e3-e4f5-5029-9373-5dd59bc3b625@linaro.org>
 <20220823082748.td6pwkzj5grfno77@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823082748.td6pwkzj5grfno77@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 23/08/2022 11:27, Serge Semin wrote:
> On Tue, Aug 23, 2022 at 11:22:08AM +0300, Krzysztof Kozlowski wrote:
>> On 23/08/2022 11:17, Krzysztof Kozlowski wrote:
>>> On 22/08/2022 22:07, Serge Semin wrote:
>>>> The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
>>>> the CSRs layout is absolutely different and it doesn't has IRQ unlike DW
>>>> uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there is
>>>> no any reason to have these controllers described by the same bindings.
>>>> Thus let's split them up.
>>>>
>>>> While at it rename the original Synopsys uMCTL2 DT-schema file to a more
>>>> descriptive - snps,dw-umctl2-ddrc.yaml and add a more detailed title and
>>>> description of the device bindings.
>>>
>>> Filename should be based on compatible, so if renaming then
>>> snps,ddrc-3.80a.yaml or snps,ddrc.yaml... which leads to original
>>> filename anyway. Therefore nack for rename.
>>>
>>> BTW, if you perform renames, generate patches with proper -M/-C/-B
>>> arguments so this is detected.
>>>
>>>
>>>>
>>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>>> --->  .../snps,dw-umctl2-ddrc.yaml                  | 51 +++++++++++++
>>>
>>> This is a mess. I did not get any cover letters, any other patches any
>>> description of relation between this and your other one.
>>>
>>> It seems you make independent and conflicting changes to the same file,
>>> so this has to be properly organized.
>>>
>>> Send entire patchset with cover letter with description of all
>>> dependencies to all maintainers.
>>>
>>> This is unreviewable now, so a no.
>>
> 
>> And also untestable by Rob's bot, so will have to wait.
> 
> For what reason it's untestable? The patch has no dependencies from
> any other patchset.

This one is testable, but the next one is not, because it depends on
something. I don't see the reason to split the bindings between
different patchsets.

Best regards,
Krzysztof
