Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D50228CEB6
	for <lists+linux-edac@lfdr.de>; Tue, 13 Oct 2020 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgJMMu5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Oct 2020 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgJMMu5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Oct 2020 08:50:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08181C0613D0
        for <linux-edac@vger.kernel.org>; Tue, 13 Oct 2020 05:50:57 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kSJlE-0007ld-21; Tue, 13 Oct 2020 14:50:36 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kSJlC-0005qJ-Kv; Tue, 13 Oct 2020 14:50:34 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 0/3] Add L1 and L2 error detection for A53 and A57
Date:   Tue, 13 Oct 2020 14:50:30 +0200
Message-Id: <20201013125033.4749-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This driver is based on an earlier version from York Sun which can
be found here: https://lkml.org/lkml/2018/3/14/1203.

At that time the conclusion was that this driver is not suitable for
mainline as it used IMPLEMENTATION DEFINED CPU registers and also
NXP specific SMC calls. All this was used for the error injection only,
for error reporting it is not needed.

This is another try to get this driver to mainline. All error injection
code has been removed (though it has initially been used to test this
driver on an i.MX8 SoC), what's left is unfortunately not testable, but
also doesn't contain none of the doubtful code anymore.

Changes since v1:
- Split dt-binding into separate patch
- Sort local function variables in reverse-xmas tree order
- drop unnecessary comparison and make variable bool

Sascha Hauer (2):
  dt-bindings: edac: Add binding for L1/L2 error detection for Cortex
    A53/57
  drivers/edac: Add L1 and L2 error detection for A53 and A57

York Sun (1):
  arm64: dts: ls104x: Add L1/L2 cache edac node

 .../bindings/edac/arm,cortex-a5x-edac.yaml    |  32 +++
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   5 +
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   5 +
 drivers/edac/Kconfig                          |   6 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/cortex_arm64_l1_l2.c             | 208 ++++++++++++++++++
 6 files changed, 257 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.c

-- 
2.28.0

