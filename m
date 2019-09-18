Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B87B5BC4
	for <lists+linux-edac@lfdr.de>; Wed, 18 Sep 2019 08:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfIRGTn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Sep 2019 02:19:43 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:39983 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725842AbfIRGTm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Sep 2019 02:19:42 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 18 Sep
 2019 14:19:38 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.46) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 18 Sep
 2019 14:19:36 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yazen.ghannam@amd.com>, <vishal.l.verma@intel.com>,
        <qiuxu.zhuo@intel.com>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH v4 0/4] x86/mce: Add supports for Zhaoxin MCA
Date:   Wed, 18 Sep 2019 14:19:29 +0800
Message-ID: <1568787573-1297-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.46]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Zhaoxin newer CPUs support MCE, CMCI and LMCE that compatible with
Intel's "Machine-Check Architecture".

To enable the supports of Linux kernel to Zhaoxin's MCA, add
specific patches for Zhaoxin's MCE, CMCI and LMCE. patches about
Zhaoxin's CMCI, LMCE use 3 functions in mce/intel.c, so make these
functions non-static.

Some Zhaoxin's CPUs have MCA bank 8, that only has one error called SVAD
(System View Address Decoder) which be controlled by IA32_MC8.CTL.0.
If enabled, the prefetch on these CPUs will cause SVAD machine check
exception when virtual machine startup and cause system panic. Add a
quirk for these Zhaoxin CPUs MCA bank 8.

v3->v4:
 - remove redundant if-case test (patch 4/4)

v2->v3:
 - Make ifelse-case to switch-case (patch 1/4)
 - Simplify Zhaoxin CPU FMS checking (patch 1/4, 3/4)
 - Revert 1 unused function intel_ppin_init() (patch 2/4)
 - Rework mce_zhaoxin_feature_init() as static (patch 3/4)
 - Rework comment about Zhaoxin MCA SVAD and CMCI (patch 3/4)
 - Rework mce_zhaoxin_feature_clear() as static (patch 4/4)
 - Add comment and change coding style (patch 4/4)

v1->v2:
 - Fix redefinition of "mce_zhaoxin_feature_init" (patch 3/4)
 - Fix redefinition of "mce_zhaoxin_feature_clear" (patch 4/4)

Tony W Wang-oc (4):
  x86/mce: Add Zhaoxin MCE support
  x86/mce: Make 3 functions non-static
  x86/mce: Add Zhaoxin CMCI support
  x86/mce: Add Zhaoxin LMCE support

 arch/x86/kernel/cpu/mce/core.c     | 83 ++++++++++++++++++++++++++++++++------
 arch/x86/kernel/cpu/mce/intel.c    | 11 +++--
 arch/x86/kernel/cpu/mce/internal.h |  6 +++
 3 files changed, 84 insertions(+), 16 deletions(-)

-- 
2.7.4

