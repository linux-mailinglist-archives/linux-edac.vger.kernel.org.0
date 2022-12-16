Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD364EC9E
	for <lists+linux-edac@lfdr.de>; Fri, 16 Dec 2022 15:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiLPOIH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Dec 2022 09:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiLPOIF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Dec 2022 09:08:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180952B25A
        for <linux-edac@vger.kernel.org>; Fri, 16 Dec 2022 06:08:04 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b13so3646049lfo.3
        for <linux-edac@vger.kernel.org>; Fri, 16 Dec 2022 06:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7rnlHGI8UN0z1G/4uZqIH5FqitWJ4bCQ8PKnzhEumA=;
        b=no9qkEjyPsSwHJ8KWezcBHzFRemjLu2fgQlmmct3Pj5Kw7Mp5cqsq49NkdHb61et4G
         ItQk8HCzJfJCY8+nVduYvzMm3uZUxcAv9LH7LQGt1JYz6WPbBxhhHPOHBP2a6MKv/XzK
         Yamy9iMPIrwf5PLaMLvHpP1JnJ8TYfEF2UZuhrCwHFs8QEVyZ2ES90VOHfK8oJoI5U0d
         0e7cSaJsMs3O9Yk0Q8/eunFUHibgHeSl66FQbzwVMAQ2NUbT3k2CK9sU58DzfCH4HgDZ
         I3S+Rw6LDMbVB2MSGGcthhOxKemJO6hBSmqCy4zt8pvz37roHiCZXKTo7SqoiBO0iW9n
         tFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7rnlHGI8UN0z1G/4uZqIH5FqitWJ4bCQ8PKnzhEumA=;
        b=WH2k+qJCw6qTaI18Fo8Wj/5MJOP0cKlRCUWWq7gDBOgH+q56+MfcsSAf00d7vkBBvI
         CdAZhQuKNT+/XSADcUIyPPmVn+zgV70VNGJmUCinyZ2fT6l7635Pbax7McftGtPcvQn4
         glHnM5nIF9ffpwTBvNG+ga2h+KZAJe+ct6ttHYAoK/ILxDoQ7tmQ5pd4cH87wbEoR6o2
         Lo4UKsLwwFWiwZxYfR3xrdPKILu0NtJOXEibrvvkJP8PADSNe7FmCvoZKVbbow015ck1
         HBXkEnsRPZhqWSd6mJSxDQALXLkO7Wa2UHVm7mx2lL7iCcGmFbO5MkSViq1uY+c5KnXC
         DlpQ==
X-Gm-Message-State: ANoB5pmJ10207/azTCpMt7wMKH3rEFJvw0/+uANdlWg0IE9iDMd5p0o9
        FtXjaDwmcZUUOCcaQ6uJdJM9Cw==
X-Google-Smtp-Source: AA0mqf4V28jx/U9NcnEY+r7qKoPQzTh7qAeK4cMVSE/XoxtGZ3WdPx2eHidPvXyk3Pi92ZkuYMZBxw==
X-Received: by 2002:a05:6512:3c82:b0:4b5:5bc1:16da with SMTP id h2-20020a0565123c8200b004b55bc116damr11657584lfv.39.1671199682494;
        Fri, 16 Dec 2022 06:08:02 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eba0a000000b0026fc79fd67dsm163265lja.74.2022.12.16.06.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 06:08:02 -0800 (PST)
Message-ID: <22a055a9-a14b-e8b7-84e2-b091a05a3ba4@linaro.org>
Date:   Fri, 16 Dec 2022 15:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v16 2/3] dt-bindings: edac: nuvoton: Add document for NPCM
 memory controller
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marvin Lin <milkfafa@gmail.com>, linux-edac@vger.kernel.org,
        rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        Rob Herring <robh@kernel.org>
References: <20221216073141.3289309-1-milkfafa@gmail.com>
 <20221216073141.3289309-3-milkfafa@gmail.com>
 <525fd984-0b67-8e11-d13c-7c4ee1853c4e@linaro.org>
In-Reply-To: <525fd984-0b67-8e11-d13c-7c4ee1853c4e@linaro.org>
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

On 16/12/2022 15:05, Krzysztof Kozlowski wrote:
> On 16/12/2022 08:31, Marvin Lin wrote:
>> Add dt-bindings document for Nuvoton NPCM memory controller.
>>
>> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> So this is a 16th version but through this entire year you never Cced
> the maintainers... You did not send a single version to the memory
> controller maintainers.
> 
> I don't know why it is so big problem to use scripts/get_maintainers.pl.

Although maybe the reason for this is that it was being put in edac
directory... eh...

Best regards,
Krzysztof

