Return-Path: <linux-edac+bounces-2649-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1389E60E2
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 23:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FB61884996
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450A1BE23F;
	Thu,  5 Dec 2024 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lh3cfSfz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8A19D8B2;
	Thu,  5 Dec 2024 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733439128; cv=none; b=JcqejAwh/N+0Fvx6YRw97/TwpQoHLVrwpADI+YnT6TDQvizqgVXuTP7a1fRADi3tGdPS5Mjht2ilw0RWkyq1qNIInP2cXtkW5aYngaZ4Ui0U8F39z9hAkEiL2qrIm8zRKmOWpVuZCD89ikFHGyRNCBGABq5+PvFV1ovQvY3ag5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733439128; c=relaxed/simple;
	bh=Z6Fl2fUobyacZ+8Mw/GuF3pr94JsxKCti4uRbCbhxNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzlihZkxlc32GGPyX8mww2hO8gSiwsfClPx8GRe2ZzOEL+8dNE/Dz9WIlL+HUrRdKOfPn5aOfKB+wShLzK3b++Md9cx0WVcgQJdl4YM3QzsVo9dYxKCFtXoikLNhvR8fY5P3wgHb+XVuy/q4ZcytIgeEzgXJDUK8gST4DOkaDQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lh3cfSfz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733439126; x=1764975126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z6Fl2fUobyacZ+8Mw/GuF3pr94JsxKCti4uRbCbhxNE=;
  b=Lh3cfSfzuIGg9Fe9wlN6EQi3E8hjhLSmgzyAPPnRaPygILt1H+lIP4yC
   up+ORLKbfpkz+1h8q/rEku9Hswdi/WQKn60PGzq6qMBtQ8pEMyMH9DrkK
   pfnQNwDuNHQkl+K/AJkOZMPU4OpVpPkjieGdX2CtrTZRipD4b45HZ5hcX
   QLM5cRRv4/wOWQdRccCVF0SWnWofn/oqKtrHk2bgf05dFJyzB6V3AoGXv
   7J2Srqu5C4U6Wma5Fg+JbUTglc+ZQ+YoGxweLNIT/ZQgK/jGsSkigQwCi
   YFSj67VOSa15dwnBN+3sC7OYcZySTfBff0WFZ8ZpOcV6RwOCSEDZAd4DS
   A==;
X-CSE-ConnectionGUID: 12NgKrY7R5GZhmDFpBnY2w==
X-CSE-MsgGUID: 2gPQYRTlQvml3Wh/tj2zHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="56261481"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="56261481"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:52:05 -0800
X-CSE-ConnectionGUID: HbMAVmjpSi2E7p05SiFmvw==
X-CSE-MsgGUID: DsXx+nc/Rf+HiEPP9PH4tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="94309100"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:52:05 -0800
Date: Thu, 5 Dec 2024 14:52:03 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: bp@alien8.de, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Message-ID: <Z1Iuk-_VdmZibOes@agluck-desk3>
References: <20241205165954.7957-1-kyle.meyer@hpe.com>
 <Z1H7U9-O2LdAoa5r@agluck-desk3>
 <Z1IHkBlm_0p-0-c3@hpe.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1IHkBlm_0p-0-c3@hpe.com>

On Thu, Dec 05, 2024 at 02:05:36PM -0600, Kyle Meyer wrote:
> On Thu, Dec 05, 2024 at 11:13:23AM -0800, Luck, Tony wrote:
> > On Thu, Dec 05, 2024 at 10:59:54AM -0600, Kyle Meyer wrote:
> > > The 3-bit source IDs in PCI configuration space registers are limited to
> > > 8 unique IDs, and each ID is local to a clump (UPI/QPI domain).
> > 
> > Is there any better name than "clump"?
> 
> Yes, a UPI/QPI domain.

Ok, let's use that.

> > > Source IDs can not be used to map devices to sockets on systems with
> > > multiple clumps because each clump has identical repeating source IDs.
> > > 
> > > Get package IDs instead of source IDs on systems with multiple clumps
> > > and use package/source IDs to name IMC information structures.
> > 
> > What would happen if you just assumed the system had clumps and you
> > always used package/source? Would that change EDAC naming for
> > existing systems? That would be less complexity for the driver.
> 
> That works if NUMA is enabled. skx_get_pkg_id() uses NUMA information to
> determine the package ID.

I cobbled together this patch on top of yours. I think it is
functionally equivalent. The #ifdef CONFIG_NUMA in the ".c"
file is ugly, but serves to illustrate what I'm trying to do
without too much cleanup noise.

1) Does this work? I tried on a non-clumpy system that is NUMA.

