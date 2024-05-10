Return-Path: <linux-edac+bounces-1036-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47AA8C2385
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 13:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599031F22695
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 11:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3842C17BB2A;
	Fri, 10 May 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUIga4Bt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410E16F8F7;
	Fri, 10 May 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340521; cv=none; b=UO0O8R10sfszIW2EkceaMQPBbSIBR5RniiREtctXCoW5y8CoV3bhrj3L369QA0zQ7g6d/JmS1zfJPk433DF1TaXWO1mXRcg3aiZKu0f/p/VXlRhXrOLqxQg71DTP6oRn9sG4/YerdX3qswjZIMD0HxZI+o2JsoANzkjZMvKWD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340521; c=relaxed/simple;
	bh=TexMWZHQ26C//ctAHxaVIeIDYvtnMtzZSIGXCtmoJns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TX6RBx3GwogPRfUsMBapD42vDvUqORUvVgcZJJzU02VO1BgFduxC1w4qjAO8Y9cBI9c+4EMgC0W3rP7CAc/WqyoenuwpxsMGC7wo+00VL7uhj1pJ4hQyuQaShV/tYY3593prVzg2D25k6uVpe/5ae6iM9QZQcxJDW36nPvO+H1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUIga4Bt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340515; x=1746876515;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=TexMWZHQ26C//ctAHxaVIeIDYvtnMtzZSIGXCtmoJns=;
  b=iUIga4Bt0sDs3mtYk56U5KFq7h8r1tUDOphwCbpAGgHyBLyFvXz7zY03
   O4LJq42Qa75wbrJZj1YFl0xS72GYoDFsERYHv/+heYJL58JAvJMMAsaPO
   5KdwUfWZPoBtEY/aW7oKkqUVQSlzDdtfRCHmgh0oo3PBl9+Gg/KYu4L3e
   TrUQYUIGLY3AGCKPpOqGgeg0M1pgJFZ4tjHYZILHJuR3f2Dg3QKHYxh8/
   KdA15PdsXdY2TVk1z4knnNQTZiF06aoPohRG7icwUK2xme0/zR7mAyQv3
   tT5oYSySYSRiz8LUnorQDXakwMSZ7u2WfTklhHVUxO/cdw4bcVbALROJ1
   g==;
X-CSE-ConnectionGUID: haAluW5ATAK8P6IABULoSw==
X-CSE-MsgGUID: +uSUpLcASJyKq+zm4dKYCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21913199"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21913199"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:28:35 -0700
X-CSE-ConnectionGUID: mISj+nZ6SHWD8pJIatsTJg==
X-CSE-MsgGUID: ahDhP+s8QaS5zoAhPvF76w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="30138443"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.191])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:28:32 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [RFC PATCH v2 1/3] ACPI: extlog: Trace CPER Non-standard Section Body
Date: Fri, 10 May 2024 13:21:45 +0200
Message-ID: <20240510112740.667445-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make extlog_print() (ELOG) trace "Non-standard Section Body" reported by
firmware to the OS via Common Platform Error Record (CPER) (UEFI v2.10
Appendix N 2.3).

This adds further debug information and makes ELOG logs consistent with
ghes_do_proc() (GHES).

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index ca87a0939135..4e62d7235d33 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -182,6 +182,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
 						       (u8)gdata->error_severity);
+		} else {
+			void *err = acpi_hest_get_payload(gdata);
+
+			trace_non_standard_event(sec_type, fru_id, fru_text,
+						 gdata->error_severity, err,
+						 gdata->error_data_length);
 		}
 	}
 
-- 
2.45.0


