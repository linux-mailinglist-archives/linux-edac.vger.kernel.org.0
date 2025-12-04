Return-Path: <linux-edac+bounces-5546-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA1FCA3223
	for <lists+linux-edac@lfdr.de>; Thu, 04 Dec 2025 11:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4817130292DA
	for <lists+linux-edac@lfdr.de>; Thu,  4 Dec 2025 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36DA3370E1;
	Thu,  4 Dec 2025 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHGEHjY2"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F23346AD;
	Thu,  4 Dec 2025 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842557; cv=none; b=cBeeGbbTAxHz0Js5h4eYGbpmeDhXbZApfwo4yIZ7YOcod+zYaZEeWD9N2TJK4vQmM5DCtiOpQgqeyBgeXUcSIyFRABv2hH3Pw87jxMjDrLPyutlWgrvlQwYxvJ4WzfwAfPRr88HbVrSlP7AELv4/YK0oxBBRRFNf/2RzotlW9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842557; c=relaxed/simple;
	bh=6cUf5UOmWErT1HGnRGoJHnzJMfl3CWtlAGZOcn5Mbes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0KZqog1nM7t6+vTtoGgEjA2k+uqXlpes/fsuSkWLMMuGBKWf5xn6iEL/henhOMvr24qsIMPSC2AhpIL92TNi3fU9dySXA3vVZVOWb+X2RZ7mTXKr5MCmQ+sz7veBX2u4u0huXl0uIIv9CKuGhvfCiovRQYI2dnkKOpswkOdOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHGEHjY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44112C113D0;
	Thu,  4 Dec 2025 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764842557;
	bh=6cUf5UOmWErT1HGnRGoJHnzJMfl3CWtlAGZOcn5Mbes=;
	h=From:To:Cc:Subject:Date:From;
	b=lHGEHjY2jijL6ldAKwdp+CKnb2FfWbqIDUBltQzWleMwrXmXBMH1bpZzGNqsk1RTx
	 wljfQVgZMRuE4sSw7TVDqM+ZPL8mknHbJlxBDneikBIoiL95PDKURHzqGSS+5iPply
	 TQU5whgob2rJL/Iw5BSQ3e1cgAyRbqhwZppjW1pxGFzlCs3vgX+UGdLughYWHN5i+G
	 Kd1j+QiJ8bTV79PZY/wPOajpVAGk7P/3NAHnwo9m4N6gOawPSYipAcmBXttHJ1IBLs
	 ZHe4rG6ofDC3tNOul/0mW4lWs6NRec+YKpQsxJZKkKJjA5a+BsyMwopv42xCbrBQod
	 hCDttwyqtfU8A==
From: Arnd Bergmann <arnd@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/amd64: avoid -Wformat-security warning
Date: Thu,  4 Dec 2025 11:02:25 +0100
Message-Id: <20251204100231.1034557-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Using a variable as a format string causes a (default-disabled) warning:

drivers/edac/amd64_edac.c: In function 'per_family_init':
drivers/edac/amd64_edac.c:3914:17: error: format not a string literal and no format arguments [-Werror=format-security]
 3914 |                 scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), tmp_name);
      |                 ^~~~~~~~~

The code here is safe, but in order to enable the warning by default in
the future, change this instance to pass the name indirectly.

Fixes: e9abd990aefd ("EDAC/amd64: Generate ctl_name string at runtime")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2391f3469961..63fca0ee2c23 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3911,7 +3911,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 	}
 
 	if (tmp_name)
-		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), tmp_name);
+		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "%s", tmp_name);
 	else
 		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
 			  pvt->fam, pvt->model);
-- 
2.39.5


