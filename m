Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757AD745BC4
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jul 2023 13:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjGCL6N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Jul 2023 07:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjGCL6K (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Jul 2023 07:58:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFFC92;
        Mon,  3 Jul 2023 04:58:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b69f1570b2so71952051fa.0;
        Mon, 03 Jul 2023 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688385486; x=1690977486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NC26RFLqCQzBMOHaR8V9Zdk8k5bjGhdLhObsmiynteo=;
        b=KMGAuhXxDeI5LBqG/Kxb8rqX5N74xytUj63x4aTS/l1L9ZQI768pqcvLEEze9qsVKr
         VytwfA/NGWWcbSZ6g92qApw5CfBFDkl1WikepLhxCwERs/r0M11FljDJ//Hll3ZCELai
         /WNgEZnVWu2/ulqzjcB//oSrR3kW+lx6et9KXLXr8SrU84LIQFW6++f/nfCPmGKY5QZN
         ztjRNThqBW8K8HZEHsw8oVcRoEEYJvyncegKGy/UezmblrHyNhHMql3IYH4SPT/MwWns
         7SalvoJXe9CzN6ofZWSv+CbGVc7l3IWbh5n9Imnvo3sIw3BPOS6e9FY/Taj6mD/y/B2s
         3Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688385486; x=1690977486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NC26RFLqCQzBMOHaR8V9Zdk8k5bjGhdLhObsmiynteo=;
        b=d5dc664eZyMsMzLCvBVzssJAPWzQIKtb9oJf/oiVEMhr+wB+3Q2Uvd5UEZL+IbliFH
         siokF8rDC06NBOSO8k2FBWzJYCpD7LBsU0K0juYKzo94jMw2wcdjdr/Kh6Lx+iYFAewX
         UZBmMUvHLSYBVa+eizEwspt5TQraUyTpSIKMrct+sCXfXmR4Nqtht1iJidVgUt4yxIzn
         1p5DE8kZhfQS659c60I7rW/RpOCORNEoMRZ8ux2W8OXlpwabsBZaaK/BLaejtqKb6RYh
         lCxLrCFY1OIr+l7qtrGckKKku/IKkKGBpxWVd19yCrLxeNvguS/X7OWI/zdMaQGdfXJZ
         r38w==
X-Gm-Message-State: ABy/qLYigl5JNGOmL497VqgRtmc4vzTPRLI4dcAs1RqItPPFVRsJAJSJ
        WqgAlIk3/U0We0HnXXKqcbU=
X-Google-Smtp-Source: APBJJlF99h6fZjeHSF9Gt68YACYVWZMS+WZYhEQ7K/I2JKYKR2luY+DmFXBgd/LIC6o5R4McQph7WQ==
X-Received: by 2002:a2e:9899:0:b0:2b6:cff1:cd1c with SMTP id b25-20020a2e9899000000b002b6cff1cd1cmr6503670ljj.34.1688385486228;
        Mon, 03 Jul 2023 04:58:06 -0700 (PDT)
Received: from mobilestation ([91.144.185.176])
        by smtp.gmail.com with ESMTPSA id n9-20020a2e82c9000000b002b3318c8d6fsm5176292ljh.28.2023.07.03.04.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 04:58:05 -0700 (PDT)
Date:   Mon, 3 Jul 2023 14:58:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/19] EDAC/mc/synopsys: Various fixes and cleanups
Message-ID: <y6j735uysubwyyzfs7vabz46ewhe7hfmp5aauk3cktduh2r6zt@lxesd43mzfyl>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
 <4488875.LvFx2qVVIh@steina-w>
 <20230525102434.lqhwtgxqfd2d3356@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230525102434.lqhwtgxqfd2d3356@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Alexander

