Return-Path: <linux-edac+bounces-3261-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE62A4E18B
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 15:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AA13A4213
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA1E2777FA;
	Tue,  4 Mar 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud6yEq5m"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB5277035;
	Tue,  4 Mar 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098968; cv=none; b=qCEjPBCn4d+9riKqD9aB9TYzoAoRCOVu8KOY/IFmzGUl7CoMp/1HIHc/27Lrzc3PXUzFC/+2VwZOz72971NVh/Zd3iNHb7TPnWtwTAB8UXmFp+CwBbcJ4qIGOLntMerxhBWGCJCisHKd7l7gMB6CxThBTi6+bYp5oivWCgluMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098968; c=relaxed/simple;
	bh=cxAHcKn3pjMzcqMsPbIcMtnWuN6ttXQC0+V/fkbmKvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KhD8/dw6HFmoxWRDeEHNRKGwIN47AX+nDfU+I/CDWXghPFODtGoiDFfg8fi/oWM9wAvdoPr3WJ+MQvle1z4mp7BsrogCBjkIOGU4TUluScdmRGJCTkEPox9u2l8s9GsGjh/93AS+1iUV8C064q9k0xSh8iP/wCYt08a0vgeMV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud6yEq5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A992CC4CEE5;
	Tue,  4 Mar 2025 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098968;
	bh=cxAHcKn3pjMzcqMsPbIcMtnWuN6ttXQC0+V/fkbmKvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Ud6yEq5mfVrYRwCmVwBJFAvYm8IltOAiJpTsxkTEiOYRE+uWDkrMs2RfI0KWQ8wrc
	 UNeiBIlohenNoHU8xHMU+Uvt/LspNi8+jZ1L8UfV6QlYxKT8b50fh2xneXHSkITqqT
	 5cfw612VG2efzL1hKWtdJZi/mA8fbyw6kw0hW6jFQegx9t7dANi2rwH/+wuBjcxj1Z
	 dIbb7KW3MX2kstip183XraPRL1iuWnzUx2reYHpYWeiD9oz10/JeYUx5OSJ8p/Upg6
	 arFUETT1VglWZkDDGtdeJEFN7kj4t7OwoZdo3ORAqq19eVuOIO/uNLJl8wUUOzHbME
	 xferlzQb5QSPg==
From: Arnd Bergmann <arnd@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: fix dev_set_name() format string
Date: Tue,  4 Mar 2025 15:35:58 +0100
Message-Id: <20250304143603.995820-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Passing a variable string as the format to dev_set_name() causes a W=1 warning:

drivers/edac/edac_device.c:736:9: error: format not a string literal and no format arguments [-Werror=format-security]
  736 |         ret = dev_set_name(&ctx->dev, name);
      |         ^~~

Use a literal "%s" instead so the name can be the argument.

Fixes: db99ea5f2c03 ("EDAC: Add support for EDAC device features control")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/edac_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 16611515ab34..0734909b08a4 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -733,7 +733,7 @@ int edac_dev_register(struct device *parent, char *name,
 	ctx->private = private;
 	dev_set_drvdata(&ctx->dev, ctx);
 
-	ret = dev_set_name(&ctx->dev, name);
+	ret = dev_set_name(&ctx->dev, "%s", name);
 	if (ret)
 		goto data_mem_free;
 
-- 
2.39.5


