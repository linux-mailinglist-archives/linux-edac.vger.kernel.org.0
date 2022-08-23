Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E372A59D76C
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbiHWJbj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 05:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350351AbiHWJ3W (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 05:29:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0826C923CA;
        Tue, 23 Aug 2022 01:37:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bt10so5716539lfb.1;
        Tue, 23 Aug 2022 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=vop6fItyvbYtkrV6IP5UVBH+x7wzffEHNhLEh8TzmD8=;
        b=PdX27RnPGKwVCyCypErvS8EGx+jQCxJQjsN3GR6KThiHAzdSrVqpzi6+4lJ0R2Z2ZN
         J8c+VhkgdNh7L1QWqN1bD0xhl2Zvr8pmNeW/HmfGFV7Hz51OxwuRfKtNNwThdHVBPk0j
         bvYUq4kk6NDVLPuk0qo7kCA/XHYCuEmYnKA/cVrgVYn4aCrXWyvjDKGyAij6wY0Zkn4L
         G8Czw9HygPAE3OyoUSWKNw3+EtS92m61SuRkgwjsYNNtrTn3aYAvowO87ZJBqAvbvqT/
         i1JEI0YVotddMgzWYR/8Bqbbu8j4sBbyAsh2KpC3196CGZdEeWXD67uDgRwaGzg89yc0
         cjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vop6fItyvbYtkrV6IP5UVBH+x7wzffEHNhLEh8TzmD8=;
        b=FOScH8dl/SzvDNQQfGWRhmEdtsXBDuIRugqaeSt+EN1aPksGKjX46cEjeY860DLJrB
         q3CwBPZ+50XDeR9ExSKBf+YCuVif8WLNyUY+3Fer/T6fxnWHE2e82InKOzpl0SDylCHc
         7Ldqpeje7xT6gVJIr86lwgT38bEXC9UrShCDRv8h6CmATLV4oTfX/Slj6ELgOQgkCNo4
         GgyII5Fw37KeJfDN2XVkeiFTrVCDr3V3fis+WGIGLjtfmMfU35zDYhdvmXIzzcb+S5oX
         VcOPdri9tUGWc6BCCqI/2VuASnMj/LvwnAuhL3MLYsgUnS7KX5wJuj0ldRnHPpJTGKIj
         GzLQ==
X-Gm-Message-State: ACgBeo0f+Hg5nbgidpyvSSTvP4s8+aWVMpiYRW+HGqsdf9zmcOmpmPFE
        3LkIVBuKXcN9gwnkYQkSigc=
X-Google-Smtp-Source: AA6agR5sCJFUy6q6BK/+a0nDOxzWJIe8zJFPRjdjmjK/QZnURboZ9UHk7Aq9/NiHjnaBrmGzTmHdqA==
X-Received: by 2002:a05:6512:13a1:b0:48d:f14:9059 with SMTP id p33-20020a05651213a100b0048d0f149059mr8993313lfa.110.1661243811321;
        Tue, 23 Aug 2022 01:36:51 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id bf40-20020a2eaa28000000b0025e59f125fbsm2259108ljb.53.2022.08.23.01.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:36:50 -0700 (PDT)
Date:   Tue, 23 Aug 2022 11:36:48 +0300
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
Message-ID: <20220823083648.j7hmyt4py5xqnzde@mobilestation>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
 <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
 <835938e3-e4f5-5029-9373-5dd59bc3b625@linaro.org>
 <20220823082748.td6pwkzj5grfno77@mobilestation>
 <afc181cd-46b7-4c69-d27a-d2005904f48a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc181cd-46b7-4c69-d27a-d2005904f48a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 23, 2022 at 11:30:22AM +0300, Krzysztof Kozlowski wrote:
> On 23/08/2022 11:27, Serge Semin wrote:
> > On Tue, Aug 23, 2022 at 11:22:08AM +0300, Krzysztof Kozlowski wrote:
> >> On 23/08/2022 11:17, Krzysztof Kozlowski wrote:
> >>> On 22/08/2022 22:07, Serge Semin wrote:
> >>>> The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
> >>>> the CSRs layout is absolutely different and it doesn't has IRQ unlike DW
> >>>> uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there is
> >>>> no any reason to have these controllers described by the same bindings.
> >>>> Thus let's split them up.
> >>>>
> >>>> While at it rename the original Synopsys uMCTL2 DT-schema file to a more
> >>>> descriptive - snps,dw-umctl2-ddrc.yaml and add a more detailed title and
> >>>> description of the device bindings.
> >>>
> >>> Filename should be based on compatible, so if renaming then
> >>> snps,ddrc-3.80a.yaml or snps,ddrc.yaml... which leads to original
> >>> filename anyway. Therefore nack for rename.
> >>>
> >>> BTW, if you perform renames, generate patches with proper -M/-C/-B
> >>> arguments so this is detected.
> >>>
> >>>
> >>>>
> >>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >>>> --->  .../snps,dw-umctl2-ddrc.yaml                  | 51 +++++++++++++
> >>>
> >>> This is a mess. I did not get any cover letters, any other patches any
> >>> description of relation between this and your other one.
> >>>
> >>> It seems you make independent and conflicting changes to the same file,
> >>> so this has to be properly organized.
> >>>
> >>> Send entire patchset with cover letter with description of all
> >>> dependencies to all maintainers.
> >>>
> >>> This is unreviewable now, so a no.
> >>
> > 
> >> And also untestable by Rob's bot, so will have to wait.
> > 
> > For what reason it's untestable? The patch has no dependencies from
> > any other patchset.
> 

> This one is testable, but the next one is not, because it depends on
> something. I don't see the reason to split the bindings between
> different patchsets.

Really, do you want me to collect all 55 patches in a single patchset?

Please read the cover letter more carefully. And please don't hurry
with your judgement before nacking here and there.

-Sergey

> 
> Best regards,
> Krzysztof
