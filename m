Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCF231EC1
	for <lists+linux-edac@lfdr.de>; Sat,  1 Jun 2019 15:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfFANVM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 1 Jun 2019 09:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbfFANVL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 1 Jun 2019 09:21:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C312C272FE;
        Sat,  1 Jun 2019 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395270;
        bh=fKpwX+0ndO0fyq/4snZ5Zvj1X2AzAdtPXs3or6au32k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpAPS/CLmpa08wJUHjnUOW/LeFroKCYRZul5V88hTn6Qgj0ml/6ZMSkjncM+cPKRe
         cTOZBCaf2izHsv+fqZBEAGc4visUnAZoxnCHZx9sy+o6jW3aeskH09xYPfwLES9IeY
         j22f7ikQhrGw8qTYdI3YrCxBLe0zuNczOhwXTn/Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Borislav Petkov <bp@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>, linuxppc-dev@ozlabs.org,
        morbidrsa@gmail.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 035/173] EDAC/mpc85xx: Prevent building as a module
Date:   Sat,  1 Jun 2019 09:17:07 -0400
Message-Id: <20190601131934.25053-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131934.25053-1-sashal@kernel.org>
References: <20190601131934.25053-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 2b8358a951b1e2a534a54924cd8245e58a1c5fb8 ]

The mpc85xx EDAC driver can be configured as a module but then fails to
build because it uses two unexported symbols:

  ERROR: ".pci_find_hose_for_OF_device" [drivers/edac/mpc85xx_edac_mod.ko] undefined!
  ERROR: ".early_find_capability" [drivers/edac/mpc85xx_edac_mod.ko] undefined!

We don't want to export those symbols just for this driver, so make the
driver only configurable as a built-in.

This seems to have been broken since at least

  c92132f59806 ("edac/85xx: Add PCIe error interrupt edac support")

(Nov 2013).

 [ bp: make it depend on EDAC=y so that the EDAC core doesn't get built
   as a module. ]

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Johannes Thumshirn <jth@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org
Cc: morbidrsa@gmail.com
Link: https://lkml.kernel.org/r/20190502141941.12927-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index e286b5b990035..a3e6750393380 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -251,8 +251,8 @@ config EDAC_PND2
 	  micro-server but may appear on others in the future.
 
 config EDAC_MPC85XX
-	tristate "Freescale MPC83xx / MPC85xx"
-	depends on FSL_SOC
+	bool "Freescale MPC83xx / MPC85xx"
+	depends on FSL_SOC && EDAC=y
 	help
 	  Support for error detection and correction on the Freescale
 	  MPC8349, MPC8560, MPC8540, MPC8548, T4240
-- 
2.20.1

