Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F6830A708
	for <lists+linux-edac@lfdr.de>; Mon,  1 Feb 2021 13:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhBAMAP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Feb 2021 07:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhBAL6o (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Feb 2021 06:58:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4280C06174A
        for <linux-edac@vger.kernel.org>; Mon,  1 Feb 2021 03:58:03 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l6XqE-00053w-4X; Mon, 01 Feb 2021 12:58:02 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l6Xq9-0000DF-8p; Mon, 01 Feb 2021 12:57:57 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH iv4 0/2] Add L1 and L2 error detection for A53 and A57
Date:   Mon,  1 Feb 2021 12:57:51 +0100
Message-Id: <20210201115753.18349-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi All,

As mentioned by Marc and Mark usage of the implementation defined
registers is not generally safe, they can't be used in virtualized
environments or when EL3 already uses the same registers. This is
probably the last attempt to get this upstream, I added an additional
property to the CPU device nodes to be set explicitly when using these
registers is safe and desired.

Sascha

Changes since v3:
- Add edac-enabled property to make EDAC support optional

Changes since v2:
- drop usage of virtual dt node (Robh)
- use read_sysreg_s instead of open coded variant (James Morse)
- separate error retrieving from error reporting
- use smp_call_function_single rather than smp_call_function_single_async
- make driver single instance and register all 'cpu' hierarchy up front once

Changes since v1:
- Split dt-binding into separate patch
- Sort local function variables in reverse-xmas tree order
- drop unnecessary comparison and make variable bool

Sascha Hauer (2):
  drivers/edac: Add L1 and L2 error detection for A53 and A57
  dt-bindings: arm: cpus: Add edac-enabled property

 .../devicetree/bindings/arm/cpus.yaml         |   6 +
 drivers/edac/Kconfig                          |   6 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/cortex_arm64_l1_l2.c             | 221 ++++++++++++++++++
 4 files changed, 234 insertions(+)
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.c

-- 
2.20.1

