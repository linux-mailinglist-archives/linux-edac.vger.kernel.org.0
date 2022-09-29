Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542E05F1837
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 03:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiJABQS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 21:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiJABPd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 21:15:33 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61120360A4;
        Fri, 30 Sep 2022 18:14:24 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 89E2DE0EB4;
        Fri, 30 Sep 2022 02:27:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:message-id
        :mime-version:reply-to:subject:subject:to:to; s=post; bh=0Vwwy5I
        okNNY7PR3PCEITVyzvb0/eDG2XwiUec7kROU=; b=T2Lfv8DeaYlf7J8dY3W1W7M
        w5tepCHuN62aI7O2pVrojA3yXF/qDR8uZfpOnjff5d1y4IWc8Kt4Y0w5u54UQ3wP
        0+TYhWP1pXUBM6TLAQNhxDRxsqdzc2lfszJtKzgJjEnYT/ByPHN0sHsT9DAxPZ2B
        7XjBHdDSras+Pby3xfp4=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 6F3C4E0E6B;
        Fri, 30 Sep 2022 02:27:24 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:27:25 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 00/17] EDAC/mc/synopsys: Various fixes and cleanups
Date:   Fri, 30 Sep 2022 02:26:55 +0300
Message-ID: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset is a first one in the series created in the framework of
my Baikal-T1 DDRC-related work:

[1: In-progress] EDAC/mc/synopsys: Various fixes and cleanups
Link: ---you are looking at it---
[2: In-progress] EDAC/synopsys: Add generic DDRC info and address mapping
Link: https://lore.kernel.org/linux-edac/20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru
[3: In-progress] EDAC/synopsys: Add generic resources and Baikal-T1 support
Link: https://lore.kernel.org/linux-edac/20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru

Note the patchsets above must be merged in the same order as they are
placed in the list in order to prevent conflicts. Nothing prevents them
from being reviewed synchronously though. Any tests are very welcome.
Thanks in advance.

Regarding this series content. It's an initial patchset which
traditionally provides various fixes, cleanups and modifications required
for the more comfortable further features development. The main goal of it
though is to detach the Xilinx Zynq A05 DDRC related code into the
dedicated driver since first it has nothing to do with the Synopsys DW
uMCTL2 DDR controller and second it will be a great deal obstacle on the
way of extending the Synopsys-part functionality.

The series starts with fixes patches, which in short concern the next
aspects: touching the ZynqMP-specific CSRs on the Xilinx ZinqMP platform
only, serializing an access to the ECCCLR register, adding correct memory
devices type detection, setting a correct value to the
mem_ctl_info.scrub_cap field, dropping an erroneous ADDRMAP[4] parsing and
getting back a correct order of the ECC errors info detection procedure.

Afterwards the patchset provides several cleanup patches required for the
more coherent code splitting up (Xilinx Zynq A05 and Synopsys DW uMCTL2)
so the provided modifications would be useful in both drivers. First we
get to replace the platform resource manual IO-remapping with the
devm_platform_ioremap_resource() method call. Secondly we suggest to drop:
internal CE/UE errors counters, local to_mci() macros definition, some
redundant ecc_error_info structure fields and redundant info from the
error message, duplicated dimm->nr_pages debug printout and spaces from
the MEM_TYPE flags declarations. (The later two updates concern the MCI
core part.) Thirdly before splitting up the driver we need to add an
unique MC index allocation infrastructure to the MCI core.  It's required
since after splitting the driver up we'll need to make sure both device
types could be correctly probed on the same platform. Finally the Xilinx
Zynq A05 part of the driver is moved out to a dedicated driver where it
should been originally placed. After that the platform-specific setups API
is removed from the Synopsys DW uMCTL2 DDRC driver since it's no longer
required.

Finally as the cherry on the cake we suggest to unify the DW uMCTL2 DDRC
driver entities naming and replace the open-coded "shift/mask" patter with
the kernel helpers like BIT/GENMASK/FIELD_x in there. It shall
significantly improve the code readability.

Link: https://lore.kernel.org/linux-edac/20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate patch.
  (@Krzysztof)
- Introduce a new compatible string "snps,dw-umctl2-ddrc" matching the new
  DT-schema name.
- Forgot to fix some of the prefix of the SYNPS_ZYNQMP_IRQ_REGS macro
  in several places. (@tbot)
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
- Include "linux/bitfield.h" header file to get the FIELD_GET macro
  definition. (@tbot)
- Drop the already merged in patches:
[PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags definition
[PATCH 13/20] EDAC/mc: Drop duplicated dimm->nr_pages debug printout

Link: https://lore.kernel.org/linux-edac/20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru
Changelog v3:
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
- Drop the merged in patches:
[PATCH v2 14/19] dt-bindings: memory: snps: Detach Zynq DDRC controller support
[PATCH v2 15/19] dt-bindings: memory: snps: Use more descriptive device name
  (@Krzysztof)

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Cc: Manish Narani <manish.narani@xilinx.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rric@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (17):
  EDAC/synopsys: Fix native uMCTL2 IRQs handling procedure
  EDAC/synopsys: Fix generic device type detection procedure
  EDAC/synopsys: Fix mci->scrub_cap field setting
  EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
  EDAC/synopsys: Fix reading errors count before ECC status
  EDAC/synopsys: Use platform device devm ioremap method
  EDAC/synopsys: Drop internal CE and UE counters
  EDAC/synopsys: Drop local to_mci macro implementation
  EDAC/synopsys: Drop struct ecc_error_info.blknr field
  EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
  EDAC/synopsys: Drop redundant info from error message
  EDAC/mc: Init DIMM labels in MC registration method
  EDAC/mc: Add MC unique index allocation procedure
  EDAC/synopsys: Detach Zynq DDRC controller support
  EDAC/synopsys: Drop unused platform-specific setup API
  EDAC/synopsys: Unify the driver entities naming
  EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros

 MAINTAINERS                  |   1 +
 drivers/edac/Kconfig         |   9 +-
 drivers/edac/Makefile        |   1 +
 drivers/edac/edac_mc.c       | 135 +++++-
 drivers/edac/edac_mc.h       |   4 +
 drivers/edac/synopsys_edac.c | 903 ++++++++++++-----------------------
 drivers/edac/zynq_edac.c     | 501 +++++++++++++++++++
 7 files changed, 927 insertions(+), 627 deletions(-)
 create mode 100644 drivers/edac/zynq_edac.c

-- 
2.37.3


