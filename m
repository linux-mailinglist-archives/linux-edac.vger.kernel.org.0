Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B21C41B382
	for <lists+linux-edac@lfdr.de>; Tue, 28 Sep 2021 18:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbhI1QGL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Sep 2021 12:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241821AbhI1QGJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 28 Sep 2021 12:06:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27AD96128B;
        Tue, 28 Sep 2021 16:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632845069;
        bh=P4ZkEtDSPnIoXB1tLW1afhZpMp6qUuz4Ha6J4mMMF+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=JEMBpoTvyDv5hbAmUzjdFRvle5ut7iUoFzOHkhk9cLW4vNmZvBUwYQZIhFFFIxPoZ
         DrcGaz6X8a31DTkv4uSfQYfq2qlgkPXiwAMAQeBPGQVvlhw+6gdLEFI+ktJwRhO77F
         9j7ghfylIAJlJVcJ3YXNAw+hk4NllNHhAF2ZRR3Mv8VRIUly//K/tofo8tWAgRpnaw
         /9VTJYVaSKNq2ZzpHuP5qPTjDqTojSTS8hFjFQYCF1Z5POmR0tpQguZxNsrcw17/JS
         /ikU92qwTfrim3IZa0WGPu4gASsm0xbxf2pgeom6gBJl/b25ADUTHWNC9ZRp8vsn9G
         n6bXosMPiHzaQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     michal.simek@xilinx.com
Cc:     dinguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [PATCHv3 1/3] EDAC/synopsys: use the quirk for version instead of ddr version
Date:   Tue, 28 Sep 2021 11:04:21 -0500
Message-Id: <20210928160423.271187-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Version 2.40a supports DDR_ECC_INTR_SUPPORT for a quirk, so use that
quirk to determine a call to setup_address_map().

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
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

