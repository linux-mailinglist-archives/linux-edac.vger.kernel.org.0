Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA63D40EDB8
	for <lists+linux-edac@lfdr.de>; Fri, 17 Sep 2021 01:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbhIPXOQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Sep 2021 19:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241424AbhIPXOM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Sep 2021 19:14:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69C4161207;
        Thu, 16 Sep 2021 23:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631833971;
        bh=lgwwHwJaUSTOpaC6rM+1sKIX081VOJVPAVfOgDBtSQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZyiW2bHj2IMIH1GZdnCAwunUT7URPV/2m/BPKWYQ/Qe6LOxRmvRZjGl9X5+lwn58
         Vr/VxSFCcZHkXJx7hnbYA7OVjjLvRYt1plGqofqWPvMHze8QDM+wxknDsQcH+MWCVb
         kg05cptu7hjTc8JclPnL+0NVBJkvu0/v95CzVG4bPhJwarLksJlPn4UzZRcwrtVTlP
         fYpWZEBUaqiSCKfh6PMTFjbB/DxYZy6aFpybl5xnmZbWtsdsytaHja2j2YcFM4IgWn
         iJewZvZdv96LxIEOqG9gHr6HxSo3vjcSvZofn3XrY0LcEot1EES+3YExO8ICLXmm9g
         GkQOnkscTwa+w==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     michal.simek@xilinx.com
Cc:     dinguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [PATCHv2 2/2] EDAC/synopsys: v3.80a of the synopsys edac contoller is also on the N5X
Date:   Thu, 16 Sep 2021 18:12:31 -0500
Message-Id: <20210916231231.1430499-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916231231.1430499-1-dinguyen@kernel.org>
References: <20210916231231.1430499-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Intel's N5X platform is also using the Synopsys EDAC controller.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: no changes
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

