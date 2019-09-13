Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BEFB2291
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbfIMOuh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 10:50:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389009AbfIMOuh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 Sep 2019 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y8V4ISNeIYTh4emFUodtoey9/9XrUBx5fhl2V/vuW5M=; b=O2+wOBRBZoeq+bb+gZoK3LKCA3
        q2FfeYxoGnQgZEB7FdS7hHyZOxvlJ21AiXAYkUD2g/hBq7X3AHlEPfoVsEk9S+AN3ByKWJoNamGLt
        GutEXhhlV12Ketj/xzm6A/sYDV3IPYkQgfRtTH1IesIDIw8OFcX2q4iVajvLaT3GXIHPI5VhcJoiY
        rUcB0OjmV/kUC7/GW82MiWRl5yJioq7UNcezc6WMe/FWWKNgKac9NBA8bxHLaxxGYVl1AI7j0XzEX
        YCSCHuT8qrlpSgqbjpfahH7h3xxGPKQsxQbpa1p5+gVpZa2ZcOQC7AIEIv18+NQ4xyusd6hfkBF7h
        4NfaDj7g==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8muC-0002Mr-2z; Fri, 13 Sep 2019 14:50:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i8mu9-000436-HZ; Fri, 13 Sep 2019 11:50:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 5/7] EDAC: i5400_edac: get rid of some unused vars
Date:   Fri, 13 Sep 2019 11:50:30 -0300
Message-Id: <e56ba30f6f781c7b8f3bb150fdc8b7d0a273eb80.1568385816.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568385816.git.mchehab+samsung@kernel.org>
References: <cover.1568385816.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There are several temporary unused vars:

	drivers/edac/i5400_edac.c: In function ‘i5400_get_mc_regs’:
	drivers/edac/i5400_edac.c:1058:6: warning: variable ‘maxdimmperch’ set but not used [-Wunused-but-set-variable]
	 1058 |  int maxdimmperch;
	      |      ^~~~~~~~~~~~
	drivers/edac/i5400_edac.c:1057:6: warning: variable ‘maxch’ set but not used [-Wunused-but-set-variable]
	 1057 |  int maxch;
	      |      ^~~~~
	drivers/edac/i5400_edac.c: In function ‘i5400_init_dimms’:
	drivers/edac/i5400_edac.c:1174:6: warning: variable ‘max_dimms’ set but not used [-Wunused-but-set-variable]
	 1174 |  int max_dimms;
	      |      ^~~~~~~~~
	drivers/edac/i5400_edac.c:1173:14: warning: variable ‘channel_count’ set but not used [-Wunused-but-set-variable]
	 1173 |  int ndimms, channel_count;
	      |              ^~~~~~~~~~~~~

Get rid of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/i5400_edac.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index 52783b9bd0df..8c86c6fd7da7 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -1054,8 +1054,6 @@ static void i5400_get_mc_regs(struct mem_ctl_info *mci)
 	u32 actual_tolm;
 	u16 limit;
 	int slot_row;
-	int maxch;
-	int maxdimmperch;
 	int way0, way1;
 
 	pvt = mci->pvt_info;
@@ -1065,9 +1063,6 @@ static void i5400_get_mc_regs(struct mem_ctl_info *mci)
 	pci_read_config_dword(pvt->system_address, AMBASE + sizeof(u32),
 			&pvt->u.ambase_top);
 
-	maxdimmperch = pvt->maxdimmperch;
-	maxch = pvt->maxch;
-
 	edac_dbg(2, "AMBASE= 0x%lx  MAXCH= %d  MAX-DIMM-Per-CH= %d\n",
 		 (long unsigned int)pvt->ambase, pvt->maxch, pvt->maxdimmperch);
 
@@ -1170,17 +1165,13 @@ static int i5400_init_dimms(struct mem_ctl_info *mci)
 {
 	struct i5400_pvt *pvt;
 	struct dimm_info *dimm;
-	int ndimms, channel_count;
-	int max_dimms;
+	int ndimms;
 	int mtr;
 	int size_mb;
 	int  channel, slot;
 
 	pvt = mci->pvt_info;
 
-	channel_count = pvt->maxch;
-	max_dimms = pvt->maxdimmperch;
-
 	ndimms = 0;
 
 	/*
-- 
2.21.0

