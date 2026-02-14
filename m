Return-Path: <linux-edac+bounces-5720-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FB1BD7wakGkpWQEAu9opvQ
	(envelope-from <linux-edac+bounces-5720-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 14 Feb 2026 07:48:28 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9FF13B421
	for <lists+linux-edac@lfdr.de>; Sat, 14 Feb 2026 07:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF8A30247D8
	for <lists+linux-edac@lfdr.de>; Sat, 14 Feb 2026 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA0E3161A6;
	Sat, 14 Feb 2026 06:48:24 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678A30FF30;
	Sat, 14 Feb 2026 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771051703; cv=none; b=twtSjOXILVA49kkoPVayo4VbwnPIUvHLAnnQITVLM6M0PEYrKy4jeGIRoY3TGDJpArzhJYX6yAooZi74j7tUwE6hCe92npSQ9or9GzWcjQ5eCFnm9EnOwPJUbdAUiEucygv/TkLchjbP+LJY4by8rtB8eYwf9O5gOt43wBjn2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771051703; c=relaxed/simple;
	bh=FxZk7KIYWWr1J7nfsvlVvAmNjHbQQUjN8XBbwufUIig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GlXFlN2rX0eaPwYWq4lBUxeJgQwK8WAyTkO3UomWIX++bRxjvfqoYhqSef86rWnWzpO7oQ5Z/0bkSXsUFF2bD7mODYX+uUbjsAk582pip4ZVJlXhqgp7Y97uwl1KyX9papkRoVw30hhsEi3YQ8nUDGj0DNIgFv2SAcumxWJTqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shiaichun@open-hieco.net fp:SMTPD_---.gX9s-M2_1771051350 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 14 Feb 2026 14:42:49 +0800
From: Aichun Shi <shiaichun@open-hieco.net>
To: yazen.ghannam@amd.com
Cc: tglx@linutronix.de,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shiaichun@open-hieco.net
Subject: [PATCH] EDAC/mce_amd: Fix Hygon UMC ECC error decoding with logical_die_id
Date: Sat, 14 Feb 2026 14:42:03 +0800
Message-ID: <20260214064203.62488-1-shiaichun@open-hieco.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[shiaichun@open-hieco.net,linux-edac@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[open-hieco.net];
	TAGGED_FROM(0.00)[bounces-5720-lists,linux-edac=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,open-hieco.net:mid,open-hieco.net:email]
X-Rspamd-Queue-Id: 4D9FF13B421
X-Rspamd-Action: no action

cpuinfo_topology.amd_node_id is populated via CPUID or MSR, as introduced
by commit f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology
parser") and commit 03fa6bea5a3e ("x86/cpu: Make topology_amd_node_id()
use the actual node info"). However, this value may be non-continuous for
Hygon processors while EDAC uses continuous node IDs, which leads to
incorrect UMC ECC error decoding.

In contract, cpuinfo_topology.logical_die_id always provides continuous
die (or node) IDs. Fix this by replacing topology_amd_node_id() with
topology_logical_die_id() when decoding UMC ECC errors for Hygon
processors.

Signed-off-by: Aichun Shi <shiaichun@open-hieco.net>
---
 drivers/edac/mce_amd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index af3c12284a1e..4a23c1d6488e 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -746,8 +746,13 @@ static void decode_smca_error(struct mce *m)
 	pr_emerg(HW_ERR "%s Ext. Error Code: %d", smca_get_long_name(bank_type), xec);
 
 	if ((bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) &&
-	    xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(topology_amd_node_id(m->extcpu), m);
+	    xec == 0 && decode_dram_ecc) {
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
+		    boot_cpu_data.x86 == 0x18)
+			decode_dram_ecc(topology_logical_die_id(m->extcpu), m);
+		else
+			decode_dram_ecc(topology_amd_node_id(m->extcpu), m);
+	}
 }
 
 static inline void amd_decode_err_code(u16 ec)
-- 
2.47.3


