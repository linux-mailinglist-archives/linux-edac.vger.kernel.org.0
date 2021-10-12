Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951BD42ACF6
	for <lists+linux-edac@lfdr.de>; Tue, 12 Oct 2021 21:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhJLTJW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Oct 2021 15:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhJLTJT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Oct 2021 15:09:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4013A610A2;
        Tue, 12 Oct 2021 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634065637;
        bh=UFYdT5fM/ew8+GaYjoEF6ruKEwsdbZaQwxx70se9Yxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cL/HZdF1BXvszd0aNiYtg6bzYCssVMKsXN7VssOBkyBqDxsvmUkSFr9AgQd8b6NnF
         LRsf6CZ1XPs5bpeSdDnKn7Vyrozh1m3lsvhq4PecdEaH+NeTtb36cGk2FfkvHMbe3R
         eBmH3oDXIuxnHkH6A5Sw4JDLW2jQuyeRufwruT4ylfjWV4PAi7QWUZqHIGOfCG7Yw2
         RxXD/6vX0jBp40mzwNyrfuV1kuFsqTOFaF8ce/kYe2mJ5FXlk5eciLQNLGyUTohJhY
         sV6aKtWtNgWyjnuJpf01ZAeBm+XxG3vJKWeu5Rd8/8ahcro3SMZ7vKUm+QNwmwZ7AI
         YgVLZZ5E55Kcw==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     bp@alien8.de
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
Subject: [PATCHv4 3/4] EDAC/synopsys: v3.80a of the synopsys edac contoller is also on the N5X
Date:   Tue, 12 Oct 2021 14:07:08 -0500
Message-Id: <20211012190709.1504152-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012190709.1504152-1-dinguyen@kernel.org>
References: <20211012190709.1504152-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Intel's N5X platform is also using the Synopsys EDAC controller.

Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v4: Add Acked-by
v3: s/ARCH_N5X/ARCH_INTEL_SOCFPGA
v2: no changes
---
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 2fc4c3f91fd5..58ab63642e72 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -484,7 +484,7 @@ config EDAC_ARMADA_XP
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ || ARCH_ZYNQMP
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
-- 
2.25.1

