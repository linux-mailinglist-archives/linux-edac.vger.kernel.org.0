Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B00A11B3A
	for <lists+linux-edac@lfdr.de>; Thu,  2 May 2019 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEBOTr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 May 2019 10:19:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39513 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfEBOTr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 May 2019 10:19:47 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44vy803DdJz9sBr; Fri,  3 May 2019 00:19:44 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linux-edac@vger.kernel.org
Cc:     morbidrsa@gmail.com, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: [PATCH] EDAC, mpc85xx: Prevent building as a module
Date:   Fri,  3 May 2019 00:19:41 +1000
Message-Id: <20190502141941.12927-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The mpc85xx EDAC code can be configured as a module but then fails to
build because it uses two unexported symbols:

  ERROR: ".pci_find_hose_for_OF_device" [drivers/edac/mpc85xx_edac_mod.ko] undefined!
  ERROR: ".early_find_capability" [drivers/edac/mpc85xx_edac_mod.ko] undefined!

We don't want to export those symbols just for this driver, so make
the driver only configurable as a built-in.

This seems to have been broken since at least commit c92132f59806
("edac/85xx: Add PCIe error interrupt edac support") (Nov 2013).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 47eb4d13ed5f..6317519f9d88 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -263,7 +263,7 @@ config EDAC_PND2
 	  micro-server but may appear on others in the future.
 
 config EDAC_MPC85XX
-	tristate "Freescale MPC83xx / MPC85xx"
+	bool "Freescale MPC83xx / MPC85xx"
 	depends on FSL_SOC
 	help
 	  Support for error detection and correction on the Freescale
-- 
2.20.1

