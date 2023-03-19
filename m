Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC106C02BC
	for <lists+linux-edac@lfdr.de>; Sun, 19 Mar 2023 16:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCSPVg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 19 Mar 2023 11:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjCSPVd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 19 Mar 2023 11:21:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFF621A30
        for <linux-edac@vger.kernel.org>; Sun, 19 Mar 2023 08:21:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so37814651edd.5
        for <linux-edac@vger.kernel.org>; Sun, 19 Mar 2023 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679239288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MPg17g6pPRdL9tTnpZvVwCQGrGLvOmSGuwE0LCcRsA=;
        b=bYT6wRny1mJNAuJxI6lZyObz/9Bgqm2OoMM9QNmJkwj83FEexDyR/1CEzoZp7DS2HA
         2qkdDHaJPPCPx/iQ4RizZSeWa39zMY/Wp1UIZbdRWBQWi5IzT2Hmfr3PDUl/MWMIrICS
         TM1TkxzcsFCQcJnb+vDHTVmWTin4vusaZhW/OhNquYyr3iqVNg+NX/xh0Ft5M3PAZT5L
         pIIRH4+6HqNhRGjAju5gNN7YCGlhHxxoU9pmJNqX7hWST0iau1fHEXsfkPsNMmssppmS
         z/kP9f21A2/SE8sFpXecNRPvcHnFKiGraj9qvbTZTzOUTq8aQP7MPXMsr8GPTuHG+vuZ
         aQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679239288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MPg17g6pPRdL9tTnpZvVwCQGrGLvOmSGuwE0LCcRsA=;
        b=APCWeIAsLo+zydM3SQm/kKRg9vhMojYZTPc/JjuIlc6gfsMwfRGTshXXJSWsMhS18k
         +0288MRxe4scLc74WhG9wm1YFPrBhWxNX4ef6GF4ksymPGdkaMTE8bWWXpRKz05SZRCK
         CcAKst5smNsTS3BuwjX6ZlYqxfG7v2tcXolPi7XGAoniSk8cczbj4t1iVMFHqpes/WCU
         4Re5/C2pTB2FCOCodLQZaJRod/k720C6bizaAKKe5B7xXStSQ4A5aLWRstNnH2WXNpUF
         LY3KTB6upF34eJaBcB9ekbuXT6D3NDUE9HvymM0HUKf7pPcQjt0T+ZsGcxzcBFH4L3LM
         1xBQ==
X-Gm-Message-State: AO0yUKVTZvRSqbB1Py6Hg0BhAEthpiUsWF9hYSFFUrcR0Hf3pgCss28l
        kLcWuDq7SNNPgqA4WGinHPA+iw==
X-Google-Smtp-Source: AK7set8X7boMde6L0dSuF16GMGAlEn7pBLVYH3RFoFzDgoTwbQ23rzLfAMRpql7L8BotUyBJqso0Qw==
X-Received: by 2002:a17:906:37d3:b0:92f:d1ec:a7d7 with SMTP id o19-20020a17090637d300b0092fd1eca7d7mr5414362ejc.15.1679239288065;
        Sun, 19 Mar 2023 08:21:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id ja21-20020a170907989500b0093338259b2bsm1789284ejc.207.2023.03.19.08.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 08:21:27 -0700 (PDT)
Message-ID: <45a57e8a-c6f6-be7d-21c7-3c6fffd4ebba@linaro.org>
Date:   Sun, 19 Mar 2023 16:21:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/2] EDAC/versal: Add a Xilinx Versal memory controller
 driver
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        linux-edac@vger.kernel.org
Cc:     git@amd.com, devicetree@vger.kernel.org, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, michal.simek@xilinx.com
References: <20230317141509.17534-1-shubhrajyoti.datta@amd.com>
 <20230317141509.17534-3-shubhrajyoti.datta@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317141509.17534-3-shubhrajyoti.datta@amd.com>
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

On 17/03/2023 15:15, Shubhrajyoti Datta wrote:
> Add EDAC support for Xilinx DDR Controller, this driver
> reports correctable and uncorrectable errors , and also creates
> debugfs entries for error injection.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v5:
> Update subject
> 

Only subject? So the build warning was not fixed?

Best regards,
Krzysztof

