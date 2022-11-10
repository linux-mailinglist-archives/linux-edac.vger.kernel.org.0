Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC5E623F64
	for <lists+linux-edac@lfdr.de>; Thu, 10 Nov 2022 11:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKJKFf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Nov 2022 05:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKJKFd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Nov 2022 05:05:33 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BFB6AEEF
        for <linux-edac@vger.kernel.org>; Thu, 10 Nov 2022 02:05:30 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so2176013lfb.13
        for <linux-edac@vger.kernel.org>; Thu, 10 Nov 2022 02:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/BGQNvtEQU0Zkdn8ico89/ZYG7ZgZLkYbLjl92xS8Y=;
        b=GsX68UwJRBGHkokd1fUHeO4YD4SZq1KKz8dHlxKC34ROOJPGhC5YY0V9Ly3UthiP5R
         Ihrk0oDRg8lBWE8k7UOBaKMbQLU8Ki8OcKFOoT5TnNtRBNtnkpUrrmRl/NvNZzId856o
         ryw8Ej88HcYlTSafGUMC9J4CSj0meiwU8TeaLj+YjhPrZ8i/5NkDYHjmdXrdG7WbrE6u
         Dt18pbfww8rydY+fKm4rgKPbYkDOIZaEFn0QGnUsnQ17/+i/zA8afZuOqDVO3cI0hV0t
         4/eYV31PCUYkfjR7oTa9FWicp/fVx26PGbGU+3y7DtBOSoK0dMbTnlfVcHZyM3jLsmFD
         AG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/BGQNvtEQU0Zkdn8ico89/ZYG7ZgZLkYbLjl92xS8Y=;
        b=rYejGOtCkyRKUyxNHb94+qeMsawRvoSk08OAzDx8xvq2rtXdqR7kK6QN6ZdUYJhCKX
         qz8u6jbuT+bh4BdZxV8IExl9sJ1rz+BhMBTa911M9LKEJPUBAx43CzvOEAReKrFib1ts
         0e4KiRsRNS/YdkYYvGDjnnFua/XGGl0+/vGTryEzOw60OsMPRRalWKCx7Bx3EvnI8I6G
         oanyG/nTz4gBi4hAkRr1UPVxmM3vAZtAKXWOtsDzxc5M3JMyOK8hPmkRPjCrG1QQfZeq
         a00SHg6O2qnq8BFk/ct/Cfp88qBdeT/EUwefsEGlPPeMI8h01jxAK1JFhgg0lIrW1jjm
         A+lg==
X-Gm-Message-State: ACrzQf1vFhJzbI4BrDPm7JEO7ePp+e0Kh3bk+Rjpbv/bha19o5oYpu2q
        OMNwpBuWNpzfu9tj49/GUTEFNA==
X-Google-Smtp-Source: AMsMyM7TJSe5u5hAbHxg8Ypr3Uf3gEepR+pqxmJZuwtctzc6FgifZlhFlluQyioLoTjmy2eyNcCLzw==
X-Received: by 2002:a19:650c:0:b0:4b0:38df:e825 with SMTP id z12-20020a19650c000000b004b038dfe825mr1419804lfb.471.1668074729379;
        Thu, 10 Nov 2022 02:05:29 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id w28-20020a197b1c000000b00498fc3d4d15sm2665544lfc.190.2022.11.10.02.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 02:05:28 -0800 (PST)
Message-ID: <e26bd133-bac3-e95f-23ba-7bff5c85e3a9@linaro.org>
Date:   Thu, 10 Nov 2022 11:05:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: edac: Add bindings for Xilinx Versal
 EDAC for DDRMC
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        linux-edac@vger.kernel.org
Cc:     git@amd.com, devicetree@vger.kernel.org, michal.simek@xilinx.com,
        rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org
References: <20221107062413.9642-1-shubhrajyoti.datta@amd.com>
 <20221107062413.9642-2-shubhrajyoti.datta@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107062413.9642-2-shubhrajyoti.datta@amd.com>
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

On 07/11/2022 07:24, Shubhrajyoti Datta wrote:
> Add device tree bindings for Xilinx Versal EDAC for DDR
> controller.

Use subject prefixes matching the subsystem (git log --oneline -- ...).

Subsystem is memory-controllers.

Drop redundant, second "bindings" (so "bindings for").


> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---

Best regards,
Krzysztof

