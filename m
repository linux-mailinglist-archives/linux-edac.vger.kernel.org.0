Return-Path: <linux-edac+bounces-4356-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA14B040DF
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162D0161B6E
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2E24BD02;
	Mon, 14 Jul 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSTwvTUW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7678248866;
	Mon, 14 Jul 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501715; cv=none; b=BMGCUOYX5RtADe5zY+J68Y38aMjx/+VQhctmISx4aTp7h6gabk44N1lSt3wdoQiahYabGNyeGJJSbi3F8bJ8v/Ig7E6tJwJX9zDauUkgIkaoUw/HSMENzcA2FaGMqwVqNb3ieqwGgJbkz8FlM/H0/UIFjfEUoVdM2Fv3nTLUVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501715; c=relaxed/simple;
	bh=+W+Iab+QeCoIVVC0odHtguOXjB1oJzVEw1Ij/e51zSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZUvVMNlEfyfPPP2P19MNgvpxTgi4X64dTCuJ+ipnLoY1V5CiwCtFOytxBhUwsA4nsJex82nsqnHr6+OO2FPxlvgaozCChe4sIII/KEtCT3whL77HaWbntA02KKBye4U6TBSOJZCRIGyU/PasLkGjUP2yyKc4W7/rC+gcPSLVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSTwvTUW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2349f096605so54715045ad.3;
        Mon, 14 Jul 2025 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752501712; x=1753106512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2itJZiCiKIHVHDCXuPLo5rtiNq4JGHFwDWSwFrRHTbY=;
        b=MSTwvTUWju5OPNQZkIdvisG1K7TJJJ8P3e5H4FAzrQKA2A5najOhSmrS1jhwPZKTOT
         +S64NKW2GI811aNFAwCQBdjQJ1dfOojQnBnIb+JnRS30yiUEDqTdabbZBMzZxGIcNhBW
         u+UOx4ygQHdcFQbTziH+u+GiK/a+60h1Mwoxg4NBgqTDUMhrB3O4nw1z8N+En7Vlfdep
         dibY7ARACp/i/+Czqf3l0gNUqdA4WIQ7p4BU3Vn6ioJ0HG8mwv5r7n8iCxhB1fsORAii
         ydrs7NFcecZGcBXTPqqA/Wy3+SPYlXNjzOCUAiuNRAAU9Rx1fsnxVC3cuw9NgysqdwIX
         h1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501712; x=1753106512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2itJZiCiKIHVHDCXuPLo5rtiNq4JGHFwDWSwFrRHTbY=;
        b=oAc0ZM9Nq1cqcqx5+EDyubMd8v0cJpr1NPidIATd0YqYoJ3rDiErD1xFPElB6c3rmK
         9+ux/1w8oEawbdsGqAz7rHoC1gHrf8mJ2qwNiAaPN7ichNW0fcxfuxzqFgVI/H1XIj0L
         6nXzImRtd6GEKobEHyuBWuIouORBBjABzT6oS+NjZVfNQLDFIGSr9D6VwzACSTbJKAs8
         W5+KCdvkBLtOb0SQ95fJe5QbNbJVwHfOFR3nS/paUq8kgcpf1g7TlOm1SbX1VPs9clP1
         D+/DWp8HWC+429DHf0Ob1nVkFq2o1UPL03WVfa0xFdU2DwU3jvUb7d46OCFUHNVjZQmY
         j7OA==
X-Forwarded-Encrypted: i=1; AJvYcCUpY9+ie5HZsM2PireJgLxgdnBj6yMcqCx3Xim864WChh8kiMZxptu/gLTExMnuTxwvCB3Q2sFlYQg92wz8@vger.kernel.org, AJvYcCWeSCPl45JivCWqYCTYLFab47DTBQ4RFSsgO91KDBu4ungdAu2Xfv9JXrtlrF7YNyegAmWFE9/jM0Zl@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJop7KINsk4Ze69eryDqAWLfuqmcV7couWwrfAuk8XpnvlSxL
	i3bYP/MfsB9QEQYiGNIJmhy8PtmG+J+K8HGg46gV0a+yqL2b7Ay3M/1hQfVxtwUgM2w=
X-Gm-Gg: ASbGncsUanSbCdAo1tXutHbbgjZj21UPZ4FL6M6dJguOewXdOH/eb4x4Jx7jDoAn34m
	n+TadbLtMN0yMm0Ecq55Mk8ThTl/adthWhLHu4UAKKBnTz5Ro+87YgcdDSsWZNKzc/rBqn+oDfL
	bMpsUTIbs1LIFBqCmRr2hXE1/edsYfRkL2iBlufAvDSnZdZW3Cu3sZHTLln4vD499FVgKOkzBi3
	L+64sEeakvGrdKk8CaQHGCNAUfYfIVxH1ml/67qB2PRkIKkFd8VPOKbJY+BoxD6YjfA71x3Ji2Z
	U0A+HQR354kbBVcMt93ZBQSOlZGMyU1e4P6B65S0k9xSXCER050k/6FIJ3GovYjaGnfuKwtPj53
	uhrVQJhkPMo0cQ/ERPJfXXQ8L
