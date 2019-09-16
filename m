Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 721AAB375E
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2019 11:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfIPJod convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 16 Sep 2019 05:44:33 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:11818 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729400AbfIPJod (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Sep 2019 05:44:33 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 16 Sep
 2019 17:44:28 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 16 Sep
 2019 17:44:27 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Mon, 16 Sep 2019 17:44:27 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "Borislav Petkov (bp@alien8.de)" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v3 2/4] x86/mce: Make 3 functions non-static
Thread-Topic: [PATCH v3 2/4] x86/mce: Make 3 functions non-static
Thread-Index: AdVsbNK9Ze8Vv2u/TlS+IY5QKGD9vg==
Date:   Mon, 16 Sep 2019 09:44:27 +0000
Message-ID: <966609ae83b947b998a85cd2fcc1f304@zhaoxin.com>
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

On Mon, Sep 16, 2019, Thomas Gleixner wrote:
>On Wed, 11 Sep 2019, Tony W Wang-oc wrote:
>
>> These functions are declared static and cannot be used in others
>> .c source file. this commit removes the static attribute and adds
>> the declaration to the header for these functions.
>
>I'm not Cc'ed on any patches which use those functions. Please Cc the
>relevant maintainers on all patches of such a patch series so contect can
>be seen.
>

Patches 3/4, 4/4 in this patchsets are using these functions. Specifically, 
"[PATCH v3 3/4] x86/mce: Add Zhaoxin CMCI support " in this patchsets is
using intel_init_cmci(), "[PATCH v3 4/4] x86/mce: Add Zhaoxin LMCE support"
is using intel_init_lmce() and intel_clear_lmce().

I had sent all patches in this patchsets to your mailbox. Could you help to
check again? Thank you.

>Also adding some hint to the change log which new code will use that would
>be appreciated.

Got it, will add in next version.

Sincerely
TonyWWang-oc
