Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8B7105B4
	for <lists+linux-edac@lfdr.de>; Thu, 25 May 2023 08:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjEYGgI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 May 2023 02:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjEYGgH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 May 2023 02:36:07 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948D187;
        Wed, 24 May 2023 23:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1684996562; x=1716532562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hBFA23DvtteSUTXvjD6xllHeEa7Xzq+7Vmp8PXfxQSw=;
  b=n/EbsO2WU501J7P6/zXS+kPTs3tPtgCG1yhDhutoFtVUJpmH9C3C5xh+
   wcaYg0cDaxlao4ljNR6M4J6o4hDyd38eRf/1qenkeS4hZz8P4su4Ua4nT
   o17xtU94uLXLvybs6pnKOf3+oNkZqfmfkDLITK36DurWYSUTYpKlsOT8T
   zPqQCXuyE++tqzVIVr9ADEzPathDAupPhB5/KBwqMJz1oz5idccwH5wI5
   pkPghbgx5X4YQY+3PKjb32D/EsKWEImL616JYKusmuRXwu1OxkEKWi4U2
   gaG4MfSVH03XWBQ8yUD+zmrcjm9elcf5KLYZw5r280NN32m6/XXrk1X/s
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,190,1681164000"; 
   d="scan'208";a="31088100"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 May 2023 08:36:00 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 25 May 2023 08:36:00 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 25 May 2023 08:36:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1684996560; x=1716532560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hBFA23DvtteSUTXvjD6xllHeEa7Xzq+7Vmp8PXfxQSw=;
  b=Cj63FBNyKp3ZC5ReJFDZJ5e2JrzPBT1/EhePF9kcGdb8NZLLYO643R+p
   mPW/2jdRGvCCKLdORz++KmMiu8QltBPislCDXX16MU3OOwXNBa99M3SsI
   bEdTle5YYZOPUunJ8tmZ8jXlCZcr9H6iCH0UahQ2+12RaIMLc2kHOrCOe
   WXeruZcOjd+yBkLrwiJmc/MKgHvRHaKTFixNmtqq6ZHToToHldTDVdn/J
   /0lM9GXEjvWJpi02mEP1PY5eUFC8qa5NOaxsEyOD01qhDfibsObXTJCv/
   H+4mNmVavrxX8buez0NMCT/1NIWgfoM3GJj+0vfoLW7irXMnyzhvmGuue
   A==;
X-IronPort-AV: E=Sophos;i="6.00,190,1681164000"; 
   d="scan'208";a="31088099"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 May 2023 08:35:59 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 51172280082;
        Thu, 25 May 2023 08:35:59 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
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
Date:   Thu, 25 May 2023 08:35:59 +0200
Message-ID: <4488875.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

Am Samstag, 10. September 2022, 21:42:18 CEST schrieb Serge Semin:
> This patchset is a first one in the series created in the framework of
> my Baikal-T1 DDRC-related work:
>=20
> [1: In-progress] EDAC/mc/synopsys: Various fixes and cleanups
> Link: ---you are looking at it---
> [2: In-progress] EDAC/synopsys: Add generic DDRC info and address mapping
> Link:
> https://lore.kernel.org/linux-edac/20220822191427.27969-1-Sergey.Semin@ba=
ik
> alelectronics.ru [3: In-progress] EDAC/synopsys: Add generic resources and
> Baikal-T1 support Link:
> https://lore.kernel.org/linux-edac/20220822191957.28546-1-Sergey.Semin@ba=
ik
> alelectronics.ru
>=20
> Note the patchsets above must be merged in the same order as they are
> placed in the list in order to prevent conflicts. Nothing prevents them
> from being reviewed synchronously though. Any tests are very welcome.
> Thanks in advance.

