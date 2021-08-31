Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A820A3FCE20
	for <lists+linux-edac@lfdr.de>; Tue, 31 Aug 2021 22:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbhHaUEh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 31 Aug 2021 16:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234441AbhHaUEg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 31 Aug 2021 16:04:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A7661075;
        Tue, 31 Aug 2021 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630440220;
        bh=+lMli70NJUXEf9vtprMnRCsGAsbyRhC3+FkwvxVEl8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2nzvncSunoPktXn4wmJIbtZq8Sx+puGhroI/rGMMN7Z65hR1md/rGCjmpJJfoj+1
         SueIpa1IFci3GX/sMIoCS48rwzttiEt/gX85LvOPy84kdm4jiWras4KDt8DBDWB751
         6WLslxu4BR+dD6EJ8rWkMRtBWPDn+qdyHYk4FqdQJmZhfktJ6o+UVEyUGOcARwzSSL
         G7P9SHGZI6nlQu5B/Ytu55L4XOOFOpRGj4z5riiRZjPoYNdK9Ukc3qtdyn2TEDdBCF
         uyriPelcbKfZiDpou14B3UPXgXqNDOjg+ziN8bDMRi2n9J5rFmFfbaDGGMYDYhOkUD
         DbxLubqTad7xw==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     michal.simek@xilinx.com
Cc:     dinguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [PATCH 2/2] EDAC/synopsys: v3.80a of the synopsys edac contoller is also on the N5X
Date:   Tue, 31 Aug 2021 15:03:16 -0500
Message-Id: <20210831200316.3208310-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831200316.3208310-1-dinguyen@kernel.org>
References: <20210831200316.3208310-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Intel's N5X platform is also using the Synopsys EDAC controller.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 2fc4c3f91fd5..df46e7483aa0 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -484,7 +484,7 @@ config EDAC_ARMADA_XP
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ || ARCH_ZYNQMP
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_N5X
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
-- 
2.25.1

