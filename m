Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AC759C7DE
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiHVTHg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiHVTHf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:07:35 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77D2013F92;
        Mon, 22 Aug 2022 12:07:33 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 3CF0EDA2;
        Mon, 22 Aug 2022 22:10:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 3CF0EDA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195446;
        bh=EJsCN0YYd8iM5UM8xnboKosxyxlQkg+Bsj8ERpm8McY=;
        h=From:To:CC:Subject:Date:From;
        b=Xg3tMp2TRFPB7NGJpvc15j74XMqjEH/JmnFHV4zKwc9jPNLNISib3lLsXybnTB7Go
         jLe3eMtUUldOSeNjDuUapDr7TZ8oRbEsuUx2b272NDOXJSEB96k1nt4C8rYuiUagGV
         oXkGlE+7kWe4wLBZzgf3RvKJ5Bf+iK4oPDzH6N8k=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:07:31 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
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
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/20] EDAC/mc/synopsys: Various fixes and cleanups
Date:   Mon, 22 Aug 2022 22:07:10 +0300
Message-ID: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset is a first one in the series created in the framework of
my Baikal-T1 DDRC-related work:

[1: In-progress] EDAC/mc/synopsys: Various fixes and cleanups
Link: ---you are looking at it---
[2: To be submitted] EDAC/synopsys: Add generic DDRC info and address mapping
Link:
[3: To be submitted] EDAC/synopsys: Add generic resources and Baikal-T1 support
Link:

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
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (20):
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
  EDAC/mc: Replace spaces with tabs in memtype flags definition
  EDAC/mc: Drop duplicated dimm->nr_pages debug printout
  EDAC/mc: Init DIMM labels in MC registration method
  EDAC/mc: Add MC unique index allocation procedure
  dt-bindings: memory: snps: Detach Zynq DDRC controller support
  EDAC/synopsys: Detach Zynq DDRC controller support
  EDAC/synopsys: Drop unused platform-specific setup API
  EDAC/synopsys: Unify the driver entities naming
  EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros

 .../snps,dw-umctl2-ddrc.yaml                  |  51 +
 .../memory-controllers/synopsys,ddrc-ecc.yaml |  76 --
 .../xlnx,zynq-ddrc-a05.yaml                   |  38 +
 MAINTAINERS                                   |   3 +
 drivers/edac/Kconfig                          |   9 +-
 drivers/edac/Makefile                         |   1 +
 drivers/edac/edac_mc.c                        | 136 ++-
 drivers/edac/edac_mc.h                        |   4 +
 drivers/edac/synopsys_edac.c                  | 902 ++++++------------
 drivers/edac/zynq_edac.c                      | 504 ++++++++++
 include/linux/edac.h                          |  30 +-
 11 files changed, 1037 insertions(+), 717 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
 create mode 100644 drivers/edac/zynq_edac.c

-- 
2.35.1

