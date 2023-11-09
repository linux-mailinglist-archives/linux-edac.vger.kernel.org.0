Return-Path: <linux-edac+bounces-7-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4567E738D
	for <lists+linux-edac@lfdr.de>; Thu,  9 Nov 2023 22:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49162811EE
	for <lists+linux-edac@lfdr.de>; Thu,  9 Nov 2023 21:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD71B374F8;
	Thu,  9 Nov 2023 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR8vOH2Z"
X-Original-To: linux-edac@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268A374EE
	for <linux-edac@vger.kernel.org>; Thu,  9 Nov 2023 21:22:13 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FEA4205;
	Thu,  9 Nov 2023 13:22:12 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bf20d466cdso296493b3a.1;
        Thu, 09 Nov 2023 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699564932; x=1700169732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsvShR7q5/4puO4BbnmQ13+xfWAhOYuyw8hfh0n1j6s=;
        b=cR8vOH2ZhJ9rtVbQuqfxuaX/AgsQCIhyCAwMNqwNEyLxX1VNSPdZVjRhuCZHvIvz7X
         RMFswhSkqyWAqpNLFgDgoBwnb0lHN1jRi+VfLHhNQ18tLRt8HmJrZMt2vXN8mBEGX6NC
         /W4CIJemCzW8n+u0ploN5t3S71OsupC+EU/tMMvKZOaMJAiA08dcuytcBviqlC7ADD9Q
         tkjiIdq70UvKEqWddeJrsxNcnZT6ugBOvTFRwhIz+dQq2Dv80uNw2vHgEoAX/C1DW09K
         LOLb/gnOd3JzKmFzLPdT2tls1MC/hLP2fdX1TdmyEDzwE21RxIJnjQJ5HLX23iaeLs8H
         NPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564932; x=1700169732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsvShR7q5/4puO4BbnmQ13+xfWAhOYuyw8hfh0n1j6s=;
        b=nR/8R7FZ8vOcIuzHIw6b6BzMXWjEDRDxa2ybrNh+D7RsR6k2cRp8tlAwG7wD0vekY9
         Clv3jfiY532wp5Vz3jgOiYcuhF0hEnWItydT7NUoEyTOeCsO27Nx8nRs6jKwN0xHw98J
         4+QBHZ4QkNICY28lmRykvasKGSHZsuoulWKjjQin1GGxpck/tULoXB+nYFZrPqVkqWWe
         4izZeBldLrG1xaw6UawDld9b1Ai9w/vyWlh3V2uZcP2CKoyuY0HFwJMPrF2WAZAssjwA
         joDfW7W4scVIh9yqwLSa+ltwVoby9Zx33lPXqto1OxpJTVMIztO102WLNq5YWP+n0/qf
         mCKw==
X-Gm-Message-State: AOJu0YxiyqY/lluEVUkJWjjCbn1ouazFdzEJ8tzPrUKNfEiRWjlIPKoy
	QpKdRVL6yLngLK4EOJepPu8=
X-Google-Smtp-Source: AGHT+IHvE/Tj6YL2R7oWzgCsSiWW0ZECdbesF+CSMBXb/FGlg4VeXbmCo+Mt4qdyXbf+h2M2Oz76IQ==
X-Received: by 2002:a05:6a21:3293:b0:16c:b514:a4bc with SMTP id yt19-20020a056a21329300b0016cb514a4bcmr6964603pzb.4.1699564931925;
        Thu, 09 Nov 2023 13:22:11 -0800 (PST)
Received: from abhinav.. ([2402:3a80:196c:ea3:aee5:8832:917a:55b9])
        by smtp.gmail.com with ESMTPSA id bk11-20020a17090b080b00b002807ec010e3sm249653pjb.48.2023.11.09.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:22:11 -0800 (PST)
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com,
	bp@alien8.de,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] driver : edac : Fix warning using plain integer as NULL
Date: Fri, 10 Nov 2023 02:51:57 +0530
Message-Id: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse static analysis tools generate a warning with this message
"Using plain integer as NULL pointer". In this case this warning is
being shown because we are trying to initialize  pointer to NULL using
integer value 0.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
 drivers/edac/i7core_edac.c |  2 +-
 drivers/edac/sb_edac.c     | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 23d25724bae4..08bf20c60111 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -376,7 +376,7 @@ static const struct pci_id_table pci_dev_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_nehalem),
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_lynnfield),
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_westmere),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /*
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 0c779a0326b6..a3f50a66de33 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -439,7 +439,7 @@ static const struct pci_id_descr pci_dev_descr_sbridge[] = {
 
 static const struct pci_id_table pci_dev_descr_sbridge_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_sbridge, ARRAY_SIZE(pci_dev_descr_sbridge), 1, SANDY_BRIDGE),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /* This changes depending if 1HA or 2HA:
@@ -505,7 +505,7 @@ static const struct pci_id_descr pci_dev_descr_ibridge[] = {
 
 static const struct pci_id_table pci_dev_descr_ibridge_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_ibridge, 12, 2, IVY_BRIDGE),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /* Haswell support */
@@ -576,7 +576,7 @@ static const struct pci_id_descr pci_dev_descr_haswell[] = {
 
 static const struct pci_id_table pci_dev_descr_haswell_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_haswell, 13, 2, HASWELL),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 /* Knight's Landing Support */
@@ -620,7 +620,7 @@ static const struct pci_id_descr pci_dev_descr_knl[] = {
 
 static const struct pci_id_table pci_dev_descr_knl_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_knl, ARRAY_SIZE(pci_dev_descr_knl), 1, KNIGHTS_LANDING),
-	{0,}
+	{NULL,}
 };
 
 /*
@@ -686,7 +686,7 @@ static const struct pci_id_descr pci_dev_descr_broadwell[] = {
 
 static const struct pci_id_table pci_dev_descr_broadwell_table[] = {
 	PCI_ID_TABLE_ENTRY(pci_dev_descr_broadwell, 10, 2, BROADWELL),
-	{0,}			/* 0 terminated list. */
+	{NULL,}			/* 0 terminated list. */
 };
 
 
-- 
2.39.2


