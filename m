Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED055B4887
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiIJT5E (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIJT5D (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:57:03 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10BF4422EB;
        Sat, 10 Sep 2022 12:57:02 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id DE4ADDA3;
        Sat, 10 Sep 2022 23:00:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com DE4ADDA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662840052;
        bh=CY2r3bV7Jbhzu2zWeMrVoLV8kOdfoxV0JaUmxZlJeZQ=;
        h=From:To:CC:Subject:Date:From;
        b=RRkj7RQLuxLeyn/E6nJ9t6uVJc9RR6Q1rYEYYI80HGw4Y7wxacOkae3sOjX2MIcBY
         QVJXctVvTlfUuMPVnqXyu8aNyhGF3QjKCgrSy/vZiRBdYeAQjj+tc9ifoAUFs2ON4t
         +UHdH/z7UY/t7MQ+n/haf24i2oS9ZXCLB31TVfpk=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:57:00 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/15] EDAC/synopsys: Add generic resources and Baikal-T1 support
Date:   Sat, 10 Sep 2022 22:56:44 +0300
Message-ID: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset is a third one in the series created in the framework of my
Baikal-T1 DDRC-related work:

[1: In-progress] EDAC/mc/synopsys: Various fixes and cleanups
Link: https://lore.kernel.org/linux-edac/20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru
[2: In-progress] EDAC/synopsys: Add generic DDRC info and address mapping
Link: https://lore.kernel.org/linux-edac/20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru
[3: In-progress] EDAC/synopsys: Add generic resources and Baikal-T1 support
Link: ---you are looking at it---

Note the patchsets above must be merged in the same order as they are
placed in the list in order to prevent conflicts. Nothing prevents them
from being reviewed synchronously though. Any tests are very welcome.
Thanks in advance.

This is a final patchset in the framework of my Synopsys DW uMCTL2 DDRC
work, which completes the driver updates with the new functionality and
at the closure introduces the Baikal-T1 DDRC support.

The series starts from extending the Synopsys DW uMCTL2 DDRC DT-schema
with the controller specific IRQs, clocks and resets properties. In
addition to the Baikal-T1 DDRC is added to the DT-bindings since it's
based on the DW uMCTL2 DDRC v2.61a.

After that we suggest to finally inform the MCI core with the detected
SDRAM ranks and make sure the detected errors are reported to the
corresponding rank. Then we extend the DDRC capabilities with optional
Scrub functionality. It's indeed possible to have the DW uMCTL2 controller
with no HW-accelerated Scrub support (no RMW engine). In that case the MCI
core is supposed to perform the erroneous location ECC update by means of
the platform-specific scrub method.

Then we get to fix the error-injection functionality a bit. First since
the driver now has the Sys<->SDRAM address translation infrastructure we
can use it to convert the supplied poisonous system address to the SDRAM
one. Thus there is no longer need in preserving the address in the device
private data. Second we suggest to add a DebuFS node-based command to
disable the error-injection feature (no idea why it hasn't been done in
the first place).

Afterwards a series of the IRQ-related patches goes. First we introduce the
individual DDRC event IRQs support in accordance with what has been added
to the DT-bindings and what the native DW uMCTL2 DDR controller actually
provides. Then aside to the ECC CE/UE errors detection we suggest to the
DFI/SDRAM CRC/Parity errors report. It specifically useful for the DDR4
memory which has dedicated ALARM_n signal, but can be still utilized in
the framework of the older protocols if the device DFI-PHY calculates
the HIF-interface signals parity. Third after adding the platform
clock/resets request procedure we introduce the HW-accelerated Scrubber
support. Its performance can be tuned by means of the sdram_scrub_rate
SysFS node and the Core clock rate. Note it is possible to one-time-run
the Scrubber in the back-to-back mode so to perform a burst-like scan of
the whole SDRAM memory.

At the patchset closure we finally fix the DW uMCTL2 DDRC kernel config to
be available not only on the Xilinx, Intel and MXC platforms and add the
Baikal-T1 DDRC support which the whole work has been dedicated for in the
first place.

Link: https://lore.kernel.org/linux-edac/20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Replace "snps,ddrc-3.80a" compatible string with "snps,dw-umctl2-ddrc"
  in the example.
- Move unrelated changes in to the dedicated patches. (@Krzysztof)
- Use the IRQ macros in the example. (@Krzysztof)
- Add a new patch:
[PATCH v2 01/15] dt-bindings: memory: snps: Replace opencoded numbers with macros
  (@Krzysztof)
- Add a new patch:
[PATCH v2 03/15] dt-bindings: memory: snps: Convert the schema to being generic
  (@Krzysztof)
- Drop the PHY CSR region. (@Rob)
- Move the Baikal-T1 DDRC bindings to the separate DT-schema.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Cc: Manish Narani <manish.narani@xilinx.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rric@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (15):
  dt-bindings: memory: snps: Replace opencoded numbers with macros
  dt-bindings: memory: snps: Extend schema with IRQs/resets/clocks props
  dt-bindings: memory: snps: Convert the schema to being generic
  dt-bindings: memory: Add Baikal-T1 DDRC DT-schema
  EDAC/synopsys: Add multi-ranked memory support
  EDAC/synopsys: Add optional ECC Scrub support
  EDAC/synopsys: Drop ECC poison address from private data
  EDAC/synopsys: Add data poisoning disable support
  EDAC/synopsys: Split up ECC UE/CE IRQs handler
  EDAC/synopsys: Add individual named ECC IRQs support
  EDAC/synopsys: Add DFI alert_n IRQ support
  EDAC/synopsys: Add reference clocks support
  EDAC/synopsys: Add ECC Scrubber support
  EDAC/synopsys: Drop vendor-specific arch dependency
  EDAC/synopsys: Add Baikal-T1 DDRC support

 .../memory-controllers/baikal,bt1-ddrc.yaml   |  91 ++
 .../snps,dw-umctl2-ddrc.yaml                  |  83 +-
 drivers/edac/Kconfig                          |   1 -
 drivers/edac/synopsys_edac.c                  | 952 ++++++++++++++----
 4 files changed, 931 insertions(+), 196 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml

-- 
2.37.2

