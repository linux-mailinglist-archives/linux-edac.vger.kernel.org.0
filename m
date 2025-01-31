Return-Path: <linux-edac+bounces-2962-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659BEA24428
	for <lists+linux-edac@lfdr.de>; Fri, 31 Jan 2025 21:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433583A2C6C
	for <lists+linux-edac@lfdr.de>; Fri, 31 Jan 2025 20:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEB61F3D32;
	Fri, 31 Jan 2025 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jBy55Lhx"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C851B87E9;
	Fri, 31 Jan 2025 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355778; cv=none; b=cFFmGUrqa+Af+Lvk/jRmcH5oAxNZV/hjlUDer/jYq+ZAQ1W+12b0SA+qsvlGpOt648CK2gHcrIoBN639LX5fSOxr8LBBHTzKtg1wUAANM2Dnfh7PFb3Edh47JFHkrqeGhudg/q2kNtnxUuHY4V51kZAmEzybCsGD/sxlYS4wA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355778; c=relaxed/simple;
	bh=IQEen1Ym519bikzRVlyFo73+QCjlAbmDJBZwPkI1o0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqPNNrslGT83AFLX7Wb6KxmzrpxfNnj0xdQVBhLhCllgsClp4ciDCHI+yBF3p7lYimQDAv0usyH2n/dK5iR5jRtmUfgRLteQ8z3PkiUTLnOoIQj742QgFjpgh1gPT0GAwbQhmUV/g5sAu498Km0APiWIKoqCIpvBNtuU0IA8foc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jBy55Lhx; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id dxbjtZeDwYkukdxbntGonS; Fri, 31 Jan 2025 21:27:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738355245;
	bh=sH6U79vAbkJEv6QpI+M8a0wqTeJsJi1zHoHqBJ5qz4Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jBy55LhxLjhbaQPjE4gzrk3eKy83vlFaXb+KaqTYxQaclPgQ811QYskrjWf75xHNH
	 1xAoSaq6wejxUPiWFEjjLjhn7aNXsZJV+bgHy3xn1HJCUMeU8pIm60ZXdRpHcaBPDl
	 q/0Mg+mjo7P7dk5YiWZehkJ3GkW101zOzres5YHSMoyrCgGkRs9KBBAgZ+rUpkwxtw
	 5eQ5P2X4xddg7Y/Iq8KrEnKugdi9XEHifzN0Q8bCc6HVu6IJQWqp/MTFSe3JblarZH
	 agamySABWcIHMsdavysJLEmvdDWY5E7lhrPtpMOqoF+BFb5cY45IS91ObOB9mTxGfQ
	 xMRfIppjv3x3Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 31 Jan 2025 21:27:25 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Tony Luck <tony.luck@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-edac@vger.kernel.org
Subject: [PATCH] EDAC/igen6: Constify struct res_config
Date: Fri, 31 Jan 2025 21:27:02 +0100
Message-ID: <a06153870951a64b438e76adf97d440e02c1a1fc.1738355198.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct res_config' are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  36777	   2479	   4304	  43560	   aa28	drivers/edac/igen6_edac.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  37297	   1959	   4304	  43560	   aa28	drivers/edac/igen6_edac.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/edac/igen6_edac.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index fdf3a84fe698..38e624209b0f 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -125,7 +125,7 @@
 #define MEM_SLICE_HASH_MASK(v)		(GET_BITFIELD(v, 6, 19) << 6)
 #define MEM_SLICE_HASH_LSB_MASK_BIT(v)	GET_BITFIELD(v, 24, 26)
 
-static struct res_config {
+static const struct res_config {
 	bool machine_check;
 	int num_imc;
 	u32 imc_base;
@@ -472,7 +472,7 @@ static u64 rpl_p_err_addr(u64 ecclog)
 	return ECC_ERROR_LOG_ADDR45(ecclog);
 }
 
-static struct res_config ehl_cfg = {
+static const struct res_config ehl_cfg = {
 	.num_imc		= 1,
 	.imc_base		= 0x5000,
 	.ibecc_base		= 0xdc00,
@@ -482,7 +482,7 @@ static struct res_config ehl_cfg = {
 	.err_addr_to_imc_addr	= ehl_err_addr_to_imc_addr,
 };
 
-static struct res_config icl_cfg = {
+static const struct res_config icl_cfg = {
 	.num_imc		= 1,
 	.imc_base		= 0x5000,
 	.ibecc_base		= 0xd800,
@@ -492,7 +492,7 @@ static struct res_config icl_cfg = {
 	.err_addr_to_imc_addr	= ehl_err_addr_to_imc_addr,
 };
 
-static struct res_config tgl_cfg = {
+static const struct res_config tgl_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
 	.imc_base		= 0x5000,
@@ -506,7 +506,7 @@ static struct res_config tgl_cfg = {
 	.err_addr_to_imc_addr	= tgl_err_addr_to_imc_addr,
 };
 
-static struct res_config adl_cfg = {
+static const struct res_config adl_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
 	.imc_base		= 0xd800,
@@ -517,7 +517,7 @@ static struct res_config adl_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
-static struct res_config adl_n_cfg = {
+static const struct res_config adl_n_cfg = {
 	.machine_check		= true,
 	.num_imc		= 1,
 	.imc_base		= 0xd800,
@@ -528,7 +528,7 @@ static struct res_config adl_n_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
-static struct res_config rpl_p_cfg = {
+static const struct res_config rpl_p_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
 	.imc_base		= 0xd800,
@@ -540,7 +540,7 @@ static struct res_config rpl_p_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
-static struct res_config mtl_ps_cfg = {
+static const struct res_config mtl_ps_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
 	.imc_base		= 0xd800,
@@ -551,7 +551,7 @@ static struct res_config mtl_ps_cfg = {
 	.err_addr_to_imc_addr	= adl_err_addr_to_imc_addr,
 };
 
-static struct res_config mtl_p_cfg = {
+static const struct res_config mtl_p_cfg = {
 	.machine_check		= true,
 	.num_imc		= 2,
 	.imc_base		= 0xd800,
@@ -1374,7 +1374,7 @@ static void unregister_err_handler(void)
 	unregister_nmi_handler(NMI_SERR, IGEN6_NMI_NAME);
 }
 
-static void opstate_set(struct res_config *cfg, const struct pci_device_id *ent)
+static void opstate_set(const struct res_config *cfg, const struct pci_device_id *ent)
 {
 	/*
 	 * Quirk: Certain SoCs' error reporting interrupts don't work.
-- 
2.48.1


