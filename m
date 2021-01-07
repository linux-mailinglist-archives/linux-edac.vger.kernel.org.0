Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2852ECE06
	for <lists+linux-edac@lfdr.de>; Thu,  7 Jan 2021 11:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbhAGKjF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Jan 2021 05:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbhAGKjE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 7 Jan 2021 05:39:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26566C0612F5
        for <linux-edac@vger.kernel.org>; Thu,  7 Jan 2021 02:38:24 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kxSgQ-0000bO-Jw; Thu, 07 Jan 2021 11:38:22 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kxSgO-000766-Fm; Thu, 07 Jan 2021 11:38:20 +0100
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
Subject: [PATCH v3 0/1] Add L1 and L2 error detection for A53 and A57
Date:   Thu,  7 Jan 2021 11:38:18 +0100
Message-Id: <20210107103819.13552-1-s.hauer@pengutronix.de>
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

Hi all,

It's been a while since I last sent this, so here's an update.

Like Rob suggested I dropped using a virtual device tree node
to attach the driver to, so from the original three patches series
is only one patch left now. I think I have integrated all review
feedback I got last time, please have a look.

One thing that I find unfortunate in the driver is that I have to
register the "cpu" hierarchy under edac for all CPUs. Only the
CPUs supported by this driver actually count anything. On JUNO for
example we have four cortex-a53 cores (which are supported by this
driver) and four cortex-a72 cores (which are not supported).
Nevertheless we create the directory hierarchy for all eight cores.
I don't know how I should work around this, but maybe James has an
idea.

As usual, feedback welcome.

Sascha

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

Sascha Hauer (1):
  drivers/edac: Add L1 and L2 error detection for A53 and A57

 drivers/edac/Kconfig              |   6 +
 drivers/edac/Makefile             |   1 +
 drivers/edac/cortex_arm64_l1_l2.c | 218 ++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.c

-- 
2.20.1

