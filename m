Return-Path: <linux-edac+bounces-2038-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E151F99C816
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 13:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D03F28A377
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 11:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092AB1C728F;
	Mon, 14 Oct 2024 11:01:07 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916751C6F6C;
	Mon, 14 Oct 2024 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903666; cv=none; b=Pucp2iUIXPApyEI3sZhOry2mACjJ2tcDMS43ZGkDKbYpe4zrvCS+Qad3fh16z3v+okbIzc5MUrZJHATZr6A1vnzgrthVTXq5c3HpnD4sgrb6mo8eF9g6rm9ieltGjrcPn/vGdpvhDV2fgQnvrxDm4Dm64YQ761eP4ovquDONiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903666; c=relaxed/simple;
	bh=hSw1XL/fT8ACPqBnztWj/m8yyV3VB6n7kgpa0BxrExU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0EXMyPgKL5K2qw10St4e+34wXhMJKMpOhn2vWijfz6uvVHZOUBaDtpvNVot1ZoaPTIElktEixe7yibTGPVTu6PnoY7GssTolFzBh9XGfJGi+PgtadDegCSUVFss22tq2B8WXYPNGaSAzdkAlMhcPYuDCGpRfFXO5wdQc8pfGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D88E716F8;
	Mon, 14 Oct 2024 04:01:34 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B95D73F51B;
	Mon, 14 Oct 2024 04:01:02 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 31/57] edac: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:38 +0100
Message-ID: <20241014105912.3207374-31-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Convert PAGES_TO_MiB() and MiB_TO_PAGES() to use the ternary operator so
that they continue to work with boot-time page size; Boot-time page size
can't be used with CPP because it's value is not known at compile time.
For compile-time page size builds, the compiler will dead code strip for
the same result.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/edac/edac_mc.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a5..22132ee86e953 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -37,13 +37,12 @@
 #include <linux/workqueue.h>
 #include <linux/edac.h>
 
-#if PAGE_SHIFT < 20
-#define PAGES_TO_MiB(pages)	((pages) >> (20 - PAGE_SHIFT))
-#define MiB_TO_PAGES(mb)	((mb) << (20 - PAGE_SHIFT))
-#else				/* PAGE_SHIFT > 20 */
-#define PAGES_TO_MiB(pages)	((pages) << (PAGE_SHIFT - 20))
-#define MiB_TO_PAGES(mb)	((mb) >> (PAGE_SHIFT - 20))
-#endif
+#define PAGES_TO_MiB(pages)	(PAGE_SHIFT < 20 ?			\
+					((pages) >> (20 - PAGE_SHIFT)) :\
+					((pages) << (PAGE_SHIFT - 20)))
+#define MiB_TO_PAGES(mb)	(PAGE_SHIFT < 20 ?			\
+					((mb) << (20 - PAGE_SHIFT)) :	\
+					((mb) >> (PAGE_SHIFT - 20)))
 
 #define edac_printk(level, prefix, fmt, arg...) \
 	printk(level "EDAC " prefix ": " fmt, ##arg)
-- 
2.43.0


