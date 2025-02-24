Return-Path: <linux-edac+bounces-3189-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD3CA41A1B
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 11:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0F71895642
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F37254AF6;
	Mon, 24 Feb 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qY335oQc"
X-Original-To: linux-edac@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC9F1A83E4;
	Mon, 24 Feb 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391200; cv=none; b=WrRgBVPzZr3eNN0BpC4V7w/KznVIKn7kHpt7ZvMYYaEPRN5rViYaXd3k2WyV6DyoX0wGNxALsJT49geiAowGzLFDXzcssvC0W/NRj8vHxkGpxkhanV5EB3dfuBo3QvEr/DZnewvQTglaHHHGb/owt+O5+yjtdUqBBnckZt6Z7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391200; c=relaxed/simple;
	bh=lv2Hk4eNeUBrFbV6d3HvlUnJHDZaar2vjE2F5aIBTdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JybrnbcSlJsVd0pFcqeAxatArENbkBHfCr2rbVoESn1TlesJiT/1HFyfz7flaz90+1N/bnXBf+H7l3ZJ3sLJV81YbLzf9xaPOGAr9c0kHm9peqkuwDQSBkRPaCoj9VoxO28tdTClWWi8Z6AJdKJdeJgzpXW5oKT5isOTWeltSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qY335oQc; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740391196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=klwkj5bN/345d6wigktEvJtFzEefX09mrddgUez4Ztw=;
	b=qY335oQcxYja9Y5Va8YBypfkdgBZZn6NbO0D4yPJQVnmTN4qXQl3U9rXfbRB5sALl4Wsl0
	7w5Y/WXDqxkb+1NZvxiCDV+aNWZFBbfJ5E5dgFl8LA0YPIIME6CVHGY7IqReC1kCjRvcO6
	uBn8DITz+yXU4IQIaF+RDeuYku/t3p0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] EDAC: Simplify return statement in dct_ecc_enabled()
Date: Mon, 24 Feb 2025 10:58:19 +0100
Message-ID: <20250201130953.1377-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Simplify the return statement to improve the code's readability.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/edac/amd64_edac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 8414ceb43e4a..1f106b4fafdf 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3355,10 +3355,7 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
 
 	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
 
-	if (!ecc_en || !nb_mce_en)
-		return false;
-	else
-		return true;
+	return ecc_en && nb_mce_en;
 }
 
 static bool umc_ecc_enabled(struct amd64_pvt *pvt)
-- 
2.48.1


