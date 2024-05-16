Return-Path: <linux-edac+bounces-1059-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBE48C77C3
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2024 15:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A887A282A92
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30356146D7F;
	Thu, 16 May 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="owcwvjZq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E6143749;
	Thu, 16 May 2024 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866454; cv=none; b=eVA2DU0Fdxb8cIHcJoPZq8v+jHRM47r1b/msimUrd6JOmbV0NudA3hyGNjaNLR62Z3xf8jo+sh3jUftsXGSwseyVapqSUgoFOv2gUb3YBO205+KduY1p6tzXZpQ25dm8GtvD7yFWFowggmgcdNJDcGH+S1Giza5IByWPsGifeR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866454; c=relaxed/simple;
	bh=JZvIP7fkjlxerYAwRuAF9K+xV359GpVBqaDRbE9116Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t6E+sbJZQDYUlunY5R4LJh5PZcBp+mheq/6euZJpCC914G020Oi5AyK0Aw7jGhSFTkEIEADwc/edN7E6jzdOKFCT/DgFIHEEhiouCv8AA1m9sc6Tjpjsdv2A9r43Gdfs5Nw7cnvt9X1OqvNLxAcOdQsygjfSe0GHCB4uCPGPxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=owcwvjZq; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=vBlXl//d/RAlmi+HPxPl7U1cJg4Qh2W+C0TMwykXuCM=; b=owcwvjZqnqwfx97a
	Kg8KkWhv6iQak1OkJCznYE9cXRQagAbfagvCTPVhu0k/xFtifRQCAwTxCzyc0JX3s1VdxwokMcFYD
	bR3QAAkOnKTkD83BkXnR//hCjUIoUS2WM3XmCZ+jHKUav48YvtUpA+KdopFXTFILylGh3UTqEtQhB
	j2P0vUMOzlC+SD7C+Hf7mBUFdk+QgklMen5j5FHteWSK6rmx+UVf5aFPKyVfsaRUSoOJO/NzfP7sT
	fB3Fpl5wi8QwscfO75HM0IA6ml2IqU79PGa1sjMOS6JXIJYGBjNBASAmvO7g4RjBdJndTLj50JrA6
	MVXxtSIJ6z4v/F0mWg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s7bFG-001EoT-0y;
	Thu, 16 May 2024 13:34:06 +0000
From: linux@treblig.org
To: rric@kernel.org,
	bp@alien8.de,
	james.morse@arm.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] edac: thunderx: remove unused struct 'error_syndrome'
Date: Thu, 16 May 2024 14:34:04 +0100
Message-ID: <20240516133404.251397-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'error_syndrome' appears never to have been used.
Remove it, together with the MAX_SYNDROME_REGS it used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/edac/thunderx_edac.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index fab9891e569a..75c04dfc3962 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -35,12 +35,6 @@ enum {
 	ERR_UNKNOWN	= 3,
 };
 
-#define MAX_SYNDROME_REGS 4
-
-struct error_syndrome {
-	u64 reg[MAX_SYNDROME_REGS];
-};
-
 struct error_descr {
 	int	type;
 	u64	mask;
-- 
2.45.0


