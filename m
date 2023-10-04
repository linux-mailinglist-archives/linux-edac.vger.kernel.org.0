Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4CC7B8067
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242600AbjJDNNv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbjJDNNt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:49 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C7D197
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gX-0006n6-QV; Wed, 04 Oct 2023 15:13:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gU-00B2gu-1n; Wed, 04 Oct 2023 15:13:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gT-008zBw-Mz; Wed, 04 Oct 2023 15:13:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel@pengutronix.de, Jan Luebbe <jlu@pengutronix.de>,
        Stefan Schaeckeler <sschaeck@cisco.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Shravan Kumar Ramani <shravankr@nvidia.com>,
        Lei Wang <lewan@microsoft.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Marvin Lin <kflin@nuvoton.com>,
        Stanley Chu <yschu@nuvoton.com>, openbmc@lists.ozlabs.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
        Tero Kristo <kristo@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 00/21] EDAC: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:33 +0200
Message-Id: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3651; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WYjQl7z9JGj88YgXlzr7fZyIrt99MtmffigaMEwVLic=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWSMI7Uzjg0jWISOPMOlv6sqLKMPV7Kc5vy8j H3uo7zXHU2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1kjAAKCRCPgPtYfRL+ ThSxB/48lI0ZArL+PONe/VbpImFjsyvMaqK3m8vABGLugaugQvPm+ezKMfrdFHZgn/ag7/OOU3m XrGh+rCegvcwGx0jkdCEU3JHVXKaBXj3405UQW4i3KKagwAY4NlFN81UDt36FAd0tsgJWSR0u68 QFR8kLWJhQdGyoWr4lB9768zAid1x9iokYdEuJyOixF9DY9MzfI8ao/bZYdLE/jjf2uPjvNR5nZ lebunfEllY1iT3vKLz956CEZGFtPcimD1rG/yVaHkFmkmPIwXwjc9s+3/B6lUoNQUfLqPTAHq/U 84R8vcdKFarqQ2t+hdu3pIYjSTl6TCvvBAnupEiwM7I/h+Sb
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/edac to use
.remove_new(). The motivation is to get rid of an integer return code
that is (mostly) ignored by the platform driver core and error prone on
the driver side. However none of the edac drivers suffered from the easy
to make bug, so all drivers are converted in a trivial way.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

The patch for npcm was already sent back in June
(https://lore.kernel.org/linux-edac/20230628071354.665300-1-u.kleine-koenig@pengutronix.de)
but didn't result in enthusiastic review comments and it wasn't picked
up.

There are no interdependencies between the patches. As there are still
quite a few drivers to convert, I'm happy about every patch that makes
it in. So even if there is a merge conflict with one patch until you
apply, please apply the remainder of this series anyhow. I'll come back
to the part that you (maybe) skipped at a later point.

Best regards
Uwe

Uwe Kleine-König (21):
  EDAC/altera: Convert to platform remove callback returning void
  EDAC/armada_xp: Convert to platform remove callback returning void
  EDAC/aspeed: Convert to platform remove callback returning void
  EDAC/bluefield: Convert to platform remove callback returning void
  EDAC/cell: Convert to platform remove callback returning void
  EDAC/cpc925: Convert to platform remove callback returning void
  EDAC/dmc520: Convert to platform remove callback returning void
  EDAC/highbank_l2: Convert to platform remove callback returning void
  EDAC/highbank_mc: Convert to platform remove callback returning void
  EDAC/mpc85xx: Convert to platform remove callback returning void
  EDAC/npcm: Convert to platform remove callback returning void
  EDAC/octeon-l2c: Convert to platform remove callback returning void
  EDAC/octeon-lmc: Convert to platform remove callback returning void
  EDAC/octeon-pc: Convert to platform remove callback returning void
  EDAC/octeon-pci: Convert to platform remove callback returning void
  EDAC/ppc4xx: Convert to platform remove callback returning void
  EDAC/qcom: Convert to platform remove callback returning void
  EDAC/synopsys: Convert to platform remove callback returning void
  EDAC/ti: Convert to platform remove callback returning void
  EDAC/xgene: Convert to platform remove callback returning void
  EDAC/zynqmp: Convert to platform remove callback returning void

 drivers/edac/altera_edac.c      | 12 ++++--------
 drivers/edac/armada_xp_edac.c   | 12 ++++--------
 drivers/edac/aspeed_edac.c      |  6 ++----
 drivers/edac/bluefield_edac.c   |  6 ++----
 drivers/edac/cell_edac.c        |  5 ++---
 drivers/edac/cpc925_edac.c      |  6 ++----
 drivers/edac/dmc520_edac.c      |  6 ++----
 drivers/edac/highbank_l2_edac.c |  5 ++---
 drivers/edac/highbank_mc_edac.c |  5 ++---
 drivers/edac/mpc85xx_edac.c     | 11 ++++-------
 drivers/edac/npcm_edac.c        |  6 ++----
 drivers/edac/octeon_edac-l2c.c  |  6 ++----
 drivers/edac/octeon_edac-lmc.c  |  5 ++---
 drivers/edac/octeon_edac-pc.c   |  5 ++---
 drivers/edac/octeon_edac-pci.c  |  6 ++----
 drivers/edac/ppc4xx_edac.c      |  7 ++-----
 drivers/edac/qcom_edac.c        |  6 ++----
 drivers/edac/synopsys_edac.c    |  6 ++----
 drivers/edac/ti_edac.c          |  6 ++----
 drivers/edac/xgene_edac.c       |  6 ++----
 drivers/edac/zynqmp_edac.c      |  6 ++----
 21 files changed, 48 insertions(+), 91 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

