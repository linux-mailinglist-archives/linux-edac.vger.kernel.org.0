Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34999623F52
	for <lists+linux-edac@lfdr.de>; Thu, 10 Nov 2022 11:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiKJKDt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Nov 2022 05:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiKJKDs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Nov 2022 05:03:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC3A2BB19
        for <linux-edac@vger.kernel.org>; Thu, 10 Nov 2022 02:03:46 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d6so2189546lfs.10
        for <linux-edac@vger.kernel.org>; Thu, 10 Nov 2022 02:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2sMRTP24GmecatqpOQUYmavS0poALVk/A1SX+cL241g=;
        b=rgBxazaDKiPJu2BLF4eMktztRHRScEyVU3SH76vJMBl67r7w7TVFUsLVCmZj9GKDIr
         tFAjRFNHa7ycz3JvtFlplla6ApxhNzkhWgSvinu9OO9KJMF8CWrw2s7z+wRLQTQM9FEy
         CBegRe2tVHBF3/cnRYrwbfRHjvrXY+rsbVMU1PmALy1tXVqBXYoxotCLP+q3Hw+paLGA
         WFQmmjrw7xD7aoTO7EIg1J4u1I3ztQNoL1v1wmkiaJMHy/D9A0AFFkr1lkG2V4W74Im6
         rgE56pH0L8wjjiSqCJQSzL2Z+5GXYIQEBgcFtAlxoFE+6VQjl8o+ffm7hqsAVcrBfYFj
         U1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sMRTP24GmecatqpOQUYmavS0poALVk/A1SX+cL241g=;
        b=pVuyZfZEOwwSxff0aO6/6m4PxD3VjQFum/HQ7GgplGUeLQnLxlrtTK+NjucQ07JtRr
         yWHN67sSs1vi8psX7Ke/svC3AFVa76jkBKPg9rnehXw7mCFx5TnazsBbetWWsTP4hofQ
         GZFtSeMIN2k4KwR/ek3WYP0QySNxGJ8mXrsjgdgPb7+G97BjuVG6HekCB1AIXgCUgWC7
         DupIPBWR55wdc5TX3pSGjfQmxiz6aFlaRsp6dAykXBm9FMZQOYpHi3EdCqnwEyyQQA8s
         tO0TQMzTq8CrRthwhRA+0CfgdGoScePGvSFRJ6Nf58Svs95Ul3I/ZiHtWVj7PKfyeQuY
         HWbg==
X-Gm-Message-State: ACrzQf1fozFyx0PVcH5OdzWdDNV+oSv2VL1f+3LlFgqqvJImhM48W8Lv
        pjeMJdzSxozcJIIvvTTlwTZ/qA==
X-Google-Smtp-Source: AMsMyM7k5NM0AgQlTM9MoxxWa9Oa+BrVmqTB1FPqXt+YJKRLozHOUDNEmQvIQNaK1XmIWFRfJ7Y3mw==
X-Received: by 2002:ac2:5c09:0:b0:4b0:1b30:370a with SMTP id r9-20020ac25c09000000b004b01b30370amr22502686lfp.58.1668074625106;
        Thu, 10 Nov 2022 02:03:45 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id j10-20020a056512344a00b004afd23cf7eesm2653731lfr.168.2022.11.10.02.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 02:03:44 -0800 (PST)
Message-ID: <207ae5bd-dbc2-9c4b-2acc-bda480da711e@linaro.org>
Date:   Thu, 10 Nov 2022 11:03:43 +0100
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
 <Y2zL3OXBNfR/VNPK@zn.tnic>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y2zL3OXBNfR/VNPK@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10/11/2022 11:01, Borislav Petkov wrote:
> On Thu, Nov 10, 2022 at 10:10:56AM +0100, Krzysztof Kozlowski wrote:
>> On Mon, 7 Nov 2022 11:54:12 +0530, Shubhrajyoti Datta wrote:
>>> Add device tree bindings for Xilinx Versal EDAC for DDR
>>> controller.
>>>
>>>
>>
>> Applied, thanks!
> 
> If you apply them then I need to merge your tree so that there are no
> checkpatch warnings about missing devicetree documentation and bla.

Unless you mean some EDAC-tree Patchwork tests, what's in the next
matters. Both patches will be in next, so no warnings.

If you take it, then all other patches touching these files in this
cycle must go via your tree.

> 
> How about you ACK them and I take them through the EDAC tree after
> proper review?

Sure, I'll provide feedback and drop the patches.

Best regards,
Krzysztof

