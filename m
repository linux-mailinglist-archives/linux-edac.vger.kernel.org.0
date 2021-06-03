Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337B8399F04
	for <lists+linux-edac@lfdr.de>; Thu,  3 Jun 2021 12:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFCKfj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Jun 2021 06:35:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34023 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFCKfj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 3 Jun 2021 06:35:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lokfd-0007e4-Cd; Thu, 03 Jun 2021 10:33:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] EDAC/mce_amd: Fix typo "FIfo" -> "Fifo"
Date:   Thu,  3 Jun 2021 11:33:49 +0100
Message-Id: <20210603103349.79117-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an uppercase letter I in the text instead of a lowercase
one. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/edac/mce_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 43ba0f931629..27d56920b469 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -431,7 +431,7 @@ static const char * const smca_xgmipcs_mce_desc[] = {
 	"Replay Buffer Parity Error",
 	"Data Parity Error",
 	"Replay Fifo Overflow Error",
-	"Replay FIfo Underflow Error",
+	"Replay Fifo Underflow Error",
 	"Elastic Fifo Overflow Error",
 	"Deskew Error",
 	"Flow Control CRC Error",
-- 
2.31.1

