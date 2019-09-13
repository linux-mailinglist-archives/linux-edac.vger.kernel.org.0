Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFAB228B
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbfIMOuh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 10:50:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388993AbfIMOuh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 Sep 2019 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Elp+uTImoCrNP71fv1uYeYHL/XQdxRr3L3U43a7bv/k=; b=qWoED4FLjqaj+cGPvaKEj26/3J
        iKnUjDpu4cPWq4d8LZoBCFQoZ2U/5GL5SRXI34Bfq82etwIHZzOuWP2rY95eusxmYm3Co+/p68mf5
        Vx7VFzMGKj/xl+3FYTHx7R0gNvAQfYtTWHR8TwZRjbwyLsyS0ncIwJvQeS3Rgme6K3cRz2mdc2OAM
        +qthSj31SWg9MvJDzLuz5EsWr/LrX/azFdrEDMZ2QwCoX2y6IXSJhXgaXsII/MSV7zOm4cDqv1j5/
        1nQZFSiGbgNOKoM6PLKsGI+H0m/JwM+ZYyN0W6jxyUd1j6T9nKJxx6VDGYtaqqbja09Nn9H2xsvJH
        DGC4QLxQ==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8muC-0002Mv-Mr; Fri, 13 Sep 2019 14:50:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i8mu9-00042q-ES; Fri, 13 Sep 2019 11:50:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 1/7] EDAC: i5100_edac: get rid of an unused var
Date:   Fri, 13 Sep 2019 11:50:26 -0300
Message-Id: <0f79a3d3684dc6484e48cfce66ff2b560a1054c8.1568385816.git.mchehab+samsung@kernel.org>
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

As reported by GCC with W=1:

	drivers/edac/i5100_edac.c:714:16: warning: variable ‘et’ set but not used [-Wunused-but-set-variable]
	  714 |  unsigned long et;
	      |                ^~

It sounds some left over from some code before the addition of
an udelay().

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/i5100_edac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index 251f2b692785..12bebecb203b 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -713,7 +713,6 @@ static int i5100_read_spd_byte(const struct mem_ctl_info *mci,
 {
 	struct i5100_priv *priv = mci->pvt_info;
 	u16 w;
-	unsigned long et;
 
 	pci_read_config_word(priv->mc, I5100_SPDDATA, &w);
 	if (i5100_spddata_busy(w))
@@ -724,7 +723,6 @@ static int i5100_read_spd_byte(const struct mem_ctl_info *mci,
 						   0, 0));
 
 	/* wait up to 100ms */
-	et = jiffies + HZ / 10;
 	udelay(100);
 	while (1) {
 		pci_read_config_word(priv->mc, I5100_SPDDATA, &w);
-- 
2.21.0

