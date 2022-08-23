Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D5859D91C
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiHWJR7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 05:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350222AbiHWJQp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 05:16:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A9F88DF9;
        Tue, 23 Aug 2022 01:33:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l21so12832707ljj.2;
        Tue, 23 Aug 2022 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ZoiEZ2owYFRd9VZ4KOglg27OSgrpz66JCF4aBuAtJKk=;
        b=XOq1D3p40qntGScT26U+WRfQkKGoZxGas4gsBYkW/tlkirRYU1vMzrPsYNj7ApNwFg
         yKcin3ahiyq3dt2/3VQVxsTKwFrRiK2Mq8FAQ45mWJZ7Jx9ZiOX1Wzv6TIhCBWC7dD0c
         Acw/ckgnEivCfCEe8UU8ztCo5rzvuYzqRWvkLJb9dSHrc6+zg1mpuOo2DTl0e2tfJuzw
         hoAtsafvBXIStxBM6F3Oir2LCvFUgHpBndT1DyWnc3nOGU5t7DzIaoss1Mvh0WLv4rDW
         e3GwJfDPGN29b7m0OF0tm3kxv+gC08kZbAK4advmaoUk7b16JRuEMasHAp16vbfFZjvB
         m8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ZoiEZ2owYFRd9VZ4KOglg27OSgrpz66JCF4aBuAtJKk=;
        b=Y0ZzGZuVmPDmA2YKpghlPBjVMeZ6+WixUHyDjSkFW5/xGoLtY+w3byFOkluOV51uqU
         oIiBiCWW/Na2O0xhvkf1NFAc4ghDEyQLVXiHWrGuo9qjV8ntnaS+KJU/71kIhm476xc5
         ihF6QDMGEoEOtyftU6WbqTjHiev74KiDSE+ErDLEW8r2O2i/+8DtwyUZfXVuwg7cPxRE
         3mgPe7CqgsIg7vm1sUdSFCRCvRFZqWAoPOsTATSQVNnEJcL0tGCERCKm5ACh3pYxjciI
         XotuE1BTbgfeogsQW3f4MYPKmbgcDpYtbD8OvGVzfWGZnZbVnqAS4fkFq3DEP41t28Ig
         K/4Q==
X-Gm-Message-State: ACgBeo35aAdGCrlkX4s6ybSvTrm3HzH7ufEnLGDHTZj4kmAaU5sd+Afv
        0g4x+VYAcZ040SlRz5+X8+E=
X-Google-Smtp-Source: AA6agR5wYA3CsYSm/1lKwrkaVPJFswM19gUmuH7KYsJP6ehf6Jt3Cy2E6d4WejY2LgMSRG4PvC8y/A==
X-Received: by 2002:a05:651c:158c:b0:250:a23d:2701 with SMTP id h12-20020a05651c158c00b00250a23d2701mr7259412ljq.475.1661243566343;
        Tue, 23 Aug 2022 01:32:46 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id z20-20020a05651c11d400b0025dfd2f66d6sm1448143ljo.95.2022.08.23.01.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:32:45 -0700 (PDT)
Date:   Tue, 23 Aug 2022 11:32:43 +0300
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
Message-ID: <20220823083243.aovlgu22j7uv73qv@mobilestation>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
 <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 23, 2022 at 11:17:23AM +0300, Krzysztof Kozlowski wrote:
> On 22/08/2022 22:07, Serge Semin wrote:
> > The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
> > the CSRs layout is absolutely different and it doesn't has IRQ unlike DW
> > uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there is
> > no any reason to have these controllers described by the same bindings.
> > Thus let's split them up.
> > 
> > While at it rename the original Synopsys uMCTL2 DT-schema file to a more
> > descriptive - snps,dw-umctl2-ddrc.yaml and add a more detailed title and
> > description of the device bindings.
> 

> Filename should be based on compatible, so if renaming then
> snps,ddrc-3.80a.yaml or snps,ddrc.yaml... which leads to original
> filename anyway. Therefore nack for rename.

New requirement? I've submitted not a single patch to the DT-bindings
sources and didn't get any comment from Rob about that. In addition
There are DT bindings with names different from what is defined in the
compatible name. Moreover there are tons of bindings with various
compatible names. What name to choose then? Finally the current name
is too generic to use for actual DW uMCTL2 DDRC controller.

-Sergey

> 
> BTW, if you perform renames, generate patches with proper -M/-C/-B
> arguments so this is detected.
> 
> 
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > --->  .../snps,dw-umctl2-ddrc.yaml                  | 51 +++++++++++++
> 
> This is a mess. I did not get any cover letters, any other patches any
> description of relation between this and your other one.
> 
> It seems you make independent and conflicting changes to the same file,
> so this has to be properly organized.
> 
> Send entire patchset with cover letter with description of all
> dependencies to all maintainers.
> 
> This is unreviewable now, so a no.
> 
> Best regards,
> Krzysztof
