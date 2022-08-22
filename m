Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D063559C84A
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiHVTOg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbiHVTOf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:14:35 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32108D123;
        Mon, 22 Aug 2022 12:14:33 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 17BADDA2;
        Mon, 22 Aug 2022 22:17:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 17BADDA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195866;
        bh=qoJ69h1k3U6tE2d+piipf8/dBLDjRPPtovgGvrTg9Ts=;
        h=From:To:CC:Subject:Date:From;
        b=IVZL/LhecFnAtXC3Ze0iETn7tASb6e6IzApXB1rAjrFnKSnhcYPh0biqXO7ce78LT
         iwZBvr3w/lIQjzAdu+9VzyqNhmAb14d2cZApUq6vw/jCRLtuK/QP7eGB6o+fBkIUc0
         sXrhsfCTGONbh43w+96t30d1jlSfYrZWZ2SuTcR4=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:14:28 +0300
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/18] EDAC/synopsys: Add generic DDRC info and address mapping
Date:   Mon, 22 Aug 2022 22:14:09 +0300
Message-ID: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
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

This patchset is a second one in the series created in the framework of my
Baikal-T1 DDRC-related work:

[1: In-progress] EDAC/mc/synopsys: Various fixes and cleanups
Link: https://lore.kernel.org/linux-edac/20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru/
[2: In-progress] EDAC/synopsys: Add generic DDRC info and address mapping
Link: ---you are looking at it---
[3: To be submitted] EDAC/synopsys: Add generic resources and Baikal-T1 support
Link:

Note the patchsets above must be merged in the same order as they are
placed in the list in order to prevent conflicts. Nothing prevents them
from being reviewed synchronously though. Any tests are very welcome.
Thanks in advance.

The second patchset mainly concerns converting the DW uMCTL2 DDRC driver
to being more generic so later it would be extended with our DDR
controller support and further with new DW uMCTL2 DDRC IP-core
compilations.

The series starts with the Error-injection functionality movement to
DebugFS. Indeed the Debug-parts should be in the dedicated DebugFS. SysFS
is not a place for it, moreover seeing later we'll add some more debug
nodes.

Afterwards even though it isn't advertised but even at this stage the DW
uMCTL2 DDRC driver supports a bit more DDR protocols than it actually
specifies in the mem_ctrl_info.mtype_cap field. So first we suggest to
extend the MCI core memory types enumeration with LPDDR (mDDR) and LPDDR2,
which support can be enabled in the DW uMCTL2 DDR controller. Second we
need to make sure all the possible DDR protocol types are correctly
detected during the DW uMCTL DDRC probe procedure.

Then a bit painful patch goes. Alas we have to deviate the driver from the
EDAC standard private data allocation/initialization pattern. Since we are
going to add the DW uMCTL2 IP-core specific parameters detection procedure
and later on implement additional platform resources requests there is no
other choice but to allocate the driver private data at the early stage of
the device probe procedure even before it's possible to allocate the MCI
descriptor. The DW uMCTL2 DDRC platform resources and configuration info
will be then utilized to properly allocate and initialize the
mem_ctrl_info structure instance.

Third patch in the series is very important. It provides the DW uMCTL2
DDRC parameters detection procedure. The DDRC and ECC parameters detected
at this stage will be then utilized to make the driver working with much
wider set of the DW uMCTL2 revisions and configurations. In particular
from now the driver will retrieve the next DDRC info at the probe stage:
ECC type, SDRAM protocol (DDR type), Full and actual DQ-bus width, SDRAM
and HIF burst length, Core/SDRAM frequency ration, number of SDRAM ranks.
The DDRC parameters structure will be extended with some more fields later
in this and the next patchset. The provided private DDRC parameters
infrastructure can be utilized to implement the platform-specific
capabilities so the platform data and its quirks are replaced with it.

The detected at the probe stage DW uMCTL2 DDRC parameters can be now used
to implement the configuration specific functionality. In particular first
we introduce the conditional ADDRMAP* CSRs mapping since some of these
CSRs and their fields are left unused by the controller in some cases.
Secondly actual DIMM ECC errors grain, ECC corrected bit, full data
pattern and syndrome are determined based on the DDRC parameters.

Afterwards goes a series of the patches which introduce an interface to
generically determine the system address based on the SDRAM address and
vice-versa. Thus we'll be able to report actual PFN and offset in case of
the corrected and uncorrected errors. So first we get to convert the
currently available HIF/SDRAM mapping table utilized for the
errors-injection functionality into a more generic Sys<->SDRAM address
translation interface. Secondly we suggest to conform the SDRAM column
address mapping detection algorithm with what is defined in the DW uMCTL2
DDRC hw reference manual. After adding a handy DebugFS node to read the
HIF/SDRAM mapping and the system address regions support we finally
introduce the erroneous page-frame/offset reporting to the MCI core. Since
the full SDRAM address mapping is now always available we suggest to use
it for the attached memory size calculation, which is a more correct
approach rather than the si_meminfo()-based one.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Cc: Manish Narani <manish.narani@xilinx.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (18):
  EDAC/synopsys: Convert sysfs nodes to debugfs ones
  EDAC/mc: Extend memtypes with LPDDR(mDDR) and LPDDR2
  EDAC/synopsys: Extend memtypes supported by controller
  EDAC/synopsys: Detach private data from mci instance
  EDAC/synopsys: Add DDRC basic parameters infrastructure
  EDAC/synopsys: Convert plat-data to plat-init function
  EDAC/synopsys: Parse ADDRMAP[7-8] CSRs for (LP)DDR4 only
  EDAC/synopsys: Parse ADDRMAP[0] CSR for multi-ranks case only
  EDAC/synopsys: Set actual DIMM ECC errors grain
  EDAC/synopsys: Get corrected bit position
  EDAC/synopsys: Read full data pattern on errors
  EDAC/synopsys: Read data syndrome on errors
  EDAC/synopsys: Introduce System/SDRAM address translation interface
  EDAC/synopsys: Simplify HIF/SDRAM column mapping get procedure
  EDAC/synopsys: Add HIF/SDRAM mapping debugfs node
  EDAC/synopsys: Add erroneous page-frame/offset reporting
  EDAC/synopsys: Add system address regions support
  EDAC/synopsys: Add mapping-based memory size calculation

 drivers/edac/edac_mc.c       |    2 +
 drivers/edac/synopsys_edac.c | 1773 ++++++++++++++++++++++++----------
 include/linux/edac.h         |    6 +
 3 files changed, 1290 insertions(+), 491 deletions(-)

-- 
2.35.1