What is the state of this/these series? AFAICS only the DT patches got=20
applied.
The synopsys driver got refactored quite a lot, so adding proper support fo=
r=20
imx8mp from current state will conflict quite a lot.
It's a Synopsys V3.70a (without HW poisoning support!), refer to commit=20
68b7cf5d91d4c ("arm64: dts: imx8mp: add ddr controller node to support EDAC=
 on=20
imx8mp").

Best regards,
Alexander

> Regarding this series content. It's an initial patchset which
> traditionally provides various fixes, cleanups and modifications required
> for the more comfortable further features development. The main goal of it
> though is to detach the Xilinx Zynq A05 DDRC related code into the
> dedicated driver since first it has nothing to do with the Synopsys DW
> uMCTL2 DDR controller and second it will be a great deal obstacle on the
> way of extending the Synopsys-part functionality.
>=20
> The series starts with fixes patches, which in short concern the next
> aspects: touching the ZynqMP-specific CSRs on the Xilinx ZinqMP platform
> only, serializing an access to the ECCCLR register, adding correct memory
> devices type detection, setting a correct value to the
> mem_ctl_info.scrub_cap field, dropping an erroneous ADDRMAP[4] parsing and
> getting back a correct order of the ECC errors info detection procedure.
>=20
> Afterwards the patchset provides several cleanup patches required for the
> more coherent code splitting up (Xilinx Zynq A05 and Synopsys DW uMCTL2)
> so the provided modifications would be useful in both drivers. First we
> get to replace the platform resource manual IO-remapping with the
> devm_platform_ioremap_resource() method call. Secondly we suggest to drop:
> internal CE/UE errors counters, local to_mci() macros definition, some
> redundant ecc_error_info structure fields and redundant info from the
> error message, duplicated dimm->nr_pages debug printout and spaces from
> the MEM_TYPE flags declarations. (The later two updates concern the MCI
> core part.) Thirdly before splitting up the driver we need to add an
> unique MC index allocation infrastructure to the MCI core.  It's required
> since after splitting the driver up we'll need to make sure both device
> types could be correctly probed on the same platform. Finally the Xilinx
> Zynq A05 part of the driver is moved out to a dedicated driver where it
> should been originally placed. After that the platform-specific setups API
> is removed from the Synopsys DW uMCTL2 DDRC driver since it's no longer
> required.
>=20
> Finally as the cherry on the cake we suggest to unify the DW uMCTL2 DDRC
> driver entities naming and replace the open-coded "shift/mask" patter with
> the kernel helpers like BIT/GENMASK/FIELD_x in there. It shall
> significantly improve the code readability.
>=20
> Link:
> https://lore.kernel.org/linux-edac/20220822190730.27277-1-Sergey.Semin@ba=
ik
> alelectronics.ru/ Changelog 2:
> - Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate patch.
>   (@Krzysztof)
> - Introduce a new compatible string "snps,dw-umctl2-ddrc" matching the new
>   DT-schema name.
> - Forgot to fix some of the prefix of the SYNPS_ZYNQMP_IRQ_REGS macro
>   in several places. (@tbot)
> - Drop the no longer used "priv" pointer from the mc_init() function.
>   (@tbot)
> - Include "linux/bitfield.h" header file to get the FIELD_GET macro
>   definition. (@tbot)
> - Drop the already merged in patches:
> [PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags definiti=
on
> [PATCH 13/20] EDAC/mc: Drop duplicated dimm->nr_pages debug printout
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
> Cc: Manish Narani <manish.narani@xilinx.com>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> Serge Semin (19):
>   EDAC/synopsys: Fix native uMCTL2 IRQs handling procedure
>   EDAC/synopsys: Fix generic device type detection procedure
>   EDAC/synopsys: Fix mci->scrub_cap field setting
>   EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
>   EDAC/synopsys: Fix reading errors count before ECC status
>   EDAC/synopsys: Use platform device devm ioremap method
>   EDAC/synopsys: Drop internal CE and UE counters
>   EDAC/synopsys: Drop local to_mci macro implementation
>   EDAC/synopsys: Drop struct ecc_error_info.blknr field
>   EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
>   EDAC/synopsys: Drop redundant info from error message
>   EDAC/mc: Init DIMM labels in MC registration method
>   EDAC/mc: Add MC unique index allocation procedure
>   dt-bindings: memory: snps: Detach Zynq DDRC controller support
>   dt-bindings: memory: snps: Use more descriptive device name
>   EDAC/synopsys: Detach Zynq DDRC controller support
>   EDAC/synopsys: Drop unused platform-specific setup API
>   EDAC/synopsys: Unify the driver entities naming
>   EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros
>=20
>  .../snps,dw-umctl2-ddrc.yaml                  |  56 ++
>  .../memory-controllers/synopsys,ddrc-ecc.yaml |  76 --
>  .../xlnx,zynq-ddrc-a05.yaml                   |  38 +
>  MAINTAINERS                                   |   3 +
>  drivers/edac/Kconfig                          |   9 +-
>  drivers/edac/Makefile                         |   1 +
>  drivers/edac/edac_mc.c                        | 135 ++-
>  drivers/edac/edac_mc.h                        |   4 +
>  drivers/edac/synopsys_edac.c                  | 903 ++++++------------
>  drivers/edac/zynq_edac.c                      | 504 ++++++++++
>  10 files changed, 1026 insertions(+), 703 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.=
ya
> ml delete mode 100644
> Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.ya=
ml
> create mode 100644
> Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.y=
am
> l create mode 100644 drivers/edac/zynq_edac.c


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