X-Google-Smtp-Source: AGHT+IFxlY/tbQWQdHO9CkQoCYihwVfQoIVbQ3lwjQbXpoDtKex1Gum8g9YRWi0x4l/ARiQeWskYuA==
X-Received: by 2002:a17:902:ea08:b0:224:23be:c569 with SMTP id d9443c01a7336-23dee18be42mr228116755ad.22.1752501710570;
        Mon, 14 Jul 2025 07:01:50 -0700 (PDT)
Received: from shamiko.dns.podman ([2a09:bac5:398e:16c8::245:d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4365b02sm91875585ad.245.2025.07.14.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:01:49 -0700 (PDT)
From: Wang Haoran <haoranwangsec@gmail.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>
Subject: [PATCH] edac: Use scnprintf() for safer buffer handling
Date: Mon, 14 Jul 2025 22:01:30 +0800
Message-ID: <20250714140130.1092079-1-haoranwangsec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf() is fragile when its return value will be used to append additional data to a buffer. Use scnprintf() instead.

Signed-off-by: Wang Haoran (Vul337) <haoranwangsec@gmail.com>
---
 drivers/edac/i10nm_base.c | 18 +++++++++---------
 drivers/edac/skx_common.c |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index a3fca2567752..679d34c097c0 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -343,7 +343,7 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 
 	status_mask = rrl->over_mask | rrl->uc_mask | rrl->v_mask;
 
-	n = snprintf(msg, len, " retry_rd_err_log[");
+	n = scnprintf(msg, len, " retry_rd_err_log[");
 	for (i = 0; i < rrl->set_num; i++) {
 		scrub = (rrl->modes[i] == FRE_SCRUB || rrl->modes[i] == LRE_SCRUB);
 		if (scrub_err != scrub)
@@ -355,9 +355,9 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 			log = read_imc_reg(imc, ch, offset, width);
 
 			if (width == 4)
-				n += snprintf(msg + n, len - n, "%.8llx ", log);
+				n += scnprintf(msg + n, len - n, "%.8llx ", log);
 			else
-				n += snprintf(msg + n, len - n, "%.16llx ", log);
+				n += scnprintf(msg + n, len - n, "%.16llx ", log);
 
 			/* Clear RRL status if RRL in Linux control mode. */
 			if (retry_rd_err_log == 2 && !j && (log & status_mask))
@@ -367,10 +367,10 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 
 	/* Move back one space. */
 	n--;
-	n += snprintf(msg + n, len - n, "]");
+	n += scnprintf(msg + n, len - n, "]");
 
 	if (len - n > 0) {
-		n += snprintf(msg + n, len - n, " correrrcnt[");
+		n += scnprintf(msg + n, len - n, " correrrcnt[");
 		for (i = 0; i < rrl->cecnt_num && len - n > 0; i++) {
 			offset = rrl->cecnt_offsets[i];
 			width = rrl->cecnt_widths[i];
@@ -378,20 +378,20 @@ static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
 
 			/* CPUs {ICX,SPR} encode two counters per 4-byte CORRERRCNT register. */
 			if (res_cfg->type <= SPR) {
-				n += snprintf(msg + n, len - n, "%.4llx %.4llx ",
+				n += scnprintf(msg + n, len - n, "%.4llx %.4llx ",
 					      corr & 0xffff, corr >> 16);
 			} else {
 			/* CPUs {GNR} encode one counter per CORRERRCNT register. */
 				if (width == 4)
-					n += snprintf(msg + n, len - n, "%.8llx ", corr);
+					n += scnprintf(msg + n, len - n, "%.8llx ", corr);
 				else
-					n += snprintf(msg + n, len - n, "%.16llx ", corr);
+					n += scnprintf(msg + n, len - n, "%.16llx ", corr);
 			}
 		}
 
 		/* Move back one space. */
 		n--;
-		n += snprintf(msg + n, len - n, "]");
+		n += scnprintf(msg + n, len - n, "]");
 	}
 }
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index c9ade45c1a99..39c733dbc5b9 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -670,12 +670,12 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 	}
 
 	if (res->decoded_by_adxl) {
-		len = snprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
+		len = scnprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
 			 overflow ? " OVERFLOW" : "",
 			 (uncorrected_error && recoverable) ? " recoverable" : "",
 			 mscod, errcode, adxl_msg);
 	} else {
-		len = snprintf(skx_msg, MSG_SIZE,
+		len = scnprintf(skx_msg, MSG_SIZE,
 			 "%s%s err_code:0x%04x:0x%04x ProcessorSocketId:0x%x MemoryControllerId:0x%x PhysicalRankId:0x%x Row:0x%x Column:0x%x Bank:0x%x BankGroup:0x%x",
 			 overflow ? " OVERFLOW" : "",
 			 (uncorrected_error && recoverable) ? " recoverable" : "",
-- 
2.43.0


