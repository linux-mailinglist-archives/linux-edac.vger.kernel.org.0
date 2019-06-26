Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE756F57
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2019 19:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfFZRJf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jun 2019 13:09:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:6876 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZRJe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Jun 2019 13:09:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:09:34 -0700
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="155933377"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:09:33 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     tony.luck@intel.com
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH 1/2] EDAC, i10nm: Check ECC enabling status per channel
Date:   Wed, 26 Jun 2019 10:09:31 -0700
Message-Id: <20190626170932.6105-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The i10nm_edac only checks the ECC enabling status for the first
channel of the memory controller. If there aren't memory DIMMs
populated on the first channel, but at least one DIMM populated
on the second channel, it will wrongly report that the ECC for
the memory controller is disabled that fails to load the i10nm_edac
driver. Fix it by checking ECC enabling status per channel.

[Tony: Also report which channel has ECC disabled]

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i10nm_base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 48c6cecc9683..72cc20a90ac1 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -168,9 +168,9 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci)
 				ndimms += skx_get_nvdimm_info(dimm, imc, i, j,
 							      EDAC_MOD_STR);
 		}
-		if (ndimms && !i10nm_check_ecc(imc, 0)) {
-			i10nm_printk(KERN_ERR, "ECC is disabled on imc %d\n",
-				     imc->mc);
+		if (ndimms && !i10nm_check_ecc(imc, i)) {
+			i10nm_printk(KERN_ERR, "ECC is disabled on imc %d channel %d\n",
+				     imc->mc, i);
 			return -ENODEV;
 		}
 	}
-- 
2.20.1

