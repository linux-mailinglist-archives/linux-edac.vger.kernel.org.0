Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F077619B44
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2019 12:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfEJKPq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 May 2019 06:15:46 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47636 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfEJKPp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 May 2019 06:15:45 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CAABE891AD;
        Fri, 10 May 2019 22:15:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1557483340;
        bh=On8oRpSMr9n7y+jn0PyfMJc06liZSsVfOPwylqHrUoU=;
        h=From:To:Cc:Subject:Date;
        b=mDw/iZnvLKj+CSlmDMAnuGUoEwt1Q9shVT6hjsSdmnjp07GUxxIhxBEvPxVFxGjhk
         FBpmAI27gvA1INf+JFE5dvzt9rsr/IkG5fwLWR68jueSgNzb9lh4y051WAxIXRiP28
         VOd1L41QWEtgt5dj18puSqJHB4d/8YPRY9glwnFejPTKkf5D+RuaSoH8fZNrK7kCWV
         XtEoAToY+BwVwhsFX/SnssGAL0hY9L61z8ucsvKK41d45zJPygNULwX6bQ2THPwarr
         LAy11Zk4kQt1GrMlZ/oRD2ZSsdOhkBUurFGWhuI9jiyXmKsVxljpf6zSpJhjns9hIS
         /i1a3XA1ICL0Q==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cd54f4c0000>; Fri, 10 May 2019 22:15:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 896D913EEA0;
        Fri, 10 May 2019 22:15:39 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 1B34B1E1D5B; Fri, 10 May 2019 22:15:39 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, mark.rutland@arm.com,
        robh+dt@kernel.org, mchehab@kernel.org, james.morse@arm.com,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 0/9] EDAC drivers for Armada XP L2 and DDR
Date:   Fri, 10 May 2019 22:15:27 +1200
Message-Id: <20190510101536.6724-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Reviews/Acks have been given so this should be good to go in via the =
ARM
tree as planned.

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-August/525561.=
html

This series adds drivers for the L2 cache and DDR RAM ECC functionality a=
s
found on the MV78230/MV78x60 SoCs. Jan has tested these changes with the
MV78460 (on a custom board with a DDR3 ECC DIMM), Chris has tested these
changes with 88F6820 and 98dx3236 (both a custom boards with fixed DDR3 +=
 ECC).

Also contained in this series is an additional debugfs wrapper.

Compared to the previous v7 series this has been rebased against 5.1 requ=
iring
some changes in the devicetree binding documentation.

Compared to the previous v6 series I've dropped the marvell,ecc-disable
property.

Compared to the previous v5 series I've split the dt-binding documentatio=
n into
its own patch and updated armada_xp_edac.c to use a SPDX license.

Compared to the previous v4 series I've added my s-o-b to some of Jan's
patches and rebased against v4.19.0.

Compared to the previous v3 series, the following changes have been made:
- Use shorter names for the AURORA ECC and parity registers
- Numerous formatting changes to edac/armada_xp.c (as requested by Boris)
- Added support for Armada-38x and 98dx3236 SoCs

Compared to the previous v2 series, the following changes have been made:
- Allocate EDAC structures later during probing and drop devres support
  patches (requested by Boris)
- Make drvdata->width usage consistent according to the comment (suggeste=
d by
  Chris)

Compared to the previous v1 series, the following changes have been made:
- Add the aurora-l2 register defines earlier in the series (suggested by
  Russell King and Gregory CLEMENT )
- Changed the DT vendor prefix from "arm" to "marvell" for the ecc-enable=
/disable
  properties on the aurora-l2 (suggested by Russell King)
- Fix some warnings reported by checkpatch

Compared to the original RFC series, the following changes have been made=
:
- Integrated Chris' patches for parity and ECC configuration via DT
- Merged the DDR RAM and L2 cache drivers (as requested by Boris, analogo=
us
  to fsl_ddr_edac.c and mpc85xx_edac.c)
- Added myself to MAINTAINERS (requested by Boris)
- L2 cache: Track the msg size and use snprintf (review comment by Chris)
- L2 cache: Split error injection from the check function (review comment=
 by
  Chris)
- DDR RAM: Allow 16 bit width in addition to 32 and 64 bit (review commen=
t by
  Chris)
- Use of_match_ptr() (review comments by Chris)
- Minor checkpatch cleanups


Chris Packham (4):
  ARM: l2x0: support parity-enable/disable on aurora
  dt-bindings: ARM: document marvell,ecc-enable binding
  ARM: l2x0: add marvell,ecc-enable property for aurora
  EDAC: armada_xp: Add support for more SoCs

Jan Luebbe (5):
  ARM: l2c: move cache-aurora-l2.h to asm/hardware
  ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
  ARM: aurora-l2: add defines for parity and ECC registers
  EDAC: Add missing debugfs_create_x32 wrapper
  EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC

 .../devicetree/bindings/arm/l2c2x0.yaml       |   4 +
 MAINTAINERS                                   |   6 +
 .../asm/hardware}/cache-aurora-l2.h           |  50 +-
 arch/arm/mm/cache-l2x0.c                      |  18 +-
 drivers/edac/Kconfig                          |   7 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/armada_xp_edac.c                 | 635 ++++++++++++++++++
 drivers/edac/debugfs.c                        |  11 +
 drivers/edac/edac_module.h                    |   5 +
 9 files changed, 733 insertions(+), 4 deletions(-)
 rename arch/arm/{mm =3D> include/asm/hardware}/cache-aurora-l2.h (50%)
 create mode 100644 drivers/edac/armada_xp_edac.c

--=20
2.21.0

