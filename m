Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B767845F6CF
	for <lists+linux-edac@lfdr.de>; Fri, 26 Nov 2021 23:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhKZWYE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Nov 2021 17:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhKZWWE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Nov 2021 17:22:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6B5C061574;
        Fri, 26 Nov 2021 14:18:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o13so21384219wrs.12;
        Fri, 26 Nov 2021 14:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8YPOf/hryHXLNf5LZMrhfLPR/t5FxaDsdYpZZbn9qeA=;
        b=SAOmx1u+b9+/SH8EqbHf0gb/dxmO2bkyeCAIwQBrMKZ7EvZvpx3ScaGlZxHm8jT95Z
         swm58WRmEwpOkEjxMVi+lqc5bX0TzP7BaGyGByM7VGLfbEkM7dpkEInJcnCKM/uCUf5L
         RE+2FkoY0n1sNWSVnlLqXdldFP5/9OxFlijQaXSi6aKzJWard7iMkkBu+IraRbvMqdV8
         fAHj/Fo4wmoZ2xYx8FPu+KyhgS0WtlpndS4Bp/1y+st3QRx2eNtF/bMlPD+PIHUejNJT
         fEMuhHvXmfOHQfIB9teoiqOu6l1X3r17Y4aIiIEib6f1CWt1Fl0f8hyKcm74QKYyLfMj
         tsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8YPOf/hryHXLNf5LZMrhfLPR/t5FxaDsdYpZZbn9qeA=;
        b=eW0H2SH5MP4jGvhXVza4QwVbw70uq/lSuDMwFDTqa+IILIto4+tYFPHhlNrHzj6en8
         q9RJVir+zl2hR+igJ9IACSVyRfQlJ89LPY3B6/P5SJL6UneVc7UIs0paVywChSc6hUGm
         88bXn2d8lRhCNdWni8ZMyEv+BOppMYzUSWMycouA29G5MwxcrFKYz48FOSJ24u/tcX6q
         kY0vaqpts8hW5/ypNZNH7Jnbi+Tr59KCH8sj712UKV+RvpWMm8SsNTR9AiFVx0IJNCs8
         F4UimJFOSwvqSoCvRdP+/f+XUyjnnwvtS2dfaFtODhsRgBQNQwm7aUKIEXhjQ5azIIqp
         L+IA==
X-Gm-Message-State: AOAM5324upOW+xtueqIqWbDKNOYYQz/FICvzulijoAMYua41NakPIhVy
        LFrQVmPRrmq4sQ==
X-Google-Smtp-Source: ABdhPJzpv1hu+dk1JBApzyvzlN/nfu36ibqkZGgaQtsO4EvvZHjLPhpWgb7j1GDiHcPgqf2FxMTJGg==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr16899891wrj.589.1637965129359;
        Fri, 26 Nov 2021 14:18:49 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j40sm8547915wms.16.2021.11.26.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:18:49 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/sb_edac: Remove redundant initialization of variable rc
Date:   Fri, 26 Nov 2021 22:18:48 +0000
Message-Id: <20211126221848.1125321-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The variable rc is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/edac/sb_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 1522d4aa2ca6..9678ab97c7ac 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3439,7 +3439,7 @@ MODULE_DEVICE_TABLE(x86cpu, sbridge_cpuids);
 
 static int sbridge_probe(const struct x86_cpu_id *id)
 {
-	int rc = -ENODEV;
+	int rc;
 	u8 mc, num_mc = 0;
 	struct sbridge_dev *sbridge_dev;
 	struct pci_id_table *ptable = (struct pci_id_table *)id->driver_data;
-- 
2.33.1