On Thu, May 25, 2023 at 01:24:37PM +0300, Serge Semin wrote:
> Hi Alexander,
> 
> On Thu, May 25, 2023 at 08:35:59AM +0200, Alexander Stein wrote:
> > Hi,
> > 
> > Am Samstag, 10. September 2022, 21:42:18 CEST schrieb Serge Semin:
> > > This patchset is a first one in the series created in the framework of
> > > my Baikal-T1 DDRC-related work:
> > > 
> > > [1: In-progress] EDAC/mc/synopsys: Various fixes and cleanups
> > > Link: ---you are looking at it---
> > > [2: In-progress] EDAC/synopsys: Add generic DDRC info and address mapping
> > > Link:
> > > https://lore.kernel.org/linux-edac/20220822191427.27969-1-Sergey.Semin@baik
> > > alelectronics.ru [3: In-progress] EDAC/synopsys: Add generic resources and
> > > Baikal-T1 support Link:
> > > https://lore.kernel.org/linux-edac/20220822191957.28546-1-Sergey.Semin@baik
> > > alelectronics.ru
> > > 
> > > Note the patchsets above must be merged in the same order as they are
> > > placed in the list in order to prevent conflicts. Nothing prevents them
> > > from being reviewed synchronously though. Any tests are very welcome.
> > > Thanks in advance.
> > 
> > What is the state of this/these series? AFAICS only the DT patches got 
> > applied.
> > The synopsys driver got refactored quite a lot, so adding proper support for 
> > imx8mp from current state will conflict quite a lot.
> > It's a Synopsys V3.70a (without HW poisoning support!), refer to commit 
> > 68b7cf5d91d4c ("arm64: dts: imx8mp: add ddr controller node to support EDAC on 
> > imx8mp").
> 
> I has been quite busy lately in DW PCIe RP/EP/eDMA driver and my own
> deeds. But I am going to get back to this series within a month.
> Could you meanwhile have a look at it (review and tests are very
> welcome) and if possible start adding the imx8mp support based on the
> suggested patchsets (see the lore links above)?
> 
> The main goal of my changes is to generalize the driver code and make
> it working for the original Synopsys DW uMCTL2 device only with as much
> compatibility as possible with the various IP-core configs. Most
> likely adding your imx8mp DW uMCTL2 V3.70a on top of my changes will
> be much easier than writing your own changes.
> 
> Note recently I've rebased my patches on top of the latest kernel
> (6.4-rc1). Can't remember any major conflict so most likely it won't
> cause much difficulties for you too. The resultant driver works well
> for my system: DDR-phys memory space back-and-forth mapping, errors
> poisoning scrubbing, etc.
> 
> -Serge(y)

Just to let you know. I need two more weeks to settle down my current
work and then I am getting back to this series. Once again sorry for
the delay.

-Serge(y)

> 
> > 
> > Best regards,
> > Alexander
> > 
> > > Regarding this series content. It's an initial patchset which
> > > traditionally provides various fixes, cleanups and modifications required
> > > for the more comfortable further features development. The main goal of it
> > > though is to detach the Xilinx Zynq A05 DDRC related code into the
> > > dedicated driver since first it has nothing to do with the Synopsys DW
> > > uMCTL2 DDR controller and second it will be a great deal obstacle on the
> > > way of extending the Synopsys-part functionality.
> > > 
> > > The series starts with fixes patches, which in short concern the next
> > > aspects: touching the ZynqMP-specific CSRs on the Xilinx ZinqMP platform
> > > only, serializing an access to the ECCCLR register, adding correct memory
> > > devices type detection, setting a correct value to the
> > > mem_ctl_info.scrub_cap field, dropping an erroneous ADDRMAP[4] parsing and
> > > getting back a correct order of the ECC errors info detection procedure.
> > > 
> > > Afterwards the patchset provides several cleanup patches required for the
> > > more coherent code splitting up (Xilinx Zynq A05 and Synopsys DW uMCTL2)
> > > so the provided modifications would be useful in both drivers. First we
> > > get to replace the platform resource manual IO-remapping with the
> > > devm_platform_ioremap_resource() method call. Secondly we suggest to drop:
> > > internal CE/UE errors counters, local to_mci() macros definition, some
> > > redundant ecc_error_info structure fields and redundant info from the
> > > error message, duplicated dimm->nr_pages debug printout and spaces from
> > > the MEM_TYPE flags declarations. (The later two updates concern the MCI
> > > core part.) Thirdly before splitting up the driver we need to add an
> > > unique MC index allocation infrastructure to the MCI core.  It's required
> > > since after splitting the driver up we'll need to make sure both device
> > > types could be correctly probed on the same platform. Finally the Xilinx
> > > Zynq A05 part of the driver is moved out to a dedicated driver where it
> > > should been originally placed. After that the platform-specific setups API
> > > is removed from the Synopsys DW uMCTL2 DDRC driver since it's no longer
> > > required.
> > > 
> > > Finally as the cherry on the cake we suggest to unify the DW uMCTL2 DDRC
> > > driver entities naming and replace the open-coded "shift/mask" patter with
> > > the kernel helpers like BIT/GENMASK/FIELD_x in there. It shall
> > > significantly improve the code readability.
> > > 
> > > Link:
> > > https://lore.kernel.org/linux-edac/20220822190730.27277-1-Sergey.Semin@baik
> > > alelectronics.ru/ Changelog 2:
> > > - Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate patch.
> > >   (@Krzysztof)
> > > - Introduce a new compatible string "snps,dw-umctl2-ddrc" matching the new
> > >   DT-schema name.
> > > - Forgot to fix some of the prefix of the SYNPS_ZYNQMP_IRQ_REGS macro
> > >   in several places. (@tbot)
> > > - Drop the no longer used "priv" pointer from the mc_init() function.
> > >   (@tbot)
> > > - Include "linux/bitfield.h" header file to get the FIELD_GET macro
> > >   definition. (@tbot)
> > > - Drop the already merged in patches:
> > > [PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags definition
> > > [PATCH 13/20] EDAC/mc: Drop duplicated dimm->nr_pages debug printout
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > > Cc: Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>
> > > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > > Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
> > > Cc: Manish Narani <manish.narani@xilinx.com>
> > > Cc: Dinh Nguyen <dinguyen@kernel.org>
> > > Cc: James Morse <james.morse@arm.com>
> > > Cc: Robert Richter <rric@kernel.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-edac@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > 
> > > Serge Semin (19):
> > >   EDAC/synopsys: Fix native uMCTL2 IRQs handling procedure
> > >   EDAC/synopsys: Fix generic device type detection procedure
> > >   EDAC/synopsys: Fix mci->scrub_cap field setting
> > >   EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
> > >   EDAC/synopsys: Fix reading errors count before ECC status
> > >   EDAC/synopsys: Use platform device devm ioremap method
> > >   EDAC/synopsys: Drop internal CE and UE counters
> > >   EDAC/synopsys: Drop local to_mci macro implementation
> > >   EDAC/synopsys: Drop struct ecc_error_info.blknr field
> > >   EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
> > >   EDAC/synopsys: Drop redundant info from error message
> > >   EDAC/mc: Init DIMM labels in MC registration method
> > >   EDAC/mc: Add MC unique index allocation procedure
> > >   dt-bindings: memory: snps: Detach Zynq DDRC controller support
> > >   dt-bindings: memory: snps: Use more descriptive device name
> > >   EDAC/synopsys: Detach Zynq DDRC controller support
> > >   EDAC/synopsys: Drop unused platform-specific setup API
> > >   EDAC/synopsys: Unify the driver entities naming
> > >   EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros
> > > 
> > >  .../snps,dw-umctl2-ddrc.yaml                  |  56 ++
> > >  .../memory-controllers/synopsys,ddrc-ecc.yaml |  76 --
> > >  .../xlnx,zynq-ddrc-a05.yaml                   |  38 +
> > >  MAINTAINERS                                   |   3 +
> > >  drivers/edac/Kconfig                          |   9 +-
> > >  drivers/edac/Makefile                         |   1 +
> > >  drivers/edac/edac_mc.c                        | 135 ++-
> > >  drivers/edac/edac_mc.h                        |   4 +
> > >  drivers/edac/synopsys_edac.c                  | 903 ++++++------------
> > >  drivers/edac/zynq_edac.c                      | 504 ++++++++++
> > >  10 files changed, 1026 insertions(+), 703 deletions(-)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.ya
> > > ml delete mode 100644
> > > Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
> > > create mode 100644
> > > Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yam
> > > l create mode 100644 drivers/edac/zynq_edac.c
> > 
> > 
> > -- 
> > TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> > Amtsgericht München, HRB 105018
> > Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> > http://www.tq-group.com/
> > 
> > 
