Return-Path: <linux-edac+bounces-4-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DF7E466A
	for <lists+linux-edac@lfdr.de>; Tue,  7 Nov 2023 17:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DD41C20A65
	for <lists+linux-edac@lfdr.de>; Tue,  7 Nov 2023 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC177315BC;
	Tue,  7 Nov 2023 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UyvKFRK2"
X-Original-To: linux-edac@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0B1C684
	for <linux-edac@vger.kernel.org>; Tue,  7 Nov 2023 16:55:35 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B0693;
	Tue,  7 Nov 2023 08:55:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 434CC1F37C;
	Tue,  7 Nov 2023 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699376133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8YR5IGNzGB11lqau+yV+L6ykZhJX5tp/evzkhWrEHQk=;
	b=UyvKFRK2tBb95knrq8Oe+GkLZujLkjmbW2yLtFKf3/4cx65dyc3yWLdWDOIIo76wEZ2VuX
	3DS42Kma4cdafZJxNH/NM7sjKQYgZ3mWCp2GppuYmKLmfTnnVVvlGOTzs8lZllvorIcCxT
	U78DUmg41RgGMTT7KTAKly4UirgYjx8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1658132FD;
	Tue,  7 Nov 2023 16:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id y2KmNARsSmUURwAAMHmgww
	(envelope-from <nik.borisov@suse.com>); Tue, 07 Nov 2023 16:55:32 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: bp@alien8.de
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/mce: Remove redundant check from  mce_device_create()
Date: Tue,  7 Nov 2023 18:55:29 +0200
Message-Id: <20231107165529.407349-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mce_device_create() is called only from mce_cpu_online() which in turn
will be called iff mce is available. That is, at the time of
mce_device_create() call it's guaranteed that mce is available. No need
to duplicate this check so let's remove it.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/mce/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7b397370b4d6..71999f97a3c8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2568,9 +2568,6 @@ static int mce_device_create(unsigned int cpu)
 	int err;
 	int i, j;
 
-	if (!mce_available(&boot_cpu_data))
-		return -EIO;
-
 	dev = per_cpu(mce_device, cpu);
 	if (dev)
 		return 0;
-- 
2.34.1


