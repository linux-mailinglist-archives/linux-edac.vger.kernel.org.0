Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6659D5E9
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbiHWI7c (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242396AbiHWI7Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 04:59:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090872848;
        Tue, 23 Aug 2022 01:26:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q18so11800449ljg.12;
        Tue, 23 Aug 2022 01:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=INFiREuc8tsqsS8aIeq0sv6L+CLqHoDlQnC1BP60eqw=;
        b=B42M+pKRB4ohHIy8nIxLiSRgc9jG1RBhSbh1D9TVeitjtgZrRyQz9UW35CFAWV3wEp
         tWTMllOQHMXwnbxt2vUie0VD1Rd2GoHLGdDufOpzmD5WAH0oa3wGchYYWziTZmDVVwuM
         uGR9cw/OZ4bXu6vnKkoYXNhsxD3hIGS7s3+Ce9U+RFlMHE7yUrJ6iesGXQdhkGQDt7DV
         /WJ7gLDggNUyvLk2S12bpgCEyC7HacTy2UskAxRWhJQ/C2BoI+u+YHP0l5lGfmu/Na+6
         h4380FDniPHBHb4NXRA0xEFljxLT6FrdZhjzhxDe0RkG4M0wKdE6eXyoc0+Qnv7O0B23
         l0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=INFiREuc8tsqsS8aIeq0sv6L+CLqHoDlQnC1BP60eqw=;
        b=qJpSeSu74uaN6njGgEyTfdvJvISY1fBui3eBQRfnFZhuxBU0iFWYsAxel5lcJvx1L/
         YBrZKBGmkSInyB5DxT1MlHICgnb2Sn+vKGfFX/jb7+9Ip6qpN0/54nnENQTM0pjWqPAG
         xHWW0fZy28D5YvYUBAf5Ma82x7gMcEp4zr9k2Li76filfTC+QyOF/St6MhmtTEtkmAk3
         avEPSJcB1MSVYzVXhNyzstfdcWuPIgNsw6WQXBibKWPzzpHKapt16eNcuXUXipvSW0TP
         J8pd7O1TdQxtu1JUZPtp3vFA59q7ExD077VD+siKr+WHap0OrTkQRfYNTSeL/p/oz4Q1
         lsOA==
X-Gm-Message-State: ACgBeo0e03DZQHTSckE9/P2q3tKngdq5NkMdpYTMPhwCcFAxPFaWHqVO
        DQN5y3gsmpikbqStI13rlFE=
X-Google-Smtp-Source: AA6agR5Y6dLqZK4sNhaxcRwxDwyvypLkJXmZRN8Qcs1Fy/yZuE7/O7iNlqrScaudcfqaVAre1/8i0A==
X-Received: by 2002:a2e:934f:0:b0:250:a7bc:2b8f with SMTP id m15-20020a2e934f000000b00250a7bc2b8fmr6733479ljh.512.1661243135386;
        Tue, 23 Aug 2022 01:25:35 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id d12-20020a056512368c00b00492ce573726sm1908764lfs.47.2022.08.23.01.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:25:34 -0700 (PDT)
Date:   Tue, 23 Aug 2022 11:25:32 +0300
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
Message-ID: <20220823082532.gf3m6466rzfxmtns@mobilestation>
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

Don't hurry with the judgement. Have a better look at your DT-related
inbox.
Link: https://lore.kernel.org/linux-devicetree/20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru/

-Sergey

> 
> Send entire patchset with cover letter with description of all
> dependencies to all maintainers.
> 
> This is unreviewable now, so a no.
> 
> Best regards,
> Krzysztof
