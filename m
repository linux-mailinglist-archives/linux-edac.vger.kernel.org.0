Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60654464541
	for <lists+linux-edac@lfdr.de>; Wed,  1 Dec 2021 04:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346395AbhLADMi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 Nov 2021 22:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346357AbhLADMh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 30 Nov 2021 22:12:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD801C061574;
        Tue, 30 Nov 2021 19:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8Y/Yf1DFpXZ40Q8rAYKo+hnEhIQdPQLV0bx1iRLRFLc=; b=F0LCgZGB1f7DpUjH25+8gVSMmU
        Hf2KWDLiLXV1tL9G0mL/dpsYnOOqwpB6qMM14uxqFNekVI/FLjXxYqAXUP5eAGDdeUES/p7G6+btR
        z1gO/FAF0Fuv6W4DVQ9zocr9tDndDfRrF7GaVpp7FkXoRRYFTszYgtp1WPtKNQD9eMbfDefDebg+/
        rOdQuaEGMmBYM4MtZYvUl+f0pU205LluHLvriwvb3gG3ymW8Z51/zYQzwL2dGYEeIulT2A09y38OA
        lSZqhiBRUMk/u2kPbdnTR/xl2IaS8tFfT8p96+M5xjRf0MEZkwUrUfoCMMJsJbpSkjVASjj8w4r4c
        H8M1ln0g==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msFzg-007MLx-K5; Wed, 01 Dec 2021 03:09:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] EDAC/sifive: fix non-kernel-doc comment
Date:   Tue, 30 Nov 2021 19:09:13 -0800
Message-Id: <20211201030913.10283-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

scripts/kernel-doc complains about a comment that begins with "/**"
but is not in kernel-doc format, so correct it.

Prevents this warning:

drivers/edac/sifive_edac.c:23: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * EDAC error callback

Fixes: 91abaeaaff35 ("EDAC/sifive: Add EDAC platform driver for SiFive SoCs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Yash Shah <yash.shah@sifive.com>
Cc: linux-edac@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/sifive_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211130.orig/drivers/edac/sifive_edac.c
+++ linux-next-20211130/drivers/edac/sifive_edac.c
@@ -19,7 +19,7 @@ struct sifive_edac_priv {
 	struct edac_device_ctl_info *dci;
 };
 
-/**
+/*
  * EDAC error callback
  *
  * @event: non-zero if unrecoverable.
