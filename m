Return-Path: <linux-edac+bounces-1035-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C106F8C2381
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 13:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F083C1C203B3
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 11:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4449A16F28B;
	Fri, 10 May 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MonlHVN8"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83794770E7;
	Fri, 10 May 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340515; cv=none; b=eXdzCIAnXyRgvw/zr7KSBnixG3DApFbKvH7zdiHtSHfju8SfgtwpplzM8r5bJSGGX6bZFbohaTovb+RHB4E9NhCO8/GhhboVBC3MwwvsAuLy1oaQ35v434m7PKc1NXiuu37jlziNSLugDVebqtSHRKPAumkRM74O5JLv3Fu6wNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340515; c=relaxed/simple;
	bh=ZLmyf/SB9k8bTUf14Biaey4u/W6IvmiD6BOPwOaZAe8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YZJ5/uuwZe1/b0mXflvkg6NoIjbSotkuhqY4Jpcpe/88h4awvLVqbS5vdXqyszbUNPpazo0rRaD2Gv1fwyBag9FavonX6cOqqv98FWl1MutYvoCY9UUBEpfo3GX4U+VkQUHRpctsFOnyXhmz7DChRNm9a1+Msk8A+hN0ku35mdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MonlHVN8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715340513; x=1746876513;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZLmyf/SB9k8bTUf14Biaey4u/W6IvmiD6BOPwOaZAe8=;
  b=MonlHVN8XvPnuT+AAfZvuNe11lkw3bNh/RbYRZA114Ql+kk40prv8OPK
   VrdYt1Lf1F+0jPzFjnULvTEh7C03MX1c/wIVhAQVqphtSL8JNcSsXTGkT
   RvtUl6dTCWbiJqnUYnuIoB9M1weJPpt5aUerDIt+UJJ1ZtmJfwh7RB6bv
   28hkuGZOJl/OqaBuso7TPinP8UG3zc6JOFXjr+zexhpo7gpUpcEj4OlW0
   d1pgNvlMjSCLEUKzoEBXqCXUt6RHy73Y9lIGbHW+nQZGI+RtSs/v1ptiu
   /hi8cdfKWYYIu4Kjm1g3adxF+ZU0BW2uHrHGLRg88QZ7A9pA0b5mRkFV/
   A==;
X-CSE-ConnectionGUID: sU266BowRiSf+LFA7e6+aA==
X-CSE-MsgGUID: EJjBhLcJTqafrsE34MNt6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21913191"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21913191"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:28:31 -0700
X-CSE-ConnectionGUID: wN6vl6IcTgSEOcr+1toScA==
X-CSE-MsgGUID: 5lvBBX4ORUi2dE00CEmXoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="30138439"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.191])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:28:28 -0700
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
Subject: [RFC PATCH v2 0/3] Make ELOG log and trace consistently with GHES 
Date: Fri, 10 May 2024 13:21:44 +0200
Message-ID: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Firmware First is enabled, BIOS handles errors first and then it
makes them available to the kernel via the Common Platform Error Record
(CPER) sections (UEFI 2.10 Appendix N). Linux parses the CPER sections
via two similar paths, ELOG and GHES.

Currently, ELOG and GHES show some inconsistencies in how they print to
the kernel log as well as in how they report to userspace via trace
events.

This short series wants to make these two paths act similarly for what
relates to logging and tracing.

--- Changes in v2 ---
	
	- 0/3: rework the subject line and the letter.
        - 1/3: no changes.
        - 2/3: trace CPER PCIe Section only if CONFIG_ACPI_APEI_PCIEAER
          is defined; the kernel test robot reported the use of two
          undefined symbols because the test for the config option was
          missing; rewrite the subject line and part of commit message.
        - 3/3: no changes.

Fabio M. De Francesco (3):
  ACPI: extlog: Trace CPER Non-standard Section Body
  ACPI: extlog: Trace CPER PCI Express Error Section
  ACPI: extlog: Make print_extlog_rcd() log unconditionally

 drivers/acpi/acpi_extlog.c | 47 ++++++++++++++++++++++++++++++++++----
 drivers/ras/debugfs.c      |  6 -----
 include/linux/ras.h        |  2 --
 3 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.45.0


