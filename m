Return-Path: <linux-edac+bounces-1874-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C55B978FE2
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2024 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24431F2280D
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2024 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DCC1CEAD9;
	Sat, 14 Sep 2024 10:12:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8541CDFC9
	for <linux-edac@vger.kernel.org>; Sat, 14 Sep 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308724; cv=none; b=l1Ut6GlD8MmDd7nwm39LmFPD6EqWx63Pd9fD3HnhsMgrV3/UsybLNlwBN8eOJvlnJauU+4Ruoeg1W1SAI+7z4R+qwktHUVaiSESloZGY+YU2+iZOlvyQdWa9NWV1UOPjOoASVRYTtXeS//AQ5FnCUJ8GQeCzByXpoA/HXc126ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308724; c=relaxed/simple;
	bh=HrjmDJJA9yGRkcP4eE+PN28L3YSOHcVEY+CZfDstrKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rZ14DU1E1YfsbKWe9+5tHNFjKQQeDOw1vnWHS23wjtVSfeY4FWZUGo4nscJt2MaqmLojtAKbHkJX0DP7NVCIWp0wKM0UzhSq7UEWBxW0e9wX/+0cndoZO7Ze0KsNyh0p0nD4irx5w19nK59GUqh8y4SaDdfF8bM+X91ljNuDrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726308718-1eb14e31a8106680001-QCVQLf
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id aJ9svyBqYTnFS9Gn (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 14 Sep 2024 18:11:58 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 14 Sep
 2024 18:11:58 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Sat, 14 Sep 2024 18:11:58 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [10.32.65.165] (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 14 Sep
 2024 17:36:19 +0800
Message-ID: <aaef59e8-4ef7-4515-b4c0-a321f05a9c18@zhaoxin.com>
Date: Sat, 14 Sep 2024 17:36:12 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
To: Borislav Petkov <bp@alien8.de>
X-ASG-Orig-Subj: Re: [PATCH v1 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
References: <20240909104349.3349-1-TonyWWang-oc@zhaoxin.com>
 <20240909104349.3349-2-TonyWWang-oc@zhaoxin.com>
 <20240913142703.GIZuRLt1-nDZrOsIlE@fat_crate.local>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240913142703.GIZuRLt1-nDZrOsIlE@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/14/2024 6:11:57 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1726308718
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1015
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130434
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/9/13 22:27, Borislav Petkov wrote:
>=20
>=20
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>=20
> On Mon, Sep 09, 2024 at 06:43:47PM +0800, Tony W Wang-oc wrote:
>> @@ -1970,6 +1974,18 @@ static int __mcheck_cpu_apply_quirks(struct cpuin=
fo_x86 *c)
>>                }
>>        }
>>
>> +     if (c->x86_vendor =3D=3D X86_VENDOR_CENTAUR) {
>> +             /*
>> +              * All newer Centaur CPUs support MCE broadcasting. Enable
>> +              * synchronization with a one second timeout.
>> +              */
>> +             if ((c->x86 =3D=3D 6 && c->x86_model =3D=3D 0xf && c->x86_=
stepping >=3D 0xe) ||
>> +                  c->x86 > 6) {
>> +                     if (cfg->monarch_timeout < 0)
>> +                             cfg->monarch_timeout =3D USEC_PER_SEC;
>> +             }
>> +     }
>=20
> So if centaur =3D=3D zhaoxin, why aren't you moving this hunk to
> mce_zhaoxin_feature_init() instead?
>=20
>
Ok, will adjust the patch in the next version.

Sincerely!
TonyWWang-oc

