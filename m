Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A723541B383
	for <lists+linux-edac@lfdr.de>; Tue, 28 Sep 2021 18:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbhI1QGL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Sep 2021 12:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241832AbhI1QGK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 28 Sep 2021 12:06:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F08661357;
        Tue, 28 Sep 2021 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632845071;
        bh=Fq/JqCT+osi1O4JBR74Hu4wp20lUJtI7S1DtsM/0L1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+x9v2lo/9dHvyvqQT88lVO1mNqd4esG6DbliMXAYLlo6waE7w2fZnd8balFyWRJ+
         lvFqdco7E0buebBtGf5NIa/+puge62/k1KYZV8zFMjX7cR97T68iyQkPTiZ/1uXK2s
         1PWc6dIl8LoOjLhhhTaK5pjRdVfiTvs4sV65j6yBhgXqM95u+sKxrMTZdCo3iKT5x7
         5lMGdvpIUtH+z1KdyFE3BcD9+fs0ZKHU3aEoQFCSCMcyWL6SJ69ZS63ylHXR5BvYM0
         kTEL9vk342Q9o7VKwQBfy4YA0NZMzpqitzMyg0mOopMJhLmePuMWWQDA1fZUuiwUth
         2do87/vz2mKPA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     michal.simek@xilinx.com
Cc:     dinguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [PATCHv3 3/3] EDAC/synopsys: v3.80a of the synopsys edac contoller is also on the N5X
Date:   Tue, 28 Sep 2021 11:04:23 -0500
Message-Id: <20210928160423.271187-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928160423.271187-1-dinguyen@kernel.org>
References: <20210928160423.271187-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Intel's N5X platform is also using the Synopsys EDAC controller.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
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

