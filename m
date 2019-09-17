Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19ABDB47B9
	for <lists+linux-edac@lfdr.de>; Tue, 17 Sep 2019 08:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404375AbfIQGyM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 17 Sep 2019 02:54:12 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:17740 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404356AbfIQGyL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Sep 2019 02:54:11 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 17 Sep
 2019 14:54:06 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 17 Sep
 2019 14:54:05 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Tue, 17 Sep 2019 14:54:05 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Borislav Petkov (bp@alien8.de)" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
Subject: Re: [PATCH v3 4/4] x86/mce: Add Zhaoxin LMCE support
Thread-Topic: [PATCH v3 4/4] x86/mce: Add Zhaoxin LMCE support
Thread-Index: AdVtHDOle8Db4pQYQzu7i2JkrbUxgA==
Date:   Tue, 17 Sep 2019 06:54:05 +0000
Message-ID: <1da27840413348febf301ef39305de12@zhaoxin.com>
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

On Mon, Sep 16, 2019, Luck, Tony wrote:
>On Mon, Sep 16, 2019 at 11:37:18AM +0000, Tony W Wang-oc wrote:
>> Zhaoxin newer CPUs support LMCE that compatible with Intel's
>> "Machine-Check Architecture", so add support for Zhaoxin LMCE
>> in mce/core.c.
>>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> ---
>>  arch/x86/kernel/cpu/mce/core.c | 35
>+++++++++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 65c5a1f..acdd76b 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1132,6 +1132,27 @@ static bool __mc_check_crashing_cpu(int cpu)
>>  		u64 mcgstatus;
>>
>>  		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
>> +
>> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
>> +			if (mcgstatus & MCG_STATUS_LMCES)
>> +				return false;
>> +
>> +			if (!(mcgstatus & MCG_STATUS_LMCES)) {
>
>Don't really need this test ... you already did "return false" if
>the LMCES bit was set ... so this test is redundant (and you can avoid
>indenting the next dozen lines.

Got it, Thank you.

But have a question about below codes:
	if (mcgstatus & MCG_STATUS_RIPV) {
		mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
		return true;
	}
These seems require all #MC exception errors set MCG_STATUS_RIPV = 1
in order to skip synchronize which "return true;" actually does for this.

As Intel SDM show, "Recoverable-not-continuable SRAR Type" errors may
set MCG_STATUS_RIPV = 0, PCC = 0. When these #MC errors broadcast
to offline CPU, may cause kernel panic with synchronize timeout (offline
CPU can't skip synchronize in this case).

Could "return true;" outside the if-case?
	if (mcgstatus & MCG_STATUS_RIPV) {
		mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
	} 
	return true; 

Sincerely
TonyWWang-oc
