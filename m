Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9890962407D
	for <lists+linux-edac@lfdr.de>; Thu, 10 Nov 2022 11:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiKJK5P (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Nov 2022 05:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKJK5P (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Nov 2022 05:57:15 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAE76A69F
        for <linux-edac@vger.kernel.org>; Thu, 10 Nov 2022 02:57:14 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a15so884525ljb.7
        for <linux-edac@vger.kernel.org>; Thu, 10 Nov 2022 02:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHPM2i7K3k3L90f+QEXIGR519m1X/vy+ZwEgYGXrDwU=;
        b=W8VDIqO93VmgP15x80i2BODzF68QO6b9O1vVWA7fIi0a7umKK08QsSnoGxFmSFCpMR
         GIC3bnckwRq7BGM2zFdaBCCs4Z99GN0at3FgXgm24NytJZv2lg43HVBXCRE34ILb+gNy
         GgcsIeERm1wBhLnrRpwDS7/CYirW71juHJN2qOsUfJYyAamzndmjaWFzvHFWEsiaVePi
         lDXZb9zwPO6QJaQZw+K02Wo1GkRksx/MJ7bGX1zM4qY/EhFXkae70m5jCWl2xzKr0LA4
         cw7euzs+Hfzicd4/ABFWMJClFuOzNLDUKzA3C+IaJOXecLvr5ixSJToRTc15c/dCOm/V
         bD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHPM2i7K3k3L90f+QEXIGR519m1X/vy+ZwEgYGXrDwU=;
        b=z8JXkYQ7NkpOiXiFtGTPWu5l55eYXpuJdNldw6XXd6EmGWUkR/Z30GU3cIgckxZYS5
         irT8YXTN2Y7x3j1ULBHCb3NuRZ+Xy9KE+8sAX2vGDVrhFBe/mmr2KTGKnivzZNl52RPK
         Twax2Wf8M2ihWhOP8Q/PRqWhj5oBuftM6dh+M5VCtiky1tXjZdSKeKmZ5sQLn5jLAG4p
         V4JPkwF2Kf8NRAcRjHx3wog9lQeKhFNi/lR8Z+aGvc1j9H3l7ClhSxm5lkkwfuE956+X
         zJDrJ1Cr/wOsXFzS1ANi1RxxSgg1ESALWw4P03BsqwYe424CBD2MXRfqxxrWr9DvOQun
         hj1g==
X-Gm-Message-State: ACrzQf3HGRFgJnAXoFXw3K7b8LzO2FFJhMmJdS58G624Gho5If/ZOPef
        XIAm+1KVwlpL+nIYhxVlPB/lUg==
X-Google-Smtp-Source: AMsMyM5wckZz18t79KKJ38NNmINYSRSk5rJP7+/sWzVBy85LFl9nShC95LyNpaT+XxoAPd/iMPxtIQ==
X-Received: by 2002:a2e:87cd:0:b0:277:37a8:ba87 with SMTP id v13-20020a2e87cd000000b0027737a8ba87mr8064253ljj.14.1668077832686;
        Thu, 10 Nov 2022 02:57:12 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512075400b0048a9e18ae67sm2686771lfs.84.2022.11.10.02.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 02:57:12 -0800 (PST)
Message-ID: <490d26ce-a09c-db16-93b1-8f468a5c3f87@linaro.org>
Date:   Thu, 10 Nov 2022 11:57:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: edac: Add bindings for
 Xilinx Versal EDAC for DDRMC
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        devicetree@vger.kernel.org, tony.luck@intel.com,
        mchehab@kernel.org, michal.simek@xilinx.com, git@amd.com,
        robh+dt@kernel.org, james.morse@arm.com, rric@kernel.org
References: <20221107062413.9642-1-shubhrajyoti.datta@amd.com>
 <20221107062413.9642-2-shubhrajyoti.datta@amd.com>
 <166807145377.16822.15787804198836912482.b4-ty@linaro.org>
 <Y2zL3OXBNfR/VNPK@zn.tnic> <207ae5bd-dbc2-9c4b-2acc-bda480da711e@linaro.org>
 <Y2zYqetP6IhG01Bg@zn.tnic>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y2zYqetP6IhG01Bg@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10/11/2022 11:55, Borislav Petkov wrote:
> On Thu, Nov 10, 2022 at 11:03:43AM +0100, Krzysztof Kozlowski wrote:
>> Unless you mean some EDAC-tree Patchwork tests, what's in the next
>> matters. Both patches will be in next, so no warnings.
> 
> Yeah, that is correct.
> 
>> If you take it, then all other patches touching these files in this
>> cycle must go via your tree.
> 
> Do you expect that happening this cycle?
> 
> If so, then we can do them this way and I'll ignore those warnings.
> 
>> Sure, I'll provide feedback and drop the patches.
> 
> Right, in the past devicetree and driver patches for EDAC drivers have
> gone together through my tree but if you anticipate conflicts then sure,
> let's split them.

I don't anticipate more work for current cycle... but I also did not
anticipate such in other occasions (e.g. recently Tegra binding
headers), so my anticipation is not accurate. :)

Best regards,
Krzysztof

