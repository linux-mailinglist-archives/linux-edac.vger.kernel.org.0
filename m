Return-Path: <linux-edac+bounces-75-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B327F534B
	for <lists+linux-edac@lfdr.de>; Wed, 22 Nov 2023 23:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B558BB20C64
	for <lists+linux-edac@lfdr.de>; Wed, 22 Nov 2023 22:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A3A200AE;
	Wed, 22 Nov 2023 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooPGsOvL"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BF1C2AD
	for <linux-edac@vger.kernel.org>; Wed, 22 Nov 2023 22:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B4DC433C7;
	Wed, 22 Nov 2023 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700691615;
	bh=u13b0z+tp/dZxRqpZv9t59kmK5DC5BMUsS/pUkeI2qs=;
	h=From:To:Cc:Subject:Date:From;
	b=ooPGsOvLIdQyfEAMzxU5AUDDT2dgbuOSg46vaCSzFAnxa36wUIPVF3WtkoXNnAeaN
	 YdoU6LZdkYxhfbvjtcuLhNyWwoXytZde9SwDNdY1Tl4jmbeB43qZphfgSByJsUxg6F
	 P42dILUa3xainFiGGpmMZiLsPLcEDJtYXJ/ilM2uH10l75uTYay6fTgHXEInAIBAG4
	 xl/J2Gkfb9/Y4GskeTffJXv++AReoFw1IqyLIHEbuV3K3MIzH0TePiOljvcS0wZRrY
	 uZ5v8zD7ziuBZelAzr6Xo3tqZ+1c5uFG/k5FHGSkkUSoF0lVfVgTQYw4reqGMKmeoV
	 vdRr0+LrX7NVA==
From: Arnd Bergmann <arnd@kernel.org>
To: Robert Richter <rric@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Sergey Temerkhanov <s.temerkhanov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Yeqi Fu <asuk4.q@gmail.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
Date: Wed, 22 Nov 2023 23:19:53 +0100
Message-Id: <20231122222007.3199885-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Commit 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally") exposes a
warning for a common bug in the usage of strncat():

drivers/edac/thunderx_edac.c: In function 'thunderx_ocx_com_threaded_isr':
drivers/edac/thunderx_edac.c:1136:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
 1136 |                 strncat(msg, other, OCX_MESSAGE_SIZE);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/edac/thunderx_edac.c:1145:33: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
 1145 |                                 strncat(msg, other, OCX_MESSAGE_SIZE);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/edac/thunderx_edac.c:1150:33: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
 1150 |                                 strncat(msg, other, OCX_MESSAGE_SIZE);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/edac/thunderx_edac.c: In function 'thunderx_l2c_threaded_isr':
drivers/edac/thunderx_edac.c:1899:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
 1899 |                 strncat(msg, other, L2C_MESSAGE_SIZE);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/edac/thunderx_edac.c: In function 'thunderx_ocx_lnk_threaded_isr':
drivers/edac/thunderx_edac.c:1220:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
 1220 |                 strncat(msg, other, OCX_MESSAGE_SIZE);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Apparently the author of this driver expected strncat() to behave the
way that strlcat() does, which uses the size of the destination buffer
as its third argument rather than the length of the source buffer.
The result is that there is no check on the size of the allocated
buffer.

Change it to use strncat().

Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/thunderx_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index b9c5772da959..90d46e5c4ff0 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1133,7 +1133,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_errors, ctx->reg_com_int);
 
-		strncat(msg, other, OCX_MESSAGE_SIZE);
+		strlcat(msg, other, OCX_MESSAGE_SIZE);
 
 		for (lane = 0; lane < OCX_RX_LANES; lane++)
 			if (ctx->reg_com_int & BIT(lane)) {
@@ -1142,12 +1142,12 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 					 lane, ctx->reg_lane_int[lane],
 					 lane, ctx->reg_lane_stat11[lane]);
 
-				strncat(msg, other, OCX_MESSAGE_SIZE);
+				strlcat(msg, other, OCX_MESSAGE_SIZE);
 
 				decode_register(other, OCX_OTHER_SIZE,
 						ocx_lane_errors,
 						ctx->reg_lane_int[lane]);
-				strncat(msg, other, OCX_MESSAGE_SIZE);
+				strlcat(msg, other, OCX_MESSAGE_SIZE);
 			}
 
 		if (ctx->reg_com_int & OCX_COM_INT_CE)
@@ -1217,7 +1217,7 @@ static irqreturn_t thunderx_ocx_lnk_threaded_isr(int irq, void *irq_id)
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_link_errors, ctx->reg_com_link_int);
 
-		strncat(msg, other, OCX_MESSAGE_SIZE);
+		strlcat(msg, other, OCX_MESSAGE_SIZE);
 
 		if (ctx->reg_com_link_int & OCX_COM_LINK_INT_UE)
 			edac_device_handle_ue(ocx->edac_dev, 0, 0, msg);
@@ -1896,7 +1896,7 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq, void *irq_id)
 
 		decode_register(other, L2C_OTHER_SIZE, l2_errors, ctx->reg_int);
 
-		strncat(msg, other, L2C_MESSAGE_SIZE);
+		strlcat(msg, other, L2C_MESSAGE_SIZE);
 
 		if (ctx->reg_int & mask_ue)
 			edac_device_handle_ue(l2c->edac_dev, 0, 0, msg);
-- 
2.39.2


