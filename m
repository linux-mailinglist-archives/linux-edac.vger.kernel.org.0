Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E8103C42
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2019 14:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfKTNmM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Nov 2019 08:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbfKTNmL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:11 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62EC22528;
        Wed, 20 Nov 2019 13:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257330;
        bh=mooLrNBe0qs/QqUCB7pF5WqTj37mt8k/Vno37Qxu/9g=;
        h=From:To:Cc:Subject:Date:From;
        b=lWzaKeXPu/9KDWU/poYZSqCvflmNzOHqnxcKGZJTcDAZUFWGsBKxSGXdJYT//mdiM
         15T6faUWXEMUq1EiIQnjG3H+1bdlXp9ZiUxYblvFH+2LwdFVcCKJW/uBFhjelGefBU
         0qpVsJBTRpzSyBKP3D/bVuWkl4Chx+Gxt7cP0n/4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH] edac: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:06 +0800
Message-Id: <20191120134206.15588-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 417dad635526..c49f6bc39716 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -492,7 +492,7 @@ config EDAC_TI
 	depends on ARCH_KEYSTONE || SOC_DRA7XX
 	help
 	  Support for error detection and correction on the
-          TI SoCs.
+	  TI SoCs.
 
 config EDAC_QCOM
 	tristate "QCOM EDAC Controller"
-- 
2.17.1

