Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE07065B250
	for <lists+linux-edac@lfdr.de>; Mon,  2 Jan 2023 13:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjABMr2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Jan 2023 07:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjABMr0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Jan 2023 07:47:26 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A6B03
        for <linux-edac@vger.kernel.org>; Mon,  2 Jan 2023 04:47:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g13so41409271lfv.7
        for <linux-edac@vger.kernel.org>; Mon, 02 Jan 2023 04:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7W3g6H5+/AUufZzgxrgv5aroav6W5CJ7ZUXKABlB1O4=;
        b=jN44ekuYAVrvPJw2oJbJZ0mmGlp2fCsKZwgEldCFihbQ8lUlR8vhzaMtfIbrxz2NUT
         z2d5788oGk6GCFfme7o+tfap0719H8ePCJMq7MpcwBupFBzsoeCaFqQbbMlqgpTayqXC
         GBHgZhBftHipZhuYthASYTzTUPmwbAaM+K5dq+2wVnO3KBU+6CPH5pzFyTZ0CSLv6Gz5
         6L3kLhdhK3UqQ1akCdW1Nv+AKanbqs4BDDEbuPVd1u3ZIW6ioRG7sFT83ZVEPjxP11zd
         7canjmM4buLqqoXq9UwpNOnc56l8pIoeele8sNoep2XCFri6nx0OMjQ1985wuMC7pGMw
         AcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W3g6H5+/AUufZzgxrgv5aroav6W5CJ7ZUXKABlB1O4=;
        b=ycjKwFO8SvlufRlqYl+RkKv+16WfgbOxcMm8TRSrhV6rYUk+851KjdHgFOhdCOAW3O
         VOQMG68d5FfM7gcq23jVTmN6Jc73Zl2rexeEWPlxe7kPvSBDz6n0WkN+tR9SG6tYMV10
         uFXvzNo3+P0GlwzsxEEW097JW7NLj063xZw/Kjcaeksn5JWUw3VWUl3But9/og/9a0fu
         8sb7XuOe7I1baEq8pUFgsxdP9nC2x8dFLuzDNWODcnksyqcBjWJ7WED/W+xNFqu6kcZD
         6fW0lOofYRLzZiXkVb46a5DgsCKqIBmpFJ94lq3U80ccvYz+g4M//s+nJH4KKfHOIrVB
         xIGw==
X-Gm-Message-State: AFqh2kokFTwU9bLpPDsLOTBXZhxr+kz79patoRJfH0dPmnJ13dG59Mdh
        PBlKbz66Sa4GdfhrEGQ1FsnDbDeClXntMu0V
X-Google-Smtp-Source: AMrXdXs4jw47G7Ax0iFfxEdq8+zmqxDWql5d1xIlpfJ9HAQgQJP+0oekXlTaVzmLoS49G9TJCroZZA==
X-Received: by 2002:ac2:5088:0:b0:4a4:7be4:9baf with SMTP id f8-20020ac25088000000b004a47be49bafmr12347564lfm.59.1672663642548;
        Mon, 02 Jan 2023 04:47:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z8-20020a056512370800b004b55b404d36sm4441185lfr.156.2023.01.02.04.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 04:47:22 -0800 (PST)
Message-ID: <8b844f3a-e9b0-28d5-200a-611fe3068bc0@linaro.org>
Date:   Mon, 2 Jan 2023 13:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR
 Controller
Content-Language: en-US
To:     "Shenhar, Talel" <talel@amazon.com>, bp@alien8.de
Cc:     talelshenhar@gmail.com, shellykz@amazon.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02/01/2023 13:17, Shenhar, Talel wrote:
> Hi,
> 
> Want to consult on a topic that involve both drivers/memory and 
> drivers/edac.
> 
> * We want to introduce driver that reads DDR controller RAS register and 
> notify for ECC errors by using EDAC MC API found in drivers/edac.
> * We also want to have a capability to dynamically change DDR refresh 
> rate based on thermal values (best to be done in drivers/memory ?).
> 
> The pain point here is that both capabilities are controlled from the 
> DDR controller.
> This create issue while using 
> devm_platform_ioremap_resource*->devm_request_mem_region which prevent 
> two mapping of same area.

This could be avoided but the true problem is that you have two devices
for same memory mapping. Devicetree does not allow it and it points to
some wrong hardware representation in DTS.

> 
> It seems to be expected problem as we have 2 "framework" (edac and 
> memory) split while both aim for same HW unit.
> What is the recommended way to face such conflicts?

You now mix Devicetree and Linux drivers. You can have same IO address
space used by multiple drivers, even though it is not always good
approach (concurrent and conflicting change of same settings).

HW description is irrelevant to this.

> 
> We had several concept in mind but would love to get your point of view 
> first.

Describe hardware accurately and completely. This solves all the
problems, doesn't it? Linux drivers do not depend on it and you can make
it differently.

> 
> Things we had in mind:
> 1) map more specific region to avoid conflict (we don't need the same 
> registers on both entity so if we do very specific multiple mapping this 
> shall be resolved)
> 2) use other kernel API for mapping that doesn't do request_mem_region 
> (or use the reserve only for one of them)
> 3) have single driver (edac mc) handle also the refresh rate
> 4) export edac_mc.h and have the drivers/memory have all the needed code 
> to do both edac and refresh rate under drivers/memory

None of these address the core problem - possibly inaccurate hardware
description...

Best regards,
Krzysztof

