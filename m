Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F094EE816
	for <lists+linux-edac@lfdr.de>; Fri,  1 Apr 2022 08:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbiDAGTH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Apr 2022 02:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiDAGTG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 1 Apr 2022 02:19:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A79A1E6E9F
        for <linux-edac@vger.kernel.org>; Thu, 31 Mar 2022 23:17:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lr4so3639818ejb.11
        for <linux-edac@vger.kernel.org>; Thu, 31 Mar 2022 23:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2TwJKrePsfMG+vTEocsT56Q0z7ebW1hBFsv6Y12aibY=;
        b=aLVtx7qPaGlbo7sC9oaFRHo6sy3YxvNEi1YbDdnBX0tdlJV2Iec401aNv5l+WOJ4Ft
         TRrCBOrXCVMJq2HtqciitvAi2coYs9KPozl9trDHNdqD6bOeotOatK4vpdC01We+E8/m
         1RBFRn2qcyilCs0Jfxa1lgWdfVQb0vsisLeCHNZuaN6pVBr/KZPiylqwTsp1j1J5WP3v
         JYP6GK53acRgy4zZzE5mkE4iIULUE8jN3KRs/N8nn0HYu5qYD0BteYidJWR/RdCTvhV3
         jlTw6c2tsJvFFkeLlqffXRlngyYTjHRBffyVEZq387TvjThgLKXamxHS7xJjscmVbub0
         k9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2TwJKrePsfMG+vTEocsT56Q0z7ebW1hBFsv6Y12aibY=;
        b=0yHMUeBNJxzcCq35XiRkESFRss6Ft1pbH/8ylbtPIrxBGP2P876eogmW3wjcgvpQAS
         WtE9Uc5GK3tY9q3xIDR0VTkx6MEtJnT4l01LRoy+lr2ieOfdFA+mbEPqBjnlrU9BD2+n
         U/gkd/D36ekg8gjw8GejTlU0s6Bl6T/QhPaL59EXQ9pbMv4kTLnfIzcxrgEZeCk8wzj/
         VoLjtZzmWNLq/4PjSfMu6ovAChpT3ZcIw5bfG3y7pbe8LqPy51m/YQ3UsJ7zLqA6DqYs
         8w7Mow6JEXwuonIU8B+2AMmdICp3CobvSBWjl91httgPk/7rtT9ru9devvN1YE5NXfIM
         PpSg==
X-Gm-Message-State: AOAM530jmN4ZhH+VYxYsqLlnINVTDhkYlK16nizSr10gyEYMIiKkUnA4
        v+LeoxDG3u3MrdS5xTwN1HbuSQ==
X-Google-Smtp-Source: ABdhPJx0+06TUOISc+VO1MjT01uD6Ml5n1QTeFunR8KRUAfAhDO43QTr7KtZezI5fbtl0e7HJ6cyaw==
X-Received: by 2002:a17:907:1614:b0:6df:678a:a7d5 with SMTP id hb20-20020a170907161400b006df678aa7d5mr7836538ejc.719.1648793835880;
        Thu, 31 Mar 2022 23:17:15 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm634137ejb.220.2022.03.31.23.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 23:17:15 -0700 (PDT)
Message-ID: <9fe715a5-8ab5-ff86-7d8f-de72eac72c97@linaro.org>
Date:   Fri, 1 Apr 2022 08:17:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] powerpc/85xx: Remove fsl,85... bindings
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Wood <oss@buserror.net>,
        Johannes Thumshirn <morbidrsa@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <82a8bc4450a4daee50ee5fada75621fecb3703ff.1648721299.git.christophe.leroy@csgroup.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <82a8bc4450a4daee50ee5fada75621fecb3703ff.1648721299.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 31/03/2022 12:13, Christophe Leroy wrote:
> Since commit 8a4ab218ef70 ("powerpc/85xx: Change deprecated binding
> for 85xx-based boards"), those bindings are not used anymore.
> 
> A comment in drivers/edac/mpc85xx_edac.c say they are to be removed
> with kernel 2.6.30.
> 
> Remove them now.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |  6 ------
>  .../devicetree/bindings/powerpc/fsl/l2cache.txt    |  6 ------
>  drivers/edac/mpc85xx_edac.c                        | 14 --------------
>  3 files changed, 26 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
