Return-Path: <linux-edac+bounces-1643-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0195147A
	for <lists+linux-edac@lfdr.de>; Wed, 14 Aug 2024 08:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037C81C23FEC
	for <lists+linux-edac@lfdr.de>; Wed, 14 Aug 2024 06:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF0012C484;
	Wed, 14 Aug 2024 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="he0BaJc2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7574424;
	Wed, 14 Aug 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616605; cv=none; b=GN7sthjjKrWPnURTM/6NQte/s8JWO/qQ79kIdBuoOIL4uA8L/YfrOcnBQyyukwKdc5PluQMFbHxgsTKFntnz9C3vCnj4mYeq17Gg7vLE+Fn94rTB8rWGscAqWKd2yMZappDIF5WRdx9mQRvCmLHmtst9IP7WhYiLdJH+0NCP0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616605; c=relaxed/simple;
	bh=08md5farfI8/U7k7Z0ZVhMh1+qgSE56XmGI12U5uknA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sD7WghWl5p1yEfjdE1/RWQ4f4pjJH8jgQCrs0XlzH8+Ly6B+Jb1ImqzeLmGU9qgOWIfGeSqXyb6vbIGu+teSAH+v6N8SJRa/dPXocdGaNNMS3si5PmbsYI9zXCkB66movgbK5WbF5brZWv1AuoixhQB2t4pgYNyqLNKUD5MgNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=he0BaJc2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723616603; x=1755152603;
  h=from:to:cc:subject:date:message-id;
  bh=08md5farfI8/U7k7Z0ZVhMh1+qgSE56XmGI12U5uknA=;
  b=he0BaJc2yoEo1TJsYyysKw5U2aso1WV4iyflYaqQqbD0/GnDM4VsoYha
   lc4VUNP0mjAd17e+x8Eak4NhYZB5/fpQKub47NPwa0J4He8g9LLd79GP8
   f46q/IUtLUykf5xmNMFJbUxearnKb00Ymt7d5f7RzEnX9nmi2NYtwW1/A
   xBJF5LkjjPX2C3NViRziksxv71j/6ShqwIzbnXrLNejERGHE5VpIl0iUq
   4F6yphMiosMJIFJB7ay+fO2rkH1LmfHh4cIrowUnkEkgJrEQWBJYPoR4x
   JuKu//p/aiq07pPRN4ruPLTBmNDBjtj1r2/fSGrt2pRwvqA80YAslBLNv
   g==;
X-CSE-ConnectionGUID: Cl01zjpYT+yDEQvD/WKbFA==
X-CSE-MsgGUID: vlRxD6KJS1O5Ucly3Kg2SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21972893"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="21972893"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 23:23:22 -0700
X-CSE-ConnectionGUID: 6PM9q/EyRBWZJ2fOF+7NJg==
X-CSE-MsgGUID: 5SqrjFCOTNa6mEgtpO4UhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="59013610"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 23:23:20 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/1] EDAC/igen6: Fix conversion of system address to physical memory address
Date: Wed, 14 Aug 2024 14:10:11 +0800
Message-Id: <20240814061011.43545-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The conversion of system address to physical memory address (as viewed by
the memory controller) by igen6_edac is incorrect when the system address
is above the TOM (Total amount Of populated physical Memory) for Elkhart
Lake and Ice Lake (Neural Network Processor). Fix this conversion.

Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 0fe75eed8973..189a2fc29e74 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -316,7 +316,7 @@ static u64 ehl_err_addr_to_imc_addr(u64 eaddr, int mc)
 	if (igen6_tom <= _4GB)
 		return eaddr + igen6_tolud - _4GB;
 
-	if (eaddr < _4GB)
+	if (eaddr >= igen6_tom)
 		return eaddr + igen6_tolud - igen6_tom;
 
 	return eaddr;
-- 
2.17.1


