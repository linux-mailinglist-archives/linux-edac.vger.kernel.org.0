Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E44542ACF3
	for <lists+linux-edac@lfdr.de>; Tue, 12 Oct 2021 21:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhJLTJV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Oct 2021 15:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232502AbhJLTJS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Oct 2021 15:09:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F23A60F3A;
        Tue, 12 Oct 2021 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634065635;
        bh=dq25YDDgZtRWCgeIsWvsLSv7VHseIKNSZpeaKIwUbDY=;
        h=From:To:Cc:Subject:Date:From;
        b=uckfq2Ug9DsGxJmvutLCPQLJGrfh6oL/HiPdGlcxg2QmuU7SHoVfouFH68Ao+9NvY
         ciDOFwGaArgMTlP/SrSyvKZr04be9l181TrhmygaS0o0YQbEhhtNuHPcrna19i/MMR
         9roVAp9jpOMFuC0ttYUs9YtSNiRSRM0OEzYYLB14aSnTESChzWOOfw1UgpApXfyYpM
         fLts/Yg9N5QkhbBliwnWBI7lx5omOgAGESh2INyUxC4OFX6fvuSV8Byt8wNRcWZ3RX
         RBYUyhzP3wNxhqyPSl6oEc1eyVuELjrzb183litHLGo6lt7ogTT8wXR2O0gAsvY++o
         D47J2TDA0Yiig==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     bp@alien8.de
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
Subject: [PATCHv4 1/4] EDAC/synopsys: use the quirk for version instead of ddr version
Date:   Tue, 12 Oct 2021 14:07:06 -0500
Message-Id: <20211012190709.1504152-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Version 2.40a supports DDR_ECC_INTR_SUPPORT for a quirk, so use that
quirk to determine a call to setup_address_map().

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v4: add Reviewed-by
v3: new patch
---
 drivers/edac/synopsys_edac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7e7146b22c16..bf237fccb444 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1352,8 +1352,7 @@ static int mc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "xlnx,zynqmp-ddrc-2.40a"))
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
 		setup_address_map(priv);
 #endif
 
-- 
2.25.1

