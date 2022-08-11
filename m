Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029158F9E5
	for <lists+linux-edac@lfdr.de>; Thu, 11 Aug 2022 11:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiHKJRf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Aug 2022 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiHKJRe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Aug 2022 05:17:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DC70915EB;
        Thu, 11 Aug 2022 02:17:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A56D21424;
        Thu, 11 Aug 2022 02:17:33 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (unknown [10.169.212.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C64F3F70D;
        Thu, 11 Aug 2022 02:17:27 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, toshi.kani@hpe.com, Jia He <justin.he@arm.com>
Subject: [PATCH 1/2] efi/cper: export several helpers for ghes edac to use
Date:   Thu, 11 Aug 2022 09:17:12 +0000
Message-Id: <20220811091713.10427-2-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811091713.10427-1-justin.he@arm.com>
References: <20220811091713.10427-1-justin.he@arm.com>
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

Before modularizing the ghes_edac codes, we need to export several efi/cper
helpers to avoid linking error of ghes_edac.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index e4e5ea7ce910..053eae13f409 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -290,6 +290,7 @@ int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 
 	return n;
 }
+EXPORT_SYMBOL_GPL(cper_mem_err_location);
 
 int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 {
@@ -310,6 +311,7 @@ int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 
 	return n;
 }
+EXPORT_SYMBOL_GPL(cper_dimm_err_location);
 
 void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 		       struct cper_mem_err_compact *cmem)
@@ -331,6 +333,7 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 	cmem->mem_array_handle = mem->mem_array_handle;
 	cmem->mem_dev_handle = mem->mem_dev_handle;
 }
+EXPORT_SYMBOL_GPL(cper_mem_err_pack);
 
 const char *cper_mem_err_unpack(struct trace_seq *p,
 				struct cper_mem_err_compact *cmem)
-- 
2.25.1

