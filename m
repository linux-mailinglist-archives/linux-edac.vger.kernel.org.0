Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2E664EC80
	for <lists+linux-edac@lfdr.de>; Fri, 16 Dec 2022 15:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiLPOBB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Dec 2022 09:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLPOBA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Dec 2022 09:01:00 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83B013CD3
        for <linux-edac@vger.kernel.org>; Fri, 16 Dec 2022 06:00:56 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b9so2226433ljr.5
        for <linux-edac@vger.kernel.org>; Fri, 16 Dec 2022 06:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7q90haocQzUIauTlgAiT4Pqe6jJkwOt0yCzCZQvWbiw=;
        b=czVGbYbHTbW8TnGrOTCKUQPdHU/sf25m4MiVF3JjJPI4Z5fXL+a/TARtZLrIctAXgZ
         kMT83kZ6DYFtr0MqaUWBd0LaJKm7SWAD56dfWbPILNduDOitlpV97HhEc10DQ6mRWAaI
         AAFWt89Ku0JBXzIKpyOYdVSI4+cosTtKw0+xzBx9pjk8ReX2I8LH+i4ywibQHxScf64B
         Xdi/wnpAM6OKgejwlA2tM+J7JX/1hS1M5h0vHC/krBWSpYO1kf7zbZsk/66ldiA0S5bh
         0voTUKEpNJaUQAhwUQk/gdvkdWoBwG1HUxEs7txdhKkW4G4HMCAIqB+m38mgCsL2xQv6
         H4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q90haocQzUIauTlgAiT4Pqe6jJkwOt0yCzCZQvWbiw=;
        b=nhWrCOUSXDFU2yJejtmwEuoWK6WuCssCiuuCc8GC9C+8/+0eA4NYprENRwFLJDevjz
         KiBN6lVYnJ4JXQVimYTIoqey6efYFkuR9WQxnJlRhy/vguw4J+OmyFrD6wd/Z8YxRQjI
         TOoH0M2jsNHDoA2ob2QIKtKT4nG2JPSATUlmk1np8M1IKvrTfcf9wT541c9K68npzfoO
         ZvzHEeozlNfK0HhcAiFZfkLcMd8axt/9rIhJkDxPNH3fwSHL/smjl4EX5hZTjKXN+GJd
         MCOHHTbaXOyGeU9b3HkJXAH2bNUa1XjrHhakppcyNv2yq7pN1Kq4MidfiPTTBloy7xQW
         qH3w==
X-Gm-Message-State: ANoB5plqoCMu5QpoqkWbFkBeY5pvhEkpMBy8n+kYcXz9SS2TUyGFrOj4
        Xc9JNhrt2k9HYjAo95Krj2dBOw==
X-Google-Smtp-Source: AA0mqf6wLHhSs7GDQYI2x8ZdR4Q8UdkRbPj56RxFl0H8R4ONgpp6iK4za5CidlIGhq2LyvZlXn1JSw==
X-Received: by 2002:a2e:b5b4:0:b0:27a:359:15de with SMTP id f20-20020a2eb5b4000000b0027a035915demr7721138ljn.24.1671199254847;
        Fri, 16 Dec 2022 06:00:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y4-20020a197504000000b0049c29389b98sm224738lfe.151.2022.12.16.06.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 06:00:54 -0800 (PST)
Message-ID: <b861f167-c22b-7152-c273-47dfab54fe74@linaro.org>
Date:   Fri, 16 Dec 2022 15:00:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v16 1/3] Arm: dts: nuvoton: Add node for NPCM memory
 controller
Content-Language: en-US
To:     Marvin Lin <milkfafa@gmail.com>, linux-edac@vger.kernel.org,
        rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com
References: <20221216073141.3289309-1-milkfafa@gmail.com>
 <20221216073141.3289309-2-milkfafa@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221216073141.3289309-2-milkfafa@gmail.com>
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

On 16/12/2022 08:31, Marvin Lin wrote:
> Add node for memory controller present on Nuvoton NPCM SoCs. The
> memory controller supports single bit error correction and double bit
> error detection.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

It's "ARM:"


> ---
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 


Best regards,
Krzysztof

