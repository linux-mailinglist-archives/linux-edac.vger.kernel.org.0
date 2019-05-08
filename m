Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E34018254
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 00:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfEHWmG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 May 2019 18:42:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54410 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfEHWmG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 8 May 2019 18:42:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hOVGD-0001vy-DE; Wed, 08 May 2019 22:42:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC, sb_edac: remove redundant update of tad_base
Date:   Wed,  8 May 2019 23:42:01 +0100
Message-Id: <20190508224201.27120-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable tad_base is being set to a value that is never read
and is being over-written on the next iteration of a for-loop.
This assignment is therefore redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/edac/sb_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 9353c3fc7c05..6aa4b1b73a15 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1513,7 +1513,6 @@ static int knl_get_dimm_capacity(struct sbridge_pvt *pvt, u64 *mc_sizes)
 						sad_actual_size[mc] += tad_size;
 					}
 				}
-				tad_base = tad_limit+1;
 			}
 		}
 
-- 
2.20.1

