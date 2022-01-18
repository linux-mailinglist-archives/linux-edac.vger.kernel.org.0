Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994C3491A48
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jan 2022 03:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbiARC7F (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jan 2022 21:59:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38394 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348696AbiARCpv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Jan 2022 21:45:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C8F9612E8;
        Tue, 18 Jan 2022 02:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F7DC36AF4;
        Tue, 18 Jan 2022 02:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642473950;
        bh=O1SAMCcuK67rzVRkR2DErJDeGgGNw2d29WnTxSsn70k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vq8G5z03+Pezlt8fE/gnswwwx11j04x25KTlDzOgZ6bhvaxw5DzeIfQ7X6bow1++o
         380ks4ZbYh8jSZeK8hxJxCEqIoeHbxYP92Jzcy/wWXWbMzrBF9WbZfMN1QhYLPEMhb
         VJMc7qwrn17j5kCPuSqlt57/2hmXThkeFU7wfP3lTQsngFyeaYwVu3UfUHrX9LABxq
         ytr9it1Ba+Bsr0scjkZKgKqO/Am+ljjn5FxPz7t+mTlMibpOcOzTmcA6QspWxrnaum
         VyuueX5qaA13cNiXXDqK9gKdhjlE9G4o7icVmLeLUb4V+bheZeRzt+T7Ah09zaOoyD
         Bg85XaofieU3w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 36/73] x86/mce: Mark mce_read_aux() noinstr
Date:   Mon, 17 Jan 2022 21:43:55 -0500
Message-Id: <20220118024432.1952028-36-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024432.1952028-1-sashal@kernel.org>
References: <20220118024432.1952028-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

[ Upstream commit db6c996d6ce45dfb44891f0824a65ecec216f47a ]

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x681: call to mce_read_aux() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-10-bp@alien8.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a0f6c574c3783..8a2b8e7913149 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -700,7 +700,7 @@ static struct notifier_block mce_default_nb = {
 /*
  * Read ADDR and MISC registers.
  */
-static void mce_read_aux(struct mce *m, int i)
+static noinstr void mce_read_aux(struct mce *m, int i)
 {
 	if (m->status & MCI_STATUS_MISCV)
 		m->misc = mce_rdmsrl(msr_ops.misc(i));
-- 
2.34.1