2) Is it better (assuming #fidef factored off into a .h file)?


-Tony

---

diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 0f06d45c9b3e..b0845bdd4516 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -244,8 +244,6 @@ void skx_set_mem_cfg(bool mem_cfg_2lm);
 void skx_set_res_cfg(struct res_config *cfg);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
-int skx_check_dup_src_ids(int off);
-int skx_get_pkg_id(struct skx_dev *d, u8 *id);
 
 int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list);
 
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 59384677d025..16d1110c0692 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -1018,7 +1018,6 @@ static int __init i10nm_init(void)
 	int rc, i, off[3] = {0xd0, 0xc8, 0xcc};
 	u64 tolm, tohm;
 	int imc_num;
-	int dup_src_ids = 0;
 
 	edac_dbg(2, "\n");
 
@@ -1066,15 +1065,8 @@ static int __init i10nm_init(void)
 
 	imc_num = res_cfg->ddr_imc_num + res_cfg->hbm_imc_num;
 
-	rc = dup_src_ids = skx_check_dup_src_ids(0xf8);
-	if (rc < 0)
-		goto fail;
-
 	list_for_each_entry(d, i10nm_edac_list, list) {
-		if (dup_src_ids)
-			rc = skx_get_pkg_id(d, &src_id);
-		else
-			rc = skx_get_src_id(d, 0xf8, &src_id);
+		rc = skx_get_src_id(d, 0xf8, &src_id);
 		if (rc < 0)
 			goto fail;
 
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 189b8c5a1bda..93f7c05faccc 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -602,7 +602,6 @@ static int __init skx_init(void)
 	int rc = 0, i, off[3] = {0xd0, 0xd4, 0xd8};
 	u8 mc = 0, src_id;
 	struct skx_dev *d;
-	int dup_src_ids = 0;
 
 	edac_dbg(2, "\n");
 
@@ -647,15 +646,8 @@ static int __init skx_init(void)
 		}
 	}
 
-	rc = dup_src_ids = skx_check_dup_src_ids(0xf0);
-	if (rc < 0)
-		goto fail;
-
 	list_for_each_entry(d, skx_edac_list, list) {
-		if (dup_src_ids)
-			rc = skx_get_pkg_id(d, &src_id);
-		else
-			rc = skx_get_src_id(d, 0xf0, &src_id);
+		rc = skx_get_src_id(d, 0xf0, &src_id);
 		if (rc < 0)
 			goto fail;
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 56fec7310f40..414a1e6cf0f5 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -221,49 +221,7 @@ void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log)
 }
 EXPORT_SYMBOL_GPL(skx_set_decode);
 
-int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
-{
-	u32 reg;
-
-	if (pci_read_config_dword(d->util_all, off, &reg)) {
-		skx_printk(KERN_ERR, "Failed to read src id\n");
-		return -ENODEV;
-	}
-
-	*id = GET_BITFIELD(reg, 12, 14);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(skx_get_src_id);
-
-int skx_check_dup_src_ids(int off)
-{
-	u8 id;
-	struct skx_dev *d;
-	int rc;
-	DECLARE_BITMAP(id_map, 8);
-
-	bitmap_zero(id_map, 8);
-
-	/*
-	 * The 3-bit source IDs in PCI configuration space registers are limited
-	 * to 8 unique IDs, and each ID is local to a clump (UPI/QPI domain).
-	 */
-	list_for_each_entry(d, &dev_edac_list, list) {
-		rc = skx_get_src_id(d, off, &id);
-		if (rc < 0)
-			return rc;
-
-		if (test_bit(id, id_map))
-			return 1;
-
-		set_bit(id, id_map);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(skx_check_dup_src_ids);
-
-int skx_get_pkg_id(struct skx_dev *d, u8 *id)
+static int skx_get_pkg_id(struct skx_dev *d, u8 *id)
 {
 	int node;
 	int cpu;
@@ -283,7 +241,24 @@ int skx_get_pkg_id(struct skx_dev *d, u8 *id)
 	skx_printk(KERN_ERR, "Failed to get package ID from NUMA information\n");
 	return -ENODEV;
 }
-EXPORT_SYMBOL_GPL(skx_get_pkg_id);
+
+int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
+{
+#ifdef CONFIG_NUMA
+	return skx_get_pkg_id(d, id);
+#else
+	u32 reg;
+
+	if (pci_read_config_dword(d->util_all, off, &reg)) {
+		skx_printk(KERN_ERR, "Failed to read src id\n");
+		return -ENODEV;
+	}
+
+	*id = GET_BITFIELD(reg, 12, 14);
+	return 0;
+#endif
+}
+EXPORT_SYMBOL_GPL(skx_get_src_id);
 
 static int get_width(u32 mtr)
 {

