Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED46B2296
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbfIMOui (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 10:50:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbfIMOuh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 Sep 2019 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FGpf56cINC9+BFVgh8DBy4ECBvi8JOhFNHTcv1IE2rc=; b=PeIwWbLeagxov6jGgE1NwNTvP2
        cSb+20Zl6/j3VQYGueMYU5UeG/Upe62YVbX1ddhSKvsBMLmsyp9PwLSvcpoCR2E7hKghoTgUDOdNv
        I5Xr2vdIzipHsrY21PQXJUUeoRMaFSUfQi8Ca/JmI/PsaCQWG2RkkzS53+SN22RoLeibWEFHeEzXz
        KtTPVrB2xMb70ileVk9Z9jOfg3eMPB2Ub0mbxAs+bZJf+d2kZceuWAd84bS7izUsosaerYeo+nWmz
        GqcWd+/ROJerZJTStIaslz96V9X0Do7Z9n89tMWCKVM7Oe6+4apc4dOe6o4JieZuc0gwxjcqL7d+k
        6KvLPfqA==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8muC-0002Mw-N1; Fri, 13 Sep 2019 14:50:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i8mu9-00042u-FD; Fri, 13 Sep 2019 11:50:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 2/7] EDAC: i7300_edac: rename a kernel-doc var description
Date:   Fri, 13 Sep 2019 11:50:27 -0300
Message-Id: <cf9558a77b144f1a2b5c9fb0387892584d3dce5d.1568385816.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568385816.git.mchehab+samsung@kernel.org>
References: <cover.1568385816.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

One var was renamed, but the associated kernel-doc markup still
points to the old name.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/i7300_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index 7bf910d54d11..3d4bd3bf317c 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -580,7 +580,7 @@ static void i7300_enable_error_reporting(struct mem_ctl_info *mci)
  * @ch: Channel number within the branch (0 or 1)
  * @branch: Branch number (0 or 1)
  * @dinfo: Pointer to DIMM info where dimm size is stored
- * @p_csrow: Pointer to the struct csrow_info that corresponds to that element
+ * @dimm: Pointer to the struct dimm_info that corresponds to that element
  */
 static int decode_mtr(struct i7300_pvt *pvt,
 		      int slot, int ch, int branch,
-- 
2.21.0

