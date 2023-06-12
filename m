Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6D972C3AF
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jun 2023 14:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjFLMJn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Jun 2023 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjFLMJn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Jun 2023 08:09:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7D693
        for <linux-edac@vger.kernel.org>; Mon, 12 Jun 2023 05:09:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51868eb05ecso202738a12.2
        for <linux-edac@vger.kernel.org>; Mon, 12 Jun 2023 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686571777; x=1689163777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+01ianr3tUZ3eESran8R7G5sZ53mYz+EHDLZT2vY3Q=;
        b=djDgh+tBxfdKYOv7XNyVvI5PMNPi38s/ZsEXln7bk7ptiVzVkLzq1WlhU4jIxeYG7X
         oV+Wkonm6Q2VTGqjtauqQQROeiEEEbK7zF6BE/k5TPO1gh7T1Gh7xgjGDbqe226Du6G9
         thvVefWXCOKCZVpYHXyjH+8cldKr+80ptxmfTS3kgyMaR2AqIC4daYTJXqz+PajCMBFr
         SeTGbgxVEvgsQ7D5AsPVeyNEKANzaoFRVNh8XVWG/RAFFrw16GBT6bT/opOIWNTZxDZE
         lbcGW3zLfDWOPpCwd6wayZjWHRL20Ha/GdQbopiBid2mmBstGk7VQ2G72F/3HAlzkcNh
         K8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686571777; x=1689163777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+01ianr3tUZ3eESran8R7G5sZ53mYz+EHDLZT2vY3Q=;
        b=TTC9tz1AblJbrew3s6NChweU0P3818iODtvPGj6avI0tEsipSSJuGbT4qjOWwmZx+B
         Wd8ZtutoLRfifv3Tln/b5WsKWkl+63GxYXow3AaZBfngu7A2m/4G0+rC2DSjLaUDIzBB
         6BkD941g5CbfUI9qRtD7jD2WS05Xekow97ArhXSu5vq1n3EflSrtNq1fBh3uTAWPsEsS
         A3E71EiI2kbwsgehtRWzMnwDd1l1ipvPHmQNJjiR8rLv3f5GgicPVcNrJPKd5aiZxXNI
         of32Tdw3qSvadfOdU7XgxWDgzDAYKKitcvbESWVLU5nsfK8w0cYYVGWn8wURR8H4SgTK
         5uSA==
X-Gm-Message-State: AC+VfDwwsQDxlhSqoLd+DEi2wCiaFq7o0VRCB16MamaULknSLLsiAepE
        8gTBj8wWja5E0fVE9aIN6UM5Vg==
X-Google-Smtp-Source: ACHHUZ7ITZMdkmI+fk4BZG/dSab2/4y/xZBPCVdLXhmZW5KwMGkCVjdsNdrawuRVLjiC7ixjbeCRBA==
X-Received: by 2002:a17:907:948f:b0:973:afe2:a01 with SMTP id dm15-20020a170907948f00b00973afe20a01mr8185808ejc.75.1686571776785;
        Mon, 12 Jun 2023 05:09:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906a29400b00977fb2fb44asm5204861ejz.28.2023.06.12.05.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:09:36 -0700 (PDT)
Message-ID: <99795947-0584-df42-a28a-aa89d7e21c7e@linaro.org>
Date:   Mon, 12 Jun 2023 14:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v18 1/3] ARM: dts: nuvoton: Add node for NPCM memory
 controller
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Marvin Lin <milkfafa@gmail.com>, robh+dt@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        ctcchien@nuvoton.com, kflin@nuvoton.com
References: <20230111093245.318745-1-milkfafa@gmail.com>
 <20230111093245.318745-2-milkfafa@gmail.com>
 <20230612110401.GPZIb7oZPdsPGFzSDc@fat_crate.local>
 <38c30778-9526-cba6-4ddb-00bcefeb5647@linaro.org>
 <20230612120107.GFZIcJA3zktkiyTS2+@fat_crate.local>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612120107.GFZIcJA3zktkiyTS2+@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 12/06/2023 14:01, Borislav Petkov wrote:
> On Mon, Jun 12, 2023 at 01:22:09PM +0200, Krzysztof Kozlowski wrote:
>> It is preferred this goes via Nuvoton ARM SoC tree. I don't understand
>> why this is first in the series - it's clearly wrong.
> 
> Don't ask me...
> 
> So the EDAC driver itself is self-contained so I can review it and you
> can pick it up with the rest, if it looks ok.
> 
> That ok?

Yes. Please review and take the EDAC driver and the bindings (2/3, they
already have my ack).

Marvin,
Please route the DTS (1/3) via Nuvoton SoC tree.

Best regards,
Krzysztof

