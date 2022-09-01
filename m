Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E04A5AA051
	for <lists+linux-edac@lfdr.de>; Thu,  1 Sep 2022 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiIATnd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Sep 2022 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiIATnc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Sep 2022 15:43:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346F09AFB8;
        Thu,  1 Sep 2022 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662061411; x=1693597411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zy92vzhKsP6d5wheJJP6Ba24kfkFA7i7Ka9Ina5Ye9M=;
  b=QVSG+eR5WM7zzxVmtstEyHZj+an1tkQ4bMbX5vx2KM6qMiu4i9zEbEfA
   Kg73Zxevj6un+Eo7bDR1WYO0iSjaCR0+K5Xlg4sC+BL5vRm7Lert1kNSe
   T++ak4WZBH9O6H/wJcvr4eQXTKI1Hei11s1i2vhu6bCuHsw54PQe8hgdG
   0nC8c3XWF5sIe/MfWUVBtrT+Ws4zaJ0kCS0S+Wjl2CTLffrep4yFDlB+1
   RD1FO6zDsbkM72MlP2e+/b4X1aXY55m8mOssjZKEwoAKkV+L7+OVbet+C
   WWdivdsAC+2ImHfrVxZ0Yn0qQkfCrMDpU45mN0tX4U8EjEXQmLXVJ1sNb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295821696"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="295821696"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:43:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="674020253"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:43:20 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 2/3] EDAC/skx_common: Make output format similar
Date:   Thu,  1 Sep 2022 12:43:09 -0700
Message-Id: <20220901194310.115427-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901194310.115427-1-tony.luck@intel.com>
References: <20220901194310.115427-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The decoded output format of driver decoder is different from the
output format of firmware decoder. Make output format similar regardless
of decode function (Align driver decoder's to firmware decoder's).

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/skx_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 9b10c359849b..16ca3de57c24 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -600,12 +600,12 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 			 mscod, errcode, adxl_msg);
 	} else {
 		len = snprintf(skx_msg, MSG_SIZE,
-			 "%s%s err_code:0x%04x:0x%04x socket:%d imc:%d rank:%d bg:%d ba:%d row:0x%x col:0x%x",
+			 "%s%s err_code:0x%04x:0x%04x ProcessorSocketId:0x%x MemoryControllerId:0x%x PhysicalRankId:0x%x Row:0x%x Column:0x%x Bank:0x%x BankGroup:0x%x",
 			 overflow ? " OVERFLOW" : "",
 			 (uncorrected_error && recoverable) ? " recoverable" : "",
 			 mscod, errcode,
 			 res->socket, res->imc, res->rank,
-			 res->bank_group, res->bank_address, res->row, res->column);
+			 res->row, res->column, res->bank_address, res->bank_group);
 	}
 
 	if (skx_show_retry_rd_err_log)
-- 
2.37.1

