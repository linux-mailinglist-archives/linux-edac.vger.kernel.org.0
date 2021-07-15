Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2846E3CA02D
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jul 2021 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbhGOOBV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jul 2021 10:01:21 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44394
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhGOOBU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 15 Jul 2021 10:01:20 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 69DFA408AD;
        Thu, 15 Jul 2021 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626357506;
        bh=Cl2Z4fkPQ4YWZ9DFZjI76elK6rvIDL5Xxs/GYAwsJ5c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=c+f5DW3fRovP4PppXJ+3G7D63Ukw1ThI+F0iU3Tf10NiIJsAdYH3khUy3HBmzF+Qh
         YfTyiwyAqg8CCEd9IL19IrC4QnQ2/ruTR/SvbupN5zCiThC+wBPHbIgXlul6aSjh28
         1Y8u9chciqu2vZZWEAUdKFaL0qAXqyh0olA/bf2GzFqe5JCP2MJkXivuE6WdAd1+cM
         KnUnkJGJSRpNgZ06BcDpY3rqVcCn4uGPkThKZwnOZH9c7HTIcJOtawCL/n6u/yQkIc
         MaTyYGmCmtJ90q8oe2bRGefJRebg6ntmfkTYsGhvWtwxRpAowKNSCAW/vDVTT7IVbA
         OmsbL2Aahppfg==
From:   Colin King <colin.king@canonical.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Doug Thompson <dougthompson@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-edac@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/edac: add missing macro arguments and missing macro edac_pci_remove_sysfs
Date:   Thu, 15 Jul 2021 14:58:26 +0100
Message-Id: <20210715135826.26241-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The macros edac_pci_handle_pe and edac_pci_handle_npe are missing their
arguments and don't match the function prototypes they replace. Also
macro edac_pci_remove_sysfs is missing. Fix this by adding in the missing
arguments and missing macro.

Fixes: d4c1465b7de9 ("drivers/edac: fix edac_pci sysfs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/edac/edac_module.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index aa1f91688eb8..ed194ba2c207 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -123,8 +123,9 @@ extern void edac_pci_handle_npe(struct edac_pci_ctl_info *pci,
 #define edac_sysfs_pci_teardown()
 #define edac_pci_get_check_errors()
 #define edac_pci_get_poll_msec()
-#define edac_pci_handle_pe()
-#define edac_pci_handle_npe()
+#define edac_pci_remove_sysfs(pci)
+#define edac_pci_handle_pe(pci, msg)
+#define edac_pci_handle_npe(pci, msg)
 #endif				/* CONFIG_PCI */
 
 #endif				/* __EDAC_MODULE_H__ */
-- 
2.31.1

