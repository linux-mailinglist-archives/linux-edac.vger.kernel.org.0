Return-Path: <linux-edac+bounces-2019-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3F499B221
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 10:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70BBAB216E1
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E71459E4;
	Sat, 12 Oct 2024 08:31:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4E33F7
	for <linux-edac@vger.kernel.org>; Sat, 12 Oct 2024 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721881; cv=none; b=GATEYXUh4EaIBLn1V2TOd5vRKIq2cvcTECsDd9o77hbCcD2tc6N44fBYra90Xv3ILIZMoSsToaESDEzaFHe9rSEycsxBOYrqJb2k73iYC0YDUjeFSFY8O+YXMA1zYB9okn3rlSyVdnUfs7a+B+El2WMPCtvNoWSTyXap1HbC1Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721881; c=relaxed/simple;
	bh=fWMU4Rh1LxdGdrJ3KljRdmkrmlDXGYwDjkphv02BA5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rnTcgmi95/3zXvknK2Iho6Q9JMwgfXhY70RcWCrz11P1706xPurRUh8PzwMXZql8pJ69yaalWZ73ua8P2a4i1hCRiBeaJMcWWSyjzldmdsn6+hjkFCSdXLCIETFumg+G2GY8A60henqj87Wh7zsXY0gvHPO6bLdpzEGD/0MRZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1728720799-086e23455b01390001-QCVQLf
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id FUfsh76yKCitZA1E (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 12 Oct 2024 16:13:19 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 12 Oct
 2024 16:13:19 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Sat, 12 Oct 2024 16:13:19 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [10.32.65.156] (10.32.65.156) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 12 Oct
 2024 15:57:12 +0800
Message-ID: <47dd0e33-4204-42c4-9176-207d65fa3217@zhaoxin.com>
Date: Sat, 12 Oct 2024 15:56:52 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] x86/mce: Add CMCI storm switching support for
 Zhaoxin
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Luck,
 Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v4 4/4] x86/mce: Add CMCI storm switching support for
 Zhaoxin
CC: "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, "LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
References: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-5-TonyWWang-oc@zhaoxin.com>
 <CY8PR11MB7134AA927F62C14DDCA36B1E897A2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <CY8PR11MB7134AA927F62C14DDCA36B1E897A2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 10/12/2024 4:13:18 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1728720799
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1885
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.131700
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/10/12 15:13, Zhuo, Qiuxu wrote:
>=20
>=20
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>=20
>> From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> [...]
>> Subject: [PATCH v4 4/4] x86/mce: Add CMCI storm switching support for
>> Zhaoxin
>>
>> From: Lyle Li <LyleLi@zhaoxin.com>
>>
>> Zhaoxin CPUs support CMCI compatible with Intel, because Zhaoxin's UCR e=
rror
>> is not reported through CMCI, and in order to be compatible with intel's=
 CMCI
>> code, so add Zhaoxin CMCI storm toggle to support the new CMCI storm
>> switching in mce/intel.c, mce/zhaoxin.c, mce/threshold.c, and mce/intern=
al.h.
>=20
> Could you tweak and simplify the commit message, like this:
>=20
>      Zhaoxin CPUs support CMCI which is compatible with Intel, but their =
UCR errors are
>      not reported through CMCI like Intel's. To be compatible with Intel'=
s CMCI code,
>      add Zhaoxin's specific CMCI storm toggle.
>=20
>> [...]
>> diff --git a/arch/x86/kernel/cpu/mce/internal.h
>> b/arch/x86/kernel/cpu/mce/internal.h
>> index 836e56027..086b833c5 100644
>> --- a/arch/x86/kernel/cpu/mce/internal.h
>> +++ b/arch/x86/kernel/cpu/mce/internal.h
>> @@ -7,7 +7,7 @@
>>
>>   #include <linux/device.h>
>>   #include <asm/mce.h>
>> -
>> +#include <linux/spinlock.h>
>=20
> Please sort the header files, like this:
>=20
>      #include <linux/device.h>
>      #include <linux/spinlock.h>
>=20
>      #include <asm/mce.h>
>=20
> And keep a blank line here as it was.
>=20
>>   enum severity_level {
>>        MCE_NO_SEVERITY,
>>        MCE_DEFERRED_SEVERITY,
>> @@ -334,11 +334,16 @@ static __always_inline u32 mca_msr_reg(int bank,
>> enum mca_msr reg)  }
> [...]
>=20
> Other than that:
>=20
>      Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Thank you for reviewing this patchset. v5 will be resent according to=20
your suggestion.

Sincerely
TonyWWang-oc

