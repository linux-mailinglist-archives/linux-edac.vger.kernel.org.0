Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D006159D525
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 11:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347733AbiHWJEE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbiHWJDO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 05:03:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65AD543E7;
        Tue, 23 Aug 2022 01:28:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z25so18694693lfr.2;
        Tue, 23 Aug 2022 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=a+ZiSUJIOvdtJPK+j/qpvFXRwgI/m4zmsjhCjwSrMY4=;
        b=HfhF4Yw93JyMUnP2WKwYbtvgoDB0wLycPBhfsc9EzKdUYSYK+blL2pZnRHeF5yp8m3
         B7z2Md2tkAZcUC+ZqeyyS3S02khD6xMZRyUrjntb+wYdY3tayPV80q2cAmUynSZfygAH
         VzrG9GAwoJr1/+7uyo93XwVYunYg2hcFkcSPdRUDRln3g/Oe2tHjQ2kJpPxzPcXs+HcO
         Zp5Nm8U55oBPz9MOa999P43phZ2aM4iz9fZFaVics/5Wy4rJKR4cnbfzaeoufRyQF6v2
         vqNFnYnX8NODgDvgvM/cE04nah8VYlbGluIxEPaAwENAcGFAUVCw4T2zF2Amzgb2uyrH
         DNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=a+ZiSUJIOvdtJPK+j/qpvFXRwgI/m4zmsjhCjwSrMY4=;
        b=nSUlqqS3EeJ7BlXIYBKNERMU+a79wS4Rs94WUpzqEu9w6SF8H4y/tHp/QAM4Tnir2a
         CUU+ZzRwlWqC41eVoCoCQ3x+5ClpI9xq366IMHXXwhfd5YKOLNvU0qAuG3VTpLpqIqtc
         RY36t3zHSuENYR/ob5zV0RtgiqJKftzUsWXwwJEiyIpr0Cy4eTSlF6P3Bx9s0wiTKGre
         D0hSzsKDXUU9KLxGPtLrUAzREghgHm8kuAeL4xFJ2YjdjMkbXfcYxIsONJrOxr8KaNZ3
         tLDAhLjPJvSCvXoFPGrzI1/3WmYCY/vAdEne/uXEr5/KEmaH/uz3BJxR7WZuNXhZ0d80
         tRHw==
X-Gm-Message-State: ACgBeo1UCEEzxAmTkCJUeV1pmyKbe8gXFpq6pRX/73QXcEx37zPfgEb1
        cpPjG9ZhOz+bF2ELf/7tCZ8=
X-Google-Smtp-Source: AA6agR55UulqBm6Z7CFG3oQTuAKk1CpakKcC1y/U1jNhrnuMrpHCyELrD+8qqpIz1hYgHcLh2JpzAA==
X-Received: by 2002:a19:ad49:0:b0:492:f465:73fa with SMTP id s9-20020a19ad49000000b00492f46573famr743825lfd.308.1661243271560;
        Tue, 23 Aug 2022 01:27:51 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id e18-20020a05651236d200b00492b0d23d24sm315282lfs.247.2022.08.23.01.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:27:50 -0700 (PDT)
Date:   Tue, 23 Aug 2022 11:27:48 +0300
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
Message-ID: <20220823082748.td6pwkzj5grfno77@mobilestation>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
 <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
 <835938e3-e4f5-5029-9373-5dd59bc3b625@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <835938e3-e4f5-5029-9373-5dd59bc3b625@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 23, 2022 at 11:22:08AM +0300, Krzysztof Kozlowski wrote:
> On 23/08/2022 11:17, Krzysztof Kozlowski wrote:
> > On 22/08/2022 22:07, Serge Semin wrote:
> >> The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
> >> the CSRs layout is absolutely different and it doesn't has IRQ unlike DW
> >> uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there is
> >> no any reason to have these controllers described by the same bindings.
> >> Thus let's split them up.
> >>
> >> While at it rename the original Synopsys uMCTL2 DT-schema file to a more
> >> descriptive - snps,dw-umctl2-ddrc.yaml and add a more detailed title and
> >> description of the device bindings.
> > 
> > Filename should be based on compatible, so if renaming then
> > snps,ddrc-3.80a.yaml or snps,ddrc.yaml... which leads to original
> > filename anyway. Therefore nack for rename.
> > 
> > BTW, if you perform renames, generate patches with proper -M/-C/-B
> > arguments so this is detected.
> > 
> > 
> >>
> >> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >> --->  .../snps,dw-umctl2-ddrc.yaml                  | 51 +++++++++++++
> > 
> > This is a mess. I did not get any cover letters, any other patches any
> > description of relation between this and your other one.
> > 
> > It seems you make independent and conflicting changes to the same file,
> > so this has to be properly organized.
> > 
> > Send entire patchset with cover letter with description of all
> > dependencies to all maintainers.
> > 
> > This is unreviewable now, so a no.
> 

> And also untestable by Rob's bot, so will have to wait.

For what reason it's untestable? The patch has no dependencies from
any other patchset.

-Sergey

> 
> I found the cover letters, somehow they got buried in inbox.
> 
> Best regards,
> Krzysztof
