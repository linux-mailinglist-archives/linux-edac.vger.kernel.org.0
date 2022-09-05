Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85B15AD669
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbiIEP1F (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbiIEP0B (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 11:26:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FFC11AD83;
        Mon,  5 Sep 2022 08:26:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 213AFED1;
        Mon,  5 Sep 2022 08:26:06 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (unknown [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 628373F534;
        Mon,  5 Sep 2022 08:25:53 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Jia He <justin.he@arm.com>
Subject: [PATCH v5 8/8] EDAC/igen6: Return consistent errno when another edac driver is enabled
Date:   Mon,  5 Sep 2022 15:24:39 +0000
Message-Id: <20220905152439.77770-9-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905152439.77770-1-justin.he@arm.com>
References: <20220905152439.77770-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Only a single edac driver can be enabled for EDAC MC. The igen6_init()
should be returned with EBUSY instead of ENODEV, which is consistent with
other edac drivers.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/edac/igen6_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 4ac6d0c533ec..4646cb72b9f8 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1276,7 +1276,7 @@ static int __init igen6_init(void)
 
 	owner = edac_get_owner();
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
-		return -ENODEV;
+		return -EBUSY;
 
 	edac_op_state = EDAC_OPSTATE_NMI;
 
-- 
2.25.1

