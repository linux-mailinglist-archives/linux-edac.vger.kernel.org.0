Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D732988F3
	for <lists+linux-edac@lfdr.de>; Mon, 26 Oct 2020 10:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770346AbgJZJAW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Oct 2020 05:00:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2648 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771082AbgJZJAW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Oct 2020 05:00:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CKTLx3YrVzLntg;
        Mon, 26 Oct 2020 17:00:25 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 26 Oct 2020
 17:00:19 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <bp@alien8.de>, <james.morse@arm.com>, <rric@kernel.org>
CC:     <mchehab@kernel.org>, <tony.luck@intel.com>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH -next] EDAC/amd64: Discard unnecessary break
Date:   Mon, 26 Oct 2020 17:11:03 +0800
Message-ID: <20201026091103.67780-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A 'break' is unnecessary because of previous 'return'.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/edac/amd64_edac.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1362274d840b..a1c9e68b35d9 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2461,14 +2461,11 @@ static int map_err_sym_to_channel(int err_sym, int sym_size)
 		case 0x20:
 		case 0x21:
 			return 0;
-			break;
 		case 0x22:
 		case 0x23:
 			return 1;
-			break;
 		default:
 			return err_sym >> 4;
-			break;
 		}
 	/* x8 symbols */
 	else
@@ -2478,17 +2475,13 @@ static int map_err_sym_to_channel(int err_sym, int sym_size)
 			WARN(1, KERN_ERR "Invalid error symbol: 0x%x\n",
 					  err_sym);
 			return -1;
-			break;
 
 		case 0x11:
 			return 0;
-			break;
 		case 0x12:
 			return 1;
-			break;
 		default:
 			return err_sym >> 3;
-			break;
 		}
 	return -1;
 }
-- 
2.17.1

