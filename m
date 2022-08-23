Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431C59D8FE
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbiHWJuS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 05:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbiHWJsQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 05:48:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E69D8F9
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 01:44:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q7so15037427lfu.5
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wLOhMX2dSEteMTksjEMlhBF251+OnM4n2eaNqEAOV54=;
        b=PknsZfB6W2EJKNNwKk7QEfdH1d2OoV+QRXFjgxHK1if5lCTlkHp72zKFrc/8sO8TYT
         BtFCqylmbj1htRf493fkeFyBOAMPb+XASiSyDLDIERf1hfLCkLjsTGDPH/c+gRzQVfM7
         wYSVmVVKef5jui3VQdQM1JoXM+ahK/u/OjLsvZ1+KCXFZWGU1zr0qX+VVHQGn0cIhSec
         MeVYYk/U4m5nxRhUcaUhnxIo5rp81h0bzYVAiC044n3pYgb3kpkgM1YUv21KDg2rdyyG
         DATXjWQOI18vlPP1La/MPvkQRTjgBmGFxg/supoG91p66au28uNYozhaYsY9jmkiy/AW
         QJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wLOhMX2dSEteMTksjEMlhBF251+OnM4n2eaNqEAOV54=;
        b=jC0buBf+hQyIUScaNpHnU38GE4SBVGx+cfPL799GDFsZvkPtKqMLoMPZwG9EEN2Xp6
         lE9GJC14YW7aJAqWuvtapQS+OO9e5PVcS8IYZvl5l8ygbhjcmhG/qsPL99Kguoy/q44X
         MBS8mR5Ogf6kVKCgSae/x/1R58Y+fOQ/wZwkpKywXLzxOeilSlFzthSyx1KJiH+QIHoY
         rgHa1HQDkCgV8vqaIWEAlZtpllLixQ81GZSih9iFnZcsH9n5h6aPS5yjl0m68U2ZdXjO
         WoQ85jMmuocNQPjxKEqsszO0uWJG04MA+btCdCi0b6aTv7RABGS/858p4Xa9dro+5tkc
         dCzg==
X-Gm-Message-State: ACgBeo3nZ9SM7ytycyVGMWCtZMLqDCtTnYHQEHYOt1v6b/bZBVaGXvMe
        JZ+eeGneWQpwTEbAO+W1pgrxig==
X-Google-Smtp-Source: AA6agR7hl1CGI7r2CQqS6Ira4/M3Fw4abVlO0e7P1ZL3XHG/Tl7iMks/nNyA7kdEi1FrOfgHE/v3gQ==
X-Received: by 2002:a05:6512:2356:b0:492:e06d:7530 with SMTP id p22-20020a056512235600b00492e06d7530mr3420177lfu.103.1661244257706;
        Tue, 23 Aug 2022 01:44:17 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651203c900b0048b0bf9f4bfsm2392165lfp.140.2022.08.23.01.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:44:17 -0700 (PDT)
Message-ID: <166c0198-17c4-3b19-77fe-632d65f17cb0@linaro.org>
Date:   Tue, 23 Aug 2022 11:44:16 +0300
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823083243.aovlgu22j7uv73qv@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 23/08/2022 11:32, Serge Semin wrote:
> On Tue, Aug 23, 2022 at 11:17:23AM +0300, Krzysztof Kozlowski wrote:
>> On 22/08/2022 22:07, Serge Semin wrote:
>>> The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
>>> the CSRs layout is absolutely different and it doesn't has IRQ unlike DW
>>> uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there is
>>> no any reason to have these controllers described by the same bindings.
>>> Thus let's split them up.
>>>
>>> While at it rename the original Synopsys uMCTL2 DT-schema file to a more
>>> descriptive - snps,dw-umctl2-ddrc.yaml and add a more detailed title and
>>> description of the device bindings.
>>
> 
>> Filename should be based on compatible, so if renaming then
>> snps,ddrc-3.80a.yaml or snps,ddrc.yaml... which leads to original
>> filename anyway. Therefore nack for rename.
> 
> New requirement? I've submitted not a single patch to the DT-bindings
> sources and didn't get any comment from Rob about that. 

This is not a new requirement. It has been since some time and Rob gave
such reviews.

https://lore.kernel.org/linux-devicetree/YlhkwvGdcf4ozTzG@robh.at.kernel.org/

For devices with multiple compatibles that's a bit tricky, but assuming
the bindings describe both original design from Synopsys and it's
implementations, then something closer to Synopsys makes sense.


> In addition
> There are DT bindings with names different from what is defined in the
> compatible name. Moreover there are tons of bindings with various
> compatible names. What name to choose then? Finally the current name
> is too generic to use for actual DW uMCTL2 DDRC controller.

There are thousands of bugs, inconsistencies, naming differences in
kernel. I don't find these as arguments to repeat the practice...so the
bindings file name should be based on the compatible.

Best regards,
Krzysztof
