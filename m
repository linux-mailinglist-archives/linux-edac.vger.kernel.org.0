Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F69348564
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2019 16:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfFQO3l (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jun 2019 10:29:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfFQO3l (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Jun 2019 10:29:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 22F0B19BA13493ADD92C;
        Mon, 17 Jun 2019 22:29:39 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.53) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 22:29:28 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linuxarm@huawei.com>
CC:     Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 2/6] rasdaemon: rearrange HiSilicon HIP07 decoding function table
Date:   Mon, 17 Jun 2019 15:28:48 +0100
Message-ID: <20190617142852.12140-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190617142852.12140-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20190617142852.12140-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.53]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch rearranges the decoding function table for the
HiSilicon HIP07 non-standard errors.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisi_hip07.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/non-standard-hisi_hip07.c b/non-standard-hisi_hip07.c
index 3e9dabd..19a5c47 100644
--- a/non-standard-hisi_hip07.c
+++ b/non-standard-hisi_hip07.c
@@ -24,20 +24,6 @@
 #define HISI_SAS_VALID_ERR_TYPE       BIT(2)
 #define HISI_SAS_VALID_AXI_ERR_INFO   BIT(3)
 
-static int decode_hip07_sas_error(struct trace_seq *s, const void *error);
-static int decode_hip07_hns_error(struct trace_seq *s, const void *error);
-
-struct ras_ns_dec_tab hisi_ns_dec_tab[] = {
-	{
-		.sec_type = "daffd8146eba4d8c8a91bc9bbf4aa301",
-		.decode = decode_hip07_sas_error,
-	},
-	{
-		.sec_type = "fbc2d923ea7a453dab132949f5af9e53",
-		.decode = decode_hip07_hns_error,
-	},
-};
-
 struct hisi_sas_err_sec {
 	uint64_t   val_bits;
 	uint64_t   physical_addr;
@@ -138,6 +124,18 @@ static int decode_hip07_hns_error(struct trace_seq *s, const void *error)
 {
 	return 0;
 }
+
+struct ras_ns_dec_tab hisi_ns_dec_tab[] = {
+	{
+		.sec_type = "daffd8146eba4d8c8a91bc9bbf4aa301",
+		.decode = decode_hip07_sas_error,
+	},
+	{
+		.sec_type = "fbc2d923ea7a453dab132949f5af9e53",
+		.decode = decode_hip07_hns_error,
+	},
+};
+
 __attribute__((constructor))
 static void hip07_init(void)
 {
-- 
1.9.1


