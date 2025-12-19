Return-Path: <linux-edac+bounces-5573-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D5ECCE6FF
	for <lists+linux-edac@lfdr.de>; Fri, 19 Dec 2025 05:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB5C2302AFA9
	for <lists+linux-edac@lfdr.de>; Fri, 19 Dec 2025 04:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBBC21A453;
	Fri, 19 Dec 2025 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lh6Yfzff"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648ED78F4A;
	Fri, 19 Dec 2025 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766118763; cv=none; b=oNESucAX0UOluqUDNgXtUKe8/hx1Ind88reT+c5bxH5w66M+ZKY4I87r0oZu83w6BOMpch3m2F6P5m2pYn6kflVYWUwYyl3KB4D1Sj61gjhMEiJkS8vY0dClAgItRGzSzgrTHObqT9E4uBQqzQ0PTzOXRKk8PyeTAyJRQT98MiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766118763; c=relaxed/simple;
	bh=SjK3pcUS+fJBsts9dNu9wZ0G9UPW5xOLGGTyXilor1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OL3KJ3J+CGi2aR6HWALGPcGMqBZNyHgWwgVG/OcpxDoPltXGWNzjRdpZkKozYarcnK0MDVCeK3jsBpy6SgDLQvsvqwV0KBfe7efBmwSntZv8UEX9s2JO/6GvMeoW+3EZbxZw/O8bVqQwcOXPh52EK9c9rcFMnpfKCt0nJy8oQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lh6Yfzff; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766118763; x=1797654763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SjK3pcUS+fJBsts9dNu9wZ0G9UPW5xOLGGTyXilor1Y=;
  b=lh6Yfzff9GfFFJwERU8NkOVU5KaRXDgA1EXP6t9bwB+ngC6dO6GJLl+K
   KOcctfaQyrNKh8/apqeQuKt2LM4HXrV7yUYIGUS/s5yBdK5sp8/RBa/Fh
   0rmVfDAcumrkhpsA3zwVJ8XbUSRqsuTiiPAMrZedx+v2G2pYf9/cuRlP7
   AwBUQjzGlF62g25UGkQmhiRxCmi92L+Dlssu2WIV8Up5tUnGBore5lZaO
   DDtZWVVRrboIbx0+abkQoCn1ptjIjGSizyrPQDjOorvBQO2cdgud54LaL
   SIabH30LOgO6aSc6CdGSVVSEx4m5ajbKLPq1sLkQDtSqasYrC93LY9qSQ
   Q==;
X-CSE-ConnectionGUID: 0N4DZ+mqQGKE8NF8sWkETQ==
X-CSE-MsgGUID: pmxjPfewRKmt06LIqJKNXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="85500414"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="85500414"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 20:32:42 -0800
X-CSE-ConnectionGUID: DrLk++GnQHGMB7cLgVkUnA==
X-CSE-MsgGUID: XOAKMvbpRGK2E24sMjQGpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="202937709"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 20:32:39 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: qiuxu.zhuo@intel.com,
	jianfeng.gao@intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [PATCH v2 0/2] EDAC: Add two Intel Amston Lake SoCs support
Date: Fri, 19 Dec 2025 12:29:54 +0800
Message-ID: <20251219042956.3232568-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
References: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:

 - Patch 1: No changes.
 - Patch 2: Remove local field_get() definition.

Patch 1: Add IBECC EDAC support for another two Intel Amston Lake SoCs.
Patch 2: Configure masks of four memory controller registers properly.

Qiuxu Zhuo (2):
  EDAC/igen6: Add two Intel Amston Lake SoCs support
  EDAC/igen6: Make masks of {MCHBAR, TOM, TOUUD, ECC_ERROR_LOG} configurable

 drivers/edac/igen6_edac.c | 69 ++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 12 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.43.0


