Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943C85AA04D
	for <lists+linux-edac@lfdr.de>; Thu,  1 Sep 2022 21:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiIATn3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Sep 2022 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiIATn2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Sep 2022 15:43:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763A05A3DB;
        Thu,  1 Sep 2022 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662061407; x=1693597407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pcVzr7tYohFd78StOkXJ4fl2PO+pFHjQpd6/c1NYsSE=;
  b=exMmGKK2hTBX+2LD8tY0x3uaB2utub+J2aCHXmazSuAtROiv/X7XTp5w
   Q1pUjQwb0XmcKUbiy6HEXf83L68zmFRAxqNuajUrL8ijQZztMxFWplgRy
   Zo5rqDR47IzX2ueCnUPBTo+u/D9szmhsKGfgNzcjdKA1BdxwTDUNVi+Z+
   IcFxmaGbPWqD/1Lja83m5O3gga2G61rvHNejdjwh/wyxq2IHpNzORThAD
   uaVQpNB1aBbr4YOuLlj9Gm5afTe45/3CtJdWaOBVI4h06c3hOXsC9PzBC
   F2juYXvU5Df0C2g4Ns1jZgPG0HEsTbmpSiIPssuctU8m7dZlHSLPhXEuC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="278830152"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="278830152"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:43:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="674020246"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:43:20 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 0/3] EDAC: Improve memory address decoding for i10nm driver
Date:   Thu,  1 Sep 2022 12:43:07 -0700
Message-Id: <20220901194310.115427-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Calling firmware to translate memory addresses has a high impact
on system because the call uses SMI.

The 10nm server processors (Icelake and Tremont) provide additional
information in the IA32_MCi_MISC registers that can be used to decode
the address of an error in DDR memory.

Couple of prep patches before the main event in part 3 that decodes
the address from the MISC register.

Qiuxu Zhuo (2):
  EDAC/skx_common: Use driver decoder first
  EDAC/skx_common: Make output format similar

Youquan Song (1):
  EDAC/i10nm: Add driver decoder for Ice Lake and Tremont CPUs

 arch/x86/include/asm/mce.h |   1 +
 drivers/edac/skx_common.h  |   6 ++
 drivers/edac/i10nm_base.c  | 134 ++++++++++++++++++++++++++++++++++++-
 drivers/edac/skx_base.c    |   9 ++-
 drivers/edac/skx_common.c  |  21 +++---
 5 files changed, 158 insertions(+), 13 deletions(-)


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.37.1

