Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F71FD6C7
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jun 2020 23:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgFQVMQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jun 2020 17:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgFQVMP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 17 Jun 2020 17:12:15 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F3F32168B;
        Wed, 17 Jun 2020 21:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592428334;
        bh=ANf1viXNC0XSKoSbuh6tqRPGoE7n8+2mW4foAbx4gFA=;
        h=Date:From:To:Cc:Subject:From;
        b=d9CIbwABuXthBo2IWu9UjCBvO9Vr3G7pb/PAJQ04UUt22K+WFzXtiE8ArWK2A8S7C
         agK8P1Jg2kANEKx3ek+T7JMztHCU/L10yFGt9eQ7vji9wpu68OM5UO7K5fCIOnAxYM
         qGRehsVrw5g/F3zYwEh4WqcYPfLUrxLCJNh9dGcc=
Date:   Wed, 17 Jun 2020 16:17:34 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] x86/mce/dev-mcelog: Use struct_size() helper in
 kzalloc()
Message-ID: <20200617211734.GA9636@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 43c466020ed5..03e51053592a 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -345,7 +345,7 @@ static __init int dev_mcelog_init_device(void)
 	int err;
 
 	mce_log_len = max(MCE_LOG_MIN_LEN, num_online_cpus());
-	mcelog = kzalloc(sizeof(*mcelog) + mce_log_len * sizeof(struct mce), GFP_KERNEL);
+	mcelog = kzalloc(struct_size(mcelog, entry, mce_log_len), GFP_KERNEL);
 	if (!mcelog)
 		return -ENOMEM;
 
-- 
2.27.0

