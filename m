Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41AEB397B
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2019 13:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfIPLf4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 16 Sep 2019 07:35:56 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:30536 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731365AbfIPLfz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Sep 2019 07:35:55 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 16 Sep
 2019 19:35:51 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 16 Sep
 2019 19:35:50 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Mon, 16 Sep 2019 19:35:50 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "Borislav Petkov (bp@alien8.de)" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>
CC:     David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: [PATCH v3 0/4] x86/mce: Add supports for Zhaoxin MCA
Thread-Topic: [PATCH v3 0/4] x86/mce: Add supports for Zhaoxin MCA
Thread-Index: AdVsghaYSu2N9NgNSwS4zHAPRb3wjg==
Date:   Mon, 16 Sep 2019 11:35:50 +0000
Message-ID: <a26cd9adb0b74b838c30ff9299de9932@zhaoxin.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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

TonyWWang-oc(4):
 x86/mce: Add Zhaoxin MCE support
 x86/mce: Make 3 functions non-static
 x86/mce: Add Zhaoxin CMCI support
 x86/mce: Add Zhaoxin LMCE support

 arch/x86/kernel/cpu/mce/core.c     | 98 +++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/mce/intel.c    | 11 +++--
 arch/x86/kernel/cpu/mce/internal.h |  6 +++
 3 files changed, 99 insertions(+), 16 deletions(-)

-- 
2.7.4
