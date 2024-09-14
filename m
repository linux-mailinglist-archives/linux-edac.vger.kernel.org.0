Return-Path: <linux-edac+bounces-1875-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B6978FE1
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2024 12:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA66E1C21CC2
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2024 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D721CEAD8;
	Sat, 14 Sep 2024 10:12:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43461CEAAA
	for <linux-edac@vger.kernel.org>; Sat, 14 Sep 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308724; cv=none; b=GosFpS/n1Yp4GJXnFQaR6w5nA7ZbwoSsmKvJ8iUt28d1kfWqe8RBPsXc2ak+IguTKHpAyLRjJLxDGJw2C8t6IFqbSzuRZPUuB6UZx7Eq+6jkIhY5GJuCad1muag82WyVsbD+Lk3E4jm8zkrIF38STL7i6cfipTGYNVOdX+UcIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308724; c=relaxed/simple;
	bh=wPI3zNhSdv3gb78ggllcLXpOTosR4Rj2VqflNSUysxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pF27TM+H+w3RQgLY0b2fB4vfxCxY9ruYrxPaZDUI2MzKdAUp7BzNplDYHlS9Ow5VoBpnnfpSst7ZkxzD4VqnRrFg0PaZqAKEj3DYHh+3Dw4c50AHXK8yIQDA4lDfEuD9zGxO3DG3NUco7DHIbwrf5zdm7HjW6eJFbKwMR7YpkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726308719-1eb14e31a7106210001-QCVQLf
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id nfZBCpheHgHbejwd (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 14 Sep 2024 18:11:59 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 14 Sep
 2024 18:11:59 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Sat, 14 Sep 2024 18:11:59 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from [10.32.65.165] (10.32.65.165) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 14 Sep
 2024 17:36:40 +0800
Message-ID: <64b1becd-ebf8-40ae-af5a-59d32b652362@zhaoxin.com>
Date: Sat, 14 Sep 2024 17:36:39 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
X-ASG-Orig-Subj: Re: [PATCH v1 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
References: <20240909104349.3349-1-TonyWWang-oc@zhaoxin.com>
 <20240909104349.3349-2-TonyWWang-oc@zhaoxin.com>
 <20240913142703.GIZuRLt1-nDZrOsIlE@fat_crate.local>
 <a25f878e-83d9-440a-9741-4cf86db4a716@intel.com>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <a25f878e-83d9-440a-9741-4cf86db4a716@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/14/2024 6:11:58 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1726308719
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2639
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130434
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/9/13 23:47, Dave Hansen wrote:
>=20
>=20
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>=20
> On 9/13/24 07:27, Borislav Petkov wrote:
>>> +    if (c->x86_vendor =3D=3D X86_VENDOR_CENTAUR) {
>>> +            /*
>>> +             * All newer Centaur CPUs support MCE broadcasting. Enable
>>> +             * synchronization with a one second timeout.
>>> +             */
>>> +            if ((c->x86 =3D=3D 6 && c->x86_model =3D=3D 0xf && c->x86_=
stepping >=3D 0xe) ||
>>> +                 c->x86 > 6) {
>>> +                    if (cfg->monarch_timeout < 0)
>>> +                            cfg->monarch_timeout =3D USEC_PER_SEC;
>>> +            }
>>> +    }
>> So if centaur =3D=3D zhaoxin, why aren't you moving this hunk to
>> mce_zhaoxin_feature_init() instead?
>=20
> The centaur and zhaoxin logic is also _really_ close here:
>=20
>>                  if (c->x86 > 6 || (c->x86_model =3D=3D 0x19 || c->x86_m=
odel =3D=3D 0x1f)) {
>>                          if (cfg->monarch_timeout < 0)
>>                                  cfg->monarch_timeout =3D USEC_PER_SEC;
>>                  }
>=20
> vs
>=20
>>          if ((c->x86 =3D=3D 6 && c->x86_model =3D=3D 0xf && c->x86_stepp=
ing >=3D 0xe) ||
>>               c->x86 > 6) {
>>                  if (cfg->monarch_timeout < 0)
>>                          cfg->monarch_timeout =3D USEC_PER_SEC;
>>          }
>=20
> I'd just randomly guess that the zhaoxin version is buggy because it
> doesn't do a c->x86 check before the "(c->x86_model =3D=3D 0x19 ||
> c->x86_model =3D=3D 0x1f)".
>=20

Yes, the check for c->x86 =3D=3D 6 is omitted in the zhaoxin version.

> So instead of copying and pasting the same block over and over, can we
> consolidate it a bit?
>=20
> foo()
> {
>          /* Older CPUs do not do MCE broadcast: */
>          if (c->x86 < 6)
>                  return;
>          /* All newer ones do: */
>          if (c->x86 > 6)
>                  goto mce_broadcast;
>=20
>          /* Family 6 is mixed: */
>          if (c->x86_vendor =3D=3D X86_VENDOR_CENTAUR) {
>                  if (c->x86_model =3D=3D 0xf &&
>                      c->x86_stepping >=3D 0xe)
>                          goto mce_broadcast;
>          } else if (c->x86_vendor =3D=3D X86_VENDOR_ZHAOXIN) {
>                  if (c->x86_model =3D=3D 0x19 ||
>                      c->x86_model =3D=3D 0x1f))
>                          goto mce_broadcast;
>          }
>=20
>          return;
>=20
> mce_broadcast:
>          if (cfg->monarch_timeout < 0)
>                  cfg->monarch_timeout =3D USEC_PER_SEC;
> }
>

Thank you! That makes more sense, and will adopt it into zhaoxin.c

Sincerely!
TonyWWang-oc

