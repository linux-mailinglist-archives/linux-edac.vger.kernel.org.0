Return-Path: <linux-edac+bounces-4202-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D057AE30BB
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jun 2025 18:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D699A16BAAF
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jun 2025 16:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C45D8F0;
	Sun, 22 Jun 2025 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7XFUWKR"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B00847B;
	Sun, 22 Jun 2025 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750609191; cv=none; b=obfFtxjamLdB6bMIGB2vbvTU7eP3qvl9LXxRHlt/+ByEUPET3Y4kJ9jj1a2Dux2lX2hlLwtSP9S35PJaoMfuycgSwUj71NCXDu+cQm2yg8JxkpHsus3Bif1dtfPCtuMpsack/NbVClO4TmyiDmWX/9gwsXGjfxyQ7K4sC5OkCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750609191; c=relaxed/simple;
	bh=AQH3st3iMDt/Dh9Fn+GFOSgXYqyTbuK2EAavHHUrYFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgfUAVQdW+0kjNaoA5BS/06JTsNR+ZWqaOgqlKeMlJuaH/cuCasGzbtiK9AibIkAwiUXBYizjKkJKzNx/8I49pKfRe3OUq6SmgzJO6kwGpFXbdndCmZTLKn2kydfpahsZVYoBc24IKAg8Bl7XQ/W5sFJPpaLCxh5TaS23Y6wyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7XFUWKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6100FC4CEE3;
	Sun, 22 Jun 2025 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750609190;
	bh=AQH3st3iMDt/Dh9Fn+GFOSgXYqyTbuK2EAavHHUrYFs=;
	h=From:To:Cc:Subject:Date:From;
	b=E7XFUWKRwebDtxWHbZvYf7MGG/GaxHz6xya6EZGj5VdQwJVSdnqHDLKE6f/8GVKCA
	 B1E/uiva913A5Y4PofiW5Abi+a85rvkRpKucLNXyu4x/Lhone91posvIUfXobQGTL3
	 Fm3B2jd6O069mq44NGrfbww+xAVdog/YZYwKN4E2VdPt+REQMkBaGPAjdxGa4bmzS2
	 pm8wvQ4OgGYFfNVCpLjlTJoGZkdKqXJHGk2+oxIf3cB/U0zlAqcB1hdjS2c6yw8jXb
	 SEm60zzXBpOppEmtLbku+zVQV6jPHBTkvuwIgHTnYLpHYP72eKMyeqDZZNKc/zIPwG
	 Sbn1+TZfjgAFA==
From: Borislav Petkov <bp@kernel.org>
To: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] MAINTAINERS: EDAC: Drop inactive reviewers
Date: Sun, 22 Jun 2025 18:19:43 +0200
Message-ID: <20250622161943.4700-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

I know y'all busy with other stuff and don't have time for EDAC review.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ecb44458a7e..748c0e732da5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8579,9 +8579,6 @@ F:	drivers/edac/thunderx_edac*
 EDAC-CORE
 M:	Borislav Petkov <bp@alien8.de>
 M:	Tony Luck <tony.luck@intel.com>
-R:	James Morse <james.morse@arm.com>
-R:	Mauro Carvalho Chehab <mchehab@kernel.org>
-R:	Robert Richter <rric@kernel.org>
 L:	linux-edac@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
-- 
2.43.0


