Return-Path: <linux-edac+bounces-2069-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56F99DF80
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 09:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DCA1F22B1B
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 07:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE451A76D4;
	Tue, 15 Oct 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oh+hcgvw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D0231C95;
	Tue, 15 Oct 2024 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978309; cv=none; b=SbgznLGJOtD/IXkdk2E4wyIOIIjz/a0TDgbdLW4JDzafvZzpCVawq1pnZAXkUk8J4IfG/obAWzTtOg74MsXmk9jtfEOp4qJaWbqo1NEPh0Ah6qQO3ynYv+9AP3lIR0PHLKtPOEUwi9S/bSk1nR5tDu3OViy/YBWTVqu1YFWzA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978309; c=relaxed/simple;
	bh=VM730l2qFb0YD0FEHTmVV8j8ITO1tx28eMDxqydRoxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NG6qXLgwlbmNKjsJktHQ6/j/sdIpASglomPZT0nLVAQAwT1TOV6I5PaeMU7tl459M2Fbh794w+9dPn9V7Z/jkuvN7A/qWqV9bx4f+LjxL7o3YJorwblDNqEHwzAF0b9W2TBK1hZSl15Xrvdde+UwJ0RIRLk5gt/04Wdds6TNR1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oh+hcgvw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728978308; x=1760514308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=VM730l2qFb0YD0FEHTmVV8j8ITO1tx28eMDxqydRoxU=;
  b=Oh+hcgvwCB5QFZZGDS7zWlV9Kdh37pwB89uGWbgLaSfCFl5QZ4s6GKFf
   iw5DL6ul2i3BOoihSROIEkG85965XOgIi4oiKtBGOW8HXdh2ePCJVT6Zx
   69+UcWRXYSCKhO1JEXoQblZdJLUGfV42aw0+SLuqO1vZKZBO7DYZqqqht
   D5O83Ez2IiBbtu17YODNXn4cVmRmtsYpQDSntspM/vqgDNp+Hor508730
   HjNA2nAsARg8cWShhYXWU3jwJhnR4E2riLN86S9W8sYGk/oN87GSt406B
   nNe3LFsrbaqA+vsy6LpM7rQrf/tsTLEj5fwjDOF0IZyL2IXNl7WHx7yyo
   Q==;
X-CSE-ConnectionGUID: 6XqEx/0bSLueCfmLSOGK4Q==
X-CSE-MsgGUID: 3qWE7a0QQ+uZHQX0AbJ1uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28483562"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28483562"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 00:45:04 -0700
X-CSE-ConnectionGUID: iyPOuqyDSmmFmfGIaC70Ug==
X-CSE-MsgGUID: +ytgteYUQ0mwdP3hj95lhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77752370"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 00:45:02 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] EDAC/{skx_common,i10nm}: Fix incorrect far-memory error source indicator
Date: Tue, 15 Oct 2024 15:22:36 +0800
Message-Id: <20241015072236.24543-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241015072236.24543-1-qiuxu.zhuo@intel.com>
References: <20241015072236.24543-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The Granite Rapids CPUs with Flat2LM memory configurations may
mistakenly report near-memory errors as far-memory errors, resulting
in the invalid decoded ADXL results:

  EDAC skx: Bad imc -1

Fix this incorrect far-memory error source indicator by prefetching the
decoded far-memory controller ID, and adjust the error source indicator
to near-memory if the far-memory controller ID is invalid.

Fixes: ba987eaaabf9 ("EDAC/i10nm: Add Intel Granite Rapids server support")
Tested-by: Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c |  1 +
 drivers/edac/skx_common.c | 23 +++++++++++++++++++++++
 drivers/edac/skx_common.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index e2a954de913b..51556c72a967 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -1036,6 +1036,7 @@ static int __init i10nm_init(void)
 		return -ENODEV;
 
 	cfg = (struct res_config *)id->driver_data;
+	skx_set_res_cfg(cfg);
 	res_cfg = cfg;
 
 	rc = skx_get_hi_lo(0x09a2, off, &tolm, &tohm);
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 52b462899870..6cf17af7d911 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -47,6 +47,7 @@ static skx_show_retry_log_f skx_show_retry_rd_err_log;
 static u64 skx_tolm, skx_tohm;
 static LIST_HEAD(dev_edac_list);
 static bool skx_mem_cfg_2lm;
+static struct res_config *skx_res_cfg;
 
 int skx_adxl_get(void)
 {
@@ -135,6 +136,22 @@ static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 		return false;
 	}
 
+	/*
+	 * GNR with a Flat2LM memory configuration may mistakenly classify
+	 * a near-memory error(DDR5) as a far-memory error(CXL), resulting
+	 * in the incorrect selection of decoded ADXL components.
+	 * To address this, prefetch the decoded far-memory controller ID
+	 * and adjust the error source to near-memory if the far-memory
+	 * controller ID is invalid.
+	 */
+	if (skx_res_cfg && skx_res_cfg->type == GNR && err_src == ERR_SRC_2LM_FM) {
+		res->imc = (int)adxl_values[component_indices[INDEX_MEMCTRL]];
+		if (res->imc == -1) {
+			err_src = ERR_SRC_2LM_NM;
+			edac_dbg(0, "Adjust the error source to near-memory.\n");
+		}
+	}
+
 	res->socket  = (int)adxl_values[component_indices[INDEX_SOCKET]];
 	if (err_src == ERR_SRC_2LM_NM) {
 		res->imc     = (adxl_nm_bitmap & BIT_NM_MEMCTRL) ?
@@ -191,6 +208,12 @@ void skx_set_mem_cfg(bool mem_cfg_2lm)
 }
 EXPORT_SYMBOL_GPL(skx_set_mem_cfg);
 
+void skx_set_res_cfg(struct res_config *cfg)
+{
+	skx_res_cfg = cfg;
+}
+EXPORT_SYMBOL_GPL(skx_set_res_cfg);
+
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log)
 {
 	driver_decode = decode;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index cd47f8186831..54bba8a62f72 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -241,6 +241,7 @@ int skx_adxl_get(void);
 void skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 void skx_set_mem_cfg(bool mem_cfg_2lm);
+void skx_set_res_cfg(struct res_config *cfg);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
-- 
2.17.1


