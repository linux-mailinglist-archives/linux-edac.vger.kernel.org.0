Return-Path: <linux-edac+bounces-4276-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D373DAEBE91
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jun 2025 19:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D1F4A4BE4
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jun 2025 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C14C2EA148;
	Fri, 27 Jun 2025 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0a6r9of"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67A1F09A5;
	Fri, 27 Jun 2025 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046584; cv=none; b=SPRqXalHlwDsEEquzsAH0oNEKzGhsLncXBxHLrLMrrrvcFJx0ZISQdgEp5Xczzv4SVcQtKHj5b4Mp30JRh7Lrj9aqV5uKJZdYAuSnDFtQVot58Li9Z+hm2Ze+Sq6xajWCZ7c2P9qmcCwnZqC1QnzWlr/oJQnvcR+NGJv7hCitu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046584; c=relaxed/simple;
	bh=3ErIgRlfbf0U1gwA6wQ8w3TtIiNWijhEOxcs6ejoPnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IR3Zsy0XQgxkIUkEM0IRq9Djb6cZDXCnihv6jlzTtn7cXfIxlmdbBJuiC2GHhjY08hHVFO6WVmkPigfSK4ikX6Jvecbs2sG0lqEGp2/qIjO84pLGyHzl/CNqZjKv0zlO/p/mSzZeYjIywPnfkED2o5ey9CrUq35pTLmaCCPOZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0a6r9of; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1973452b3a.1;
        Fri, 27 Jun 2025 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751046582; x=1751651382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf/mQBAVXHaioZjerZGUfPR5HpKRHhYxWynkJWTASXg=;
        b=F0a6r9offhDeT84T1Oz5gtdFxZ5NoC+hI30i869LlUCIi9UNv02OmkMN+D7Ew/0zy/
         eY84J/7cHUWNpnLu4Vcr1BbgdaHANJ5rq7Ah5cVog++mC/rzNNgNUhpCnZsj33+/5dWC
         OHcp8hloVUDqJg2jCttlGIpu9FCsQrPAn54UsJGpj7a8bieUysU9+/uAbwVT9Wp4dmDy
         2CU7ishEM1eEnqYv9RIVQD3HxNJlFTWHravgSxBJ9ZdLOA9iKIbHuGS5sSAdBGCjQow7
         XuLvLogthxe4keZw7WSLmxIh6NaP//l7VTxU3TBauTbdjhaWott0vHSKbKdeybf4Cj9s
         TuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046582; x=1751651382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wf/mQBAVXHaioZjerZGUfPR5HpKRHhYxWynkJWTASXg=;
        b=dLxW20KWDLPnxsvhPy67KoG4/OGDF9xhCGS+F9jwtIqehbpTLoR/bp05ckSCJ7D7Yf
         Kq6DYIG52WcUCQEkn4saj+nMiN2Z7/2iO/LOtP8oMzsmjSckck37K/KkpF1BcnXURcyM
         hW31l8FldtQy+DQOgflhYBFZCdoPWTjto5Ngearo8pwruyu362FYyq+1f53A9p12geK4
         SkTaZ+78RJd+ZkxG+4wZMjYS42blKfg8Qm+4Pjh5iS+GQJwlwPbydTOPl80uissPdIqG
         Yv+PH4f/+UGT4u3MmWx2/xcgYebFAMS0q55WIRSutWTPfMumkbH6oIFwspREcA8aJpq1
         P7IA==
X-Forwarded-Encrypted: i=1; AJvYcCV2IljDuTiqoyUkOB0wfrJaEg+kmZ2kbZehZlozUZrms4oB8V+TmlBVPEfzJP1bI1L2mj0Tyk+leOpLevw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPD+HxPg+xQxS86Ovvd/MxsI3V4+uvvuChsKB/MZl/QF2PMU0
	hVGH9ERrjBIavfhyx40b119hMEotJyYuTpwJd9Shl7KXqLPh5SovbRrn
X-Gm-Gg: ASbGncvhJUjgu6AWyeWGWq9EG2F9Z+9rWXOhVSAPmNNT1Cr1tbhoTEXxmhtOmGM+ZE8
	wEv0urRZByctS22vmvK4Dy69mRXBm/xJnxLMUa1NqcRw7Rs+7qA5NkxkRAAFmdSnAbFmwPYyY31
	mgiluycVoESkh/mRB4zl5n3mGLOK13PTdFkwhdC54gBi+t9Tb7CSvWdeMtAUN+d3q9hrqTsJMvG
	sC1QQi1eba3ee91ESO8evvxijiTspn6kwLlA2uL/kxDLYm3GJIbf3F7N1CriKzEb4pyKd4ejEPY
	Vp3vcC1qvvSH413Z7liF5JKE5KpWQ6y5URGJfrPM0ASybJ05zBEqJZsuY4a7R/mnIO+83gx4Awz
	W3Av7zB7hFXc5nspO2cI73NkQSimVSL9HyIkNFnHRItA5hz2h7yBiGdMInig5
X-Google-Smtp-Source: AGHT+IE5VKp0UGyBHHpNzEYVbSOSJhRVx9PwTPiAsX+Gy7MkrzawLittTtIsa2Z7xpKwX5NRAfuCeg==
X-Received: by 2002:a17:903:110d:b0:237:d734:5642 with SMTP id d9443c01a7336-23ac48a72d7mr70421905ad.41.1751046582465;
        Fri, 27 Jun 2025 10:49:42 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan (c-67-180-10-175.hsd1.ca.comcast.net. [67.180.10.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3ad16fsm22267355ad.141.2025.06.27.10.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:49:42 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tony.luck@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	aijay@meta.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH tip: x86/bugs v2] x86/mce: make sure cmci banks are cleared during shutdown on intel
Date: Fri, 27 Jun 2025 10:49:35 -0700
Message-ID: <20250627174935.95194-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CMCI banks are not cleared during shutdown on intel CPU's. As a side effect
when a kexec is performed, CPU's coming back online are unable to
rediscover/claim these occupied banks which breaks MCE reporting.

Clear the CPU ownership during shutdown via cmci_clear() so the banks can
be reclaimed and MCE reporting will become functional once more.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Reported-by: Aijay Adams <aijay@meta.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index efcf21e9552e..9b149b9c4109 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -478,6 +478,7 @@ void mce_intel_feature_init(struct cpuinfo_x86 *c)
 void mce_intel_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
+	cmci_clear();
 }
 
 bool intel_filter_mce(struct mce *m)
-- 
2.47.1


