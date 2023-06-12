Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7550972C304
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jun 2023 13:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjFLLiO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Jun 2023 07:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjFLLh6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Jun 2023 07:37:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E84C3F
        for <linux-edac@vger.kernel.org>; Mon, 12 Jun 2023 04:22:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977e7d6945aso761919666b.2
        for <linux-edac@vger.kernel.org>; Mon, 12 Jun 2023 04:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686568932; x=1689160932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QGMLXBCJ+KVD5ML+B4YokOiXj70xcJWc+/yeFBBv4A=;
        b=k+Sqi9UIXs6WDxWc3Zbz6YxoyvwXYLyCjQQAuxpVjUy9uQTqL4Schqaya91FNIsiNN
         HpM9F+ruHEOXM4FZvpoYwezNteaBgHkPf3VgdyNk6ek556N9iaecvAgXKb2lALVzurm9
         hFNN4xeo9icGZkVwL0g69el+1ROSefyuwO04pgHVU0HldxBBXLNL70+xN6IR5UbjEYv+
         u7h7sp8eq3IoMrFByVGk1SDkWW6HVXqFpeoMYEBNAqod7M4ulzkam9dgpWw7/5Inqdvs
         24jN+YoBiImMUL4luqGzlAIjKHPzWs7rtyt1Zs3FUO9bhWq6sv5R0mNBx4ogxEZiHlCE
         BBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686568932; x=1689160932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QGMLXBCJ+KVD5ML+B4YokOiXj70xcJWc+/yeFBBv4A=;
        b=a4ce7RfzsU6CfCFiuVaWlKwoCcyajfCr2Lgkghsv9zxnRqz0Tx4MSDZZJptgCD6fBT
         AX7gZhhufqKrLnmRQpnuegR2iFyaSqecKZlpyO3bg+TF05Wuu6tKgL4MR5tFdcHMqjCe
         rBMiUS3jdsatpjRMSczLPH/mN7ApMFJCFee8otdazvGXwAT/xTpnV6Mzcg3zDwAvC8Q0
         axwXS7KPx703Kl5IGsv9SUq6z8iwOFvCk9gv+ej3QR4CLbn1/EB6PS04oOE5sumtI+wt
         Z01crdeatj1fSA2HqOg7vD/jbVxfhJNBACulg9CTk/LLcQMO0Cec6gitsRNZB95QPVrk
         E+lw==
X-Gm-Message-State: AC+VfDw/nDtKLvf7+pmAn28qg6ZM+brbVQI5+j7hsae9KrmEtABHbhRh
        VKpsKGch7l5fk1llUdoWn2XPSQ==
X-Google-Smtp-Source: ACHHUZ4V5meK5YYSP//aW/BgJlTyJQug2iqraw2Sh6CEiySadBQQMFKC/AjeD/XIC0xQ7a7Rc4O1cw==
X-Received: by 2002:a17:907:2d06:b0:96a:6e42:7123 with SMTP id gs6-20020a1709072d0600b0096a6e427123mr8492765ejc.36.1686568931749;
        Mon, 12 Jun 2023 04:22:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906348800b00977cfa6ff46sm5049775ejb.103.2023.06.12.04.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 04:22:11 -0700 (PDT)
Message-ID: <38c30778-9526-cba6-4ddb-00bcefeb5647@linaro.org>
Date:   Mon, 12 Jun 2023 13:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v18 1/3] ARM: dts: nuvoton: Add node for NPCM memory
 controller
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Marvin Lin <milkfafa@gmail.com>
Cc:     robh+dt@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, ctcchien@nuvoton.com,
        kflin@nuvoton.com
References: <20230111093245.318745-1-milkfafa@gmail.com>
 <20230111093245.318745-2-milkfafa@gmail.com>
 <20230612110401.GPZIb7oZPdsPGFzSDc@fat_crate.local>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612110401.GPZIb7oZPdsPGFzSDc@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 12/06/2023 13:04, Borislav Petkov wrote:
> On Wed, Jan 11, 2023 at 05:32:43PM +0800, Marvin Lin wrote:
>> Add node for memory controller present on Nuvoton NPCM SoCs. The
>> memory controller supports single bit error correction and double bit
>> error detection.
>>
>> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
>> ---
>>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
> 
> I guess this needs an Ack from OF folks if it is going to go through the
> EDAC tree ...

It is preferred this goes via Nuvoton ARM SoC tree. I don't understand
why this is first in the series - it's clearly wrong.

Best regards,
Krzysztof

