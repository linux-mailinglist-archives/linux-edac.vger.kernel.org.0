Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378E4D5DF6
	for <lists+linux-edac@lfdr.de>; Fri, 11 Mar 2022 09:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbiCKI7i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 03:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbiCKI7h (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 03:59:37 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BB51BAF2C
        for <linux-edac@vger.kernel.org>; Fri, 11 Mar 2022 00:58:34 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 373A43F32D
        for <linux-edac@vger.kernel.org>; Fri, 11 Mar 2022 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646989113;
        bh=4oWCA4NLKvjSmIF/iS2q4v0RGuN/XnWESBLEc5FowtU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qiedKUuTHl3gPJIqzcQEEPmz6uJsMPhD0b3peWMCyBbl7oCgJbzAarfwBoB866/s7
         OHY2GNjOJNTTnzQZ/+eBsZbfdxvxl65KX3UXe4On3nlhjYcBJQnFgpJnPzg4kIiP/0
         hqGLPTh6nfieJMdwh6hB6Un7te1+QrXNVXhO5CFTefFL/dexcBYVaB4Kr8eN3LhWMx
         Cbs5asPAMZBNuKQ7QV8AdnvFGPHt1ypi/0H2cpXFk2dxKo98wnM/yKU/BxCwmRMsps
         ccRivZGoTbOXeBUWECK6df07CgoATyWhgaHc2WsyvXIJmW0zIHkrghiWharPbk8i6I
         aSvRtY99kg5OA==
Received: by mail-ed1-f72.google.com with SMTP id b9-20020aa7d489000000b0041669cd2cbfso4507593edr.16
        for <linux-edac@vger.kernel.org>; Fri, 11 Mar 2022 00:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4oWCA4NLKvjSmIF/iS2q4v0RGuN/XnWESBLEc5FowtU=;
        b=UKdPiaut53HXCNm5SlyvLE8pKhQ/S1jKR0LGk57RhZVnQO8YBYEBiY7AgvhJhmPr/t
         V/sZCQOa4TA3Os2Wu3FhXFzQJROY70xNw43YyaXPUQdsL4deOhexzTiLi7Dd6PqSnLyG
         US5NmIKzL2orjFLDlZpKyYENT6cLYPHpKS1Ut12JHVf7xCQExm25Ff7oOpxO0MpLIbQJ
         9q9kTreG2YdWmjGLj2MHgyFyt7hb0Cdk95iXv4kqzJLFG3Hs7neZ/8+MnPSojTG7OsVj
         KL31xuwa0Oil2KoQVYT2FQGXUkq/ArT8a5ELm5KwOhu1cOS5gh7bRSaYnUW73oiR/1yp
         IA5Q==
X-Gm-Message-State: AOAM53042aBdz5nyTFarx9xaKq21FDbE2eFTJ3aV7LjK/j0bq90cL+NF
        5X90X0fOKp+y8KRPJ9/ZVg/UrN0NL62VVl8Ct1E7xc8I/gWUhXS6wjsJDJCaxMd97CvISLvKHJA
        qkrq5p18AagD4mTAvJnkpgq1KlCIYFE0MRA8YtAY=
X-Received: by 2002:a17:906:7852:b0:5bb:1bdb:e95f with SMTP id p18-20020a170906785200b005bb1bdbe95fmr7861535ejm.435.1646989112769;
        Fri, 11 Mar 2022 00:58:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxO1BN5CDGpOVftYD6z0QjOIReFTewAdaLx5yU/nD7h3MjTVXoyy86j2o/DRNBRsU6XYOPTNg==
X-Received: by 2002:a17:906:7852:b0:5bb:1bdb:e95f with SMTP id p18-20020a170906785200b005bb1bdbe95fmr7861521ejm.435.1646989112541;
        Fri, 11 Mar 2022 00:58:32 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id og49-20020a1709071df100b006db0dcf673esm2742538ejc.27.2022.03.11.00.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 00:58:31 -0800 (PST)
Message-ID: <a6e719f2-2ca1-4ae6-680e-46ec0dd96969@canonical.com>
Date:   Fri, 11 Mar 2022 09:58:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings: edac:
 nuvoton,npcm-memory-controller.yaml
Content-Language: en-US
To:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, mchehab@kernel.org,
        bp@alien8.de, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20220311014245.4612-1-ctcchien@nuvoton.com>
 <20220311014245.4612-3-ctcchien@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311014245.4612-3-ctcchien@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 11/03/2022 02:42, Medad CChien wrote:
> Add device tree bindings for NPCM memory controller.

Use reasonable subject. You missed the verb describing what are you
doing here. See git history for this and other directories.

> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> new file mode 100644
> index 000000000000..46f61b0806ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/npcm-edac.yaml#

Please, test your changes. This won't work.

Best regards,
Krzysztof
