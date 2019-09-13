Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E65B2293
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbfIMOuh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 10:50:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388998AbfIMOuh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 Sep 2019 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L2WuVgEWJ1S/DCcbljfrkSPlJ+BBqepA9EJiiwR270o=; b=YRmqjDAz7qLZqG5DjnEH4tIdzC
        rQVoG/5shJSaY19hAestUS175lC/MF+EkaOPxnav1pO6w7jUwBEm6wa0Zj86HN+Ge5GQ7E7I9YHrt
        yy1iSKs6kKvTkzziNfevgUU5sTDvngfoLcK5A7itgiT1tyK9z7Xdu05k8Nnwl7vrvj3EO8Hfk64Nq
        lw4jgFH2iwf5HxTVjbN1Y4mUI9VtOfCWUljd3dobLadwAKygbLz4DaoyAC3NDcIlwnYfE0HcZjfAF
        5hxJqw6JYjt1hpzALS4IC7gYRREm9uvggerN6gOqq7FhNiZbMHFZaVZS0l0Pi5cEupJufBoDaaXZh
        LeGJAT8A==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8muB-0002Mn-Qm; Fri, 13 Sep 2019 14:50:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i8mu9-00043F-JG; Fri, 13 Sep 2019 11:50:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 7/7] EDAC: skx_common: get rid of unused type var
Date:   Fri, 13 Sep 2019 11:50:32 -0300
Message-Id: <3bbd66908f60d43c2f60c8a16570994cce21a853.1568385816.git.mchehab+samsung@kernel.org>
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

	drivers/edac/skx_common.c: In function ‘skx_mce_output_error’:
	drivers/edac/skx_common.c:478:8: warning: variable ‘type’ set but not used [-Wunused-but-set-variable]
	  478 |  char *type, *optype;
	      |        ^~~~

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/skx_common.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index d8ff63d91b86..83dd5da67a28 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -475,7 +475,7 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 				 struct decoded_addr *res)
 {
 	enum hw_event_mc_err_type tp_event;
-	char *type, *optype;
+	char *optype;
 	bool ripv = GET_BITFIELD(m->mcgstatus, 0, 0);
 	bool overflow = GET_BITFIELD(m->status, 62, 62);
 	bool uncorrected_error = GET_BITFIELD(m->status, 61, 61);
@@ -490,14 +490,11 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 	if (uncorrected_error) {
 		core_err_cnt = 1;
 		if (ripv) {
-			type = "FATAL";
 			tp_event = HW_EVENT_ERR_FATAL;
 		} else {
-			type = "NON_FATAL";
 			tp_event = HW_EVENT_ERR_UNCORRECTED;
 		}
 	} else {
-		type = "CORRECTED";
 		tp_event = HW_EVENT_ERR_CORRECTED;
 	}
 
-- 
2.21.0

