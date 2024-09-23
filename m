Return-Path: <linux-edac+bounces-1911-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF997E513
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2024 05:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AE2817D3
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2024 03:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF68C1A;
	Mon, 23 Sep 2024 03:42:46 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69D8F66
	for <linux-edac@vger.kernel.org>; Mon, 23 Sep 2024 03:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727062966; cv=none; b=EDF+geKIOFGahZZOX7T4iAXfNxnYrrSEQ2323L53MxgXreVTu6M/DAUAi3YPxSdvvdp0vHyxvwtWVZnDU0csFXGcq9Pzo34OZiGPzLVxqzFUGyQU1gvrHI2zM7j3TzdwCMRIbwiqMmVDwEBDjB7jInvzhx07O2SdsXuIodmCGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727062966; c=relaxed/simple;
	bh=eEGT1Vj+xoUWXnOzGW4bgCBN9bGO37na6FBJ+sfwfMg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=M3x7CceUJcTGntn/2uxG3y4dG6IjzLrE1+WSSECcXB/0nC3ePMj2Z7qRsJSJrBbUMcbeHMknRKXR+NXkASivlc+OO/1+neRL97GcQPkEmSw47Ao3RVsV7Htd3svidOJ+bbsfElnB0jtBHvgWp8Vw/KS90uICkp3MLruGK9Pbi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1727062217-086e236b0900d80001-QCVQLf
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id 4O77gCJUFKSGBsNz (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 23 Sep 2024 11:30:18 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Sep
 2024 11:30:17 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 23 Sep 2024 11:30:17 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from [10.32.65.165] (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Sep
 2024 11:23:03 +0800
Message-ID: <271465a0-7719-4cae-899a-dbf58a3d174a@zhaoxin.com>
Date: Mon, 23 Sep 2024 11:23:00 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-ASG-Orig-Subj: Re: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Luck,
 Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, "LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-4-TonyWWang-oc@zhaoxin.com>
 <CY8PR11MB71344BE2857EA522CF71DBA1896C2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <7a80b9f5-9503-45fa-bbf4-d0dfa97688ff@zhaoxin.com>
 <CY8PR11MB713412D068F202057A71CDE8896C2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <acf35354-ab97-4441-828f-daf7affa20ac@zhaoxin.com>
Content-Language: en-US
In-Reply-To: <acf35354-ab97-4441-828f-daf7affa20ac@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/23/2024 11:30:15 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1727062218
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2229
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130834
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Resend this mail because I received the message: Undelivered Mail=20
Returned to Sender

On 2024/9/20 20:09, Tony W Wang-oc wrote:
>=20
>=20
> On 2024/9/20 19:44, Zhuo, Qiuxu wrote:
>>
>>
>>> From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>>> [...]
>>>>> --- a/arch/x86/kernel/cpu/mce/zhaoxin.c
>>>>> +++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
>>>>> @@ -63,3 +63,21 @@ void mce_zhaoxin_feature_clear(struct cpuinfo_x86
>>>>> *c) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 intel_clear_lmce();
>>>>> =C2=A0=C2=A0 }
>>>>> +
>>>>> +void mce_zhaoxin_handle_storm(int bank, bool on) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 u64 val;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 raw_spin_lock_irqsave(&cmci_discover_lock, =
flags);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (on) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 val &=3D ~(MCI_CTL2_CMCI_EN |
>>>>> MCI_CTL2_CMCI_THRESHOLD_MASK);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 val |=3D CMCI_STORM_THRESHOLD;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 val &=3D ~MCI_CTL2_CMCI_THRESHOLD_MASK;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 val |=3D (MCI_CTL2_CMCI_EN | cmci_threshold[bank]);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 raw_spin_unlock_irqrestore(&cmci_discover_l=
ock, flags); }
>>>>
>>>> Are there any reasons or comments why it needs to disable/enable the
>>>> CMCI interrupt here during a CMCI storm on/off? If not, then reuse
>>>> mce_intel_handle_storm() to avoid duplicating the code.
>>>>
>>>
>>> As explained in another email.
>>> The reason is actually mentioned in the cover letter: "because=20
>>> Zhaoxin's UCR
>>> error is not reported through CMCI", and we want to disable CMCI=20
>>> interrupt
>>> when CMCI storm happened.
>>
>> So, this is just you want to disable CMCI when a CMCI storm happens.
>> This doesn't explain much to me.
>> What's the problem if not disable CMCI when a CMCI storm happens?
>>
>=20
> In practice, we have encountered a lot of CE errors such as DRAM CE=20
> errors, so it feels safer to disable CMCI interrupt than to set a large=20
> threshold. At the same time, Zhaoxin's UCR is not reported through CMCI,=
=20
> so we implemented like this.
>=20
> Sincerely
> TonyWWang-oc
>=20

