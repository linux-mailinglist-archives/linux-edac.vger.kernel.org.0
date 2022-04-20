Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1674A509116
	for <lists+linux-edac@lfdr.de>; Wed, 20 Apr 2022 22:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381976AbiDTUK3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Apr 2022 16:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381936AbiDTUK2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Apr 2022 16:10:28 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F6045AED;
        Wed, 20 Apr 2022 13:07:41 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23K9EiFp030296;
        Wed, 20 Apr 2022 13:07:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=qC2ZktjidKj+/UlljeyBNuul/oLAKa3ekjEB28eOfes=;
 b=ETy7mKHqJbryWtyLlVpQtt6BOzTHg9GMo7AD36eQhegWUi2qvSVRwJu552mt46dwvu34
 u6Dll0N/wbmI1mptYGKMhNRQiJHSckhubW7UhF6+mYmtm8q28GzTg8V9hE/Ze6ycQml3
 5Nka9UwT0i6emsypljMPwXfFFW970eOkWbDyCAMdfWpC7+vZPTHY6L6kK9gQOL6p+qsr
 oqbqRKYAwfau0qv6wX9AxsMw4fb3dEoAmRxsGk9b7tN0a3FuvLgB0Q3T62YP+MVzHw4F
 Qh58UrOqP8XWoEkuXV3KPkOlrBUVYe0ky4A9EjQqBWA0OOnWCWFoe9ASo874xOQFtgCU NQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3fjfcgaakn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 13:07:12 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Apr
 2022 13:07:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Apr 2022 13:07:11 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id ECDF83F707A;
        Wed, 20 Apr 2022 13:07:10 -0700 (PDT)
From:   Vasyl Gomonovych <vgomonovych@marvell.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <vgomonovych@marvell.com>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC: Init minimum possible error desc grain
Date:   Wed, 20 Apr 2022 13:07:08 -0700
Message-ID: <20220420200708.29921-1-vgomonovych@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gdGnoRDw2Dwm6MTH2NQxYBNvsaHxDwUv
X-Proofpoint-GUID: gdGnoRDw2Dwm6MTH2NQxYBNvsaHxDwUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_05,2022-04-20_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Initialize the raw error descriptor after
zeroing to a minimum possible value 1.
It is safe for DIMM and not DIMM-based
systems and does not provide a useless
verification print.

Signed-off-by: Vasyl Gomonovych <vgomonovych@marvell.com>
---
 drivers/edac/edac_mc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index d2715774af6fb3a0b07ff2c6ce6bb510091c0a68..a985f9a0b89b466934d1c167bdb243687fbfd093 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -990,10 +990,6 @@ void edac_raw_mc_handle_error(struct edac_raw_error_desc *e)
 	struct mem_ctl_info *mci = error_desc_to_mci(e);
 	u8 grain_bits;
 
-	/* Sanity-check driver-supplied grain value. */
-	if (WARN_ON_ONCE(!e->grain))
-		e->grain = 1;
-
 	grain_bits = fls_long(e->grain - 1);
 
 	/* Report the error via the trace interface */
@@ -1047,6 +1043,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
 	/* need valid strings here for both: */
 	e->msg = msg ?: "";
 	e->other_detail = other_detail ?: "";
+	e->grain = 1;
 
 	/*
 	 * Check if the event report is consistent and if the memory location is
-- 
2.17.1

