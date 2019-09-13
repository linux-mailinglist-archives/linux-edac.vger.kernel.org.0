Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1FE7B2294
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbfIMOuh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 10:50:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388704AbfIMOuh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 Sep 2019 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ox3AyXAcafO8D8+TJ5Imd59NC6Ph1eV4BYAGmGgunRw=; b=hZcZqtzT1E1Zs0aj6lxiFEvual
        ol6D80z+z0yxwkk5IW5d+4kuoYrvAqHIc0LHpFb0TzNodsxUowRFqkpOAI2/gMDcBhVjKmyHaplGK
        amK+ftuShg19jnuB91uvr7Emo27R8LzKzQ5t7aa0D+1XKRqFcaD70YnWc7G///AbnQSSUoLM5XsZX
        WHQBqiwFUr3HESD4kEz/6BwhBoJDfifTMiDzJeIIPhGpqv14dcMHA4oZDG2K3Wgs1TFdN3P9+gsm5
        fYlcrRNDS42o0ZKWXYpIHxaK3KXTc+h3kuKtBbkQcz1onzaeil5e27Jk9SMUAJoKdFMZN40CSb5Fl
        0EG3Vw9A==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8muB-0002Mo-V2; Fri, 13 Sep 2019 14:50:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i8mu9-00042y-G0; Fri, 13 Sep 2019 11:50:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 3/7] EDAC: i7300_edac: fix a kernel-doc syntax
Date:   Fri, 13 Sep 2019 11:50:28 -0300
Message-Id: <659775074c522b030a0178e7662079662ee7ee95.1568385816.git.mchehab+samsung@kernel.org>
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

The declaration of the kerneldoc entry is wrong, causing this
warning:

	drivers/edac/i7300_edac.c:824: warning: Function parameter or member 'mir_no' not described in 'decode_mir'

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/i7300_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index 3d4bd3bf317c..447d357c7a67 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -817,7 +817,7 @@ static int i7300_init_csrows(struct mem_ctl_info *mci)
 
 /**
  * decode_mir() - Decodes Memory Interleave Register (MIR) info
- * @int mir_no: number of the MIR register to decode
+ * @mir_no: number of the MIR register to decode
  * @mir: array with the MIR data cached on the driver
  */
 static void decode_mir(int mir_no, u16 mir[MAX_MIR])
-- 
2.21.0

