Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C65A11F7
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbiHYNXn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 09:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242550AbiHYNXl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 09:23:41 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA66AAA3FA;
        Thu, 25 Aug 2022 06:23:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d8so15830494lfq.0;
        Thu, 25 Aug 2022 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6LhGjtWIW9co1/2gs66rsVEFtLVzBG4QOkw2+wFNu3c=;
        b=pPPpzZ45RGXaqlXi8hum48NG1uQB4nXdUDPMYgvTTQtsRrOHiVqto00m6MXd9s4O9j
         wPglL+1RN0amf4snG38/0fA85YH9oBBVoIq5MoCERAdMboZbVErLUerT+PsG7HecAwR9
         bV3IkmP5bZVH3hwAe0y5ujSup4dil+Y+YzlnBJWbclaHpuD5YxrRDCHfBU1HpmxypqLU
         Krb2A5KbjVfSAwY/oGJZuLLdzgGG/8ujaktIzgaPmwNVi8Ym+B8nNlWFkobYIVEnCBIc
         LOkrlfIrHoCMaLxe0Dxn69ATpClotpkRmrscKObF3yQWAx0Fd+xLNFaRtW35Ad1O0t40
         z3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6LhGjtWIW9co1/2gs66rsVEFtLVzBG4QOkw2+wFNu3c=;
        b=SclGqvo70QCq+J6SC8DV8Au+6FR/BbXXdgdQbQgNHefiNs5kNYGDjHzjAJxtrnX8nq
         tDd2tmTNbgPnTc1t3/Re8vIi0S4E5t45aot8vp+aHAgFd/xyoExk5Ex/9gyBCcmRCn0Z
         piezN4zFbXcR/cWOMPMh0ymDK5DcHnPkCxizmzIzt0e9xw1uPxDB8hxb+MGbIKp//V5R
         hRzGMdozTGKjUfp4soIK7kUNMtgPBFmLITaECYKuivxazpfqhyCeaoZO32cN0AndjzVJ
         KW+SEd6SVl94XIOU7N6w4RAq9KJtSHD8tAFaL2p750JgwzuEH7DBqEQ3/sa1rUzf/Lbq
         P2xw==
X-Gm-Message-State: ACgBeo09L1VOpmrx5tOHAKqE/AiaJe5JzoCtTHOXJ3EKMDiQrmU+D8yd
        lcW9JlE0YUA1qiAfBuiXqpI=
X-Google-Smtp-Source: AA6agR49lHBZ9hF6YLntUa9KLE3iJhihwzflelrNicDUZ7cENiTbU1B0ArinDwRISS9DiDl3F+++Eg==
X-Received: by 2002:ac2:4c4a:0:b0:492:c912:c166 with SMTP id o10-20020ac24c4a000000b00492c912c166mr1117140lfk.543.1661433818330;
        Thu, 25 Aug 2022 06:23:38 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id p8-20020a056512312800b00492e69be4d6sm505324lfd.27.2022.08.25.06.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 06:23:37 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:23:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/20] dt-bindings: memory: snps: Detach Zynq DDRC
 controller support
Message-ID: <20220825132335.f7mxjyomz6a5zybf@mobilestation>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
 <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
 <20220823083243.aovlgu22j7uv73qv@mobilestation>
 <166c0198-17c4-3b19-77fe-632d65f17cb0@linaro.org>
 <20220823114516.4mcufkbmzy5gjdcr@mobilestation>
 <6661dcc1-cc93-efbb-b248-0d93f681a1bf@linaro.org>
 <20220824172724.ny2xpryn76h6ftv6@mobilestation>
 <a04f6b56-4bca-cc86-c51f-3a7c6c7ef02a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04f6b56-4bca-cc86-c51f-3a7c6c7ef02a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 25, 2022 at 09:06:42AM +0300, Krzysztof Kozlowski wrote:
> On 24/08/2022 20:27, Serge Semin wrote:
> 
> > 
> > Note what Rob said concerned the generic compatible "fallback" case,
> > not the generic compatible string in general. It's ok to have a
> > generic device name defined irrespective to the platform vendor.
> > Moreover it's applicable in case of the DW uMCTL2 DDRC IP-core since
> > first IP-core version is auto-detectable starting from v3.20a and
> > second I managed to implement auto-detection solutions for almost
> > all the DDR/ECC-specific parameters. So I am more inclined to the
> > solution 1) suggested by me in the previous email message:
> > - deprecate "snps,ddrc-3.80a" string.
> > - add new generic "snps,dw-umctl2-ddrc" compatible string.
> > - rename the DT-bindings file.
> 
> Sounds ok.

Agreed then.

> 
> > 
> >>
> >> Here the Linux driver also binds to generic synopsys compatible, so I
> >> would assume it has a meaning and use case on its own.
> > 
> > Please see my messages above regarding the current Synopsys DW uMCTL2
> > EDAC driver implementation.
> > 
> >>
> >>>
> >>> What do you think?
> >>>
> >>> * Note I've got it you'd prefer the renaming being performed in a
> >>> separate patch.
> >>
> >> The rename could be in the split patch as here, but then I assume the
> >> rename part to be detected by git and be a pure rename. However:
> >> 1. The git did not mark it as rename (you might need to use custom
> >> arguments to -M/-B/-C),
> > 
> > Of course git hasn't detected it as rename, because aside with renaming
> > I've split the bindings up. Splitting these two updates up into two
> > patches will give us what you said. So to speak I suggest the next
> > updates for v2:
> > PATCH X. Detach the Zynq A05 DDRC DT-bindings to a separate schema.
> > PATCH X + 1. Rename the Synopsys DW uMCTL2 DDRC bindings file and add a more
> > descriptive generic compatible string name.
> > 
> > What do you think?
> 

> Regardless of the split the rename can be and should be detected by Git.
> That's why we have these options. If it is not detected, you changed too
> much during rename, so it is not a rename anymore. Relatively small
> amount of changes would still be detected.

Right. I'll make sure the renaming is detected.

-Sergey

> 
> > 
> >> 2. There were also changes in the process (allOf:if:then).
> > 
> > Right. But this is in another patchset. I'll address your notes in there.
> 
> 
> Best regards,
> Krzysztof
