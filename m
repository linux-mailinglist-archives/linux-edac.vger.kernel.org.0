Return-Path: <linux-edac+bounces-2155-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F89A4BE1
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 09:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D622836E9
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7051DB52D;
	Sat, 19 Oct 2024 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TDmTMxKW"
X-Original-To: linux-edac@vger.kernel.org
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEE1922DC;
	Sat, 19 Oct 2024 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729323865; cv=none; b=GGGzCHvCGe3RcXvskj0nG14bBkMMZPRW0nZBDk8gyasyLeSZ/WZQxIelHTqxuGa5NXV52is2oxk5syOb4inStuKB99FmDILGtODSS0LO2dWaBpSrHM+o24vzMcPKP2cu63qoaw5m5riw20/LydpGDzWmyEUrya1BhuUeCZhmCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729323865; c=relaxed/simple;
	bh=xOE2yI2wDnJw3YNYkHVQvav5aH/2PQWnRqL/b7LMCfI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=l1uA1/QUPNx81a7jAl4D2NlYfwEb1O/4bRVA0BZzgc1nkHMZeMJ7pLXYA/S7wj98XnRaMowtBgKRholkMKSQDpQLQ5DjWS4mT9vDmF2zpI1WyV4Y0LnLrNecBBQheHzJ1F/1djwn06o9IDkS12gzjGxEyxMSFHUyIhHzxiG6fVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=TDmTMxKW; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.209.71])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49J7eDjD3445452
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 19 Oct 2024 00:40:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49J7eDjD3445452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1729323617;
	bh=6RwBI6Tgq+4KVLmTV8e3LMN7G/Yez/JAfgnrvWDb2Ks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=TDmTMxKWQQixfvSr3MiW/lLq7AluDqwgPZ/6HEnaZgkwAVrU6QL0QrWTBMaI1Ju0E
	 ChdbxW042cSF7X3cUbvzuKyWcqGMnXBnwEX9E6RImLLu12HxK50xuyAbsJl1gvAb3k
	 eUET277bZ4yvZnx7FlvvekmEPGu2r7t7njslndlOnu9g/ZXL6eaMhzJLsju1Cne8r3
	 6KPRQODvRrhh24l6xlTT5Q9UwUlPeEaF1oPQmTNu+BJi/xR+u7dtNDxnBdWCcebMzl
	 Kb3LOzL5hhGpVXkYvzm68AqYGSBejB9nRtWwmzMNxawpgWhSmo923pEo0nuKe4uwtd
	 +aHWuKYopJtqQ==
Date: Sat, 19 Oct 2024 00:40:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_v2_08/10=5D_x86/mce=3A_Remov?=
 =?US-ASCII?Q?e_the_redundant_zeroing_assignments?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CY8PR11MB71344BDC1A3AB4454FE9446A89412@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com> <20241016123036.21366-1-qiuxu.zhuo@intel.com> <20241016123036.21366-9-qiuxu.zhuo@intel.com> <f5d4d763-0fa2-4d84-8501-28d8cd8a1dde@intel.com> <CY8PR11MB71344BDC1A3AB4454FE9446A89412@CY8PR11MB7134.namprd11.prod.outlook.com>
Message-ID: <36673130-7548-4BE5-8E70-ACC100A0BDBF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 19, 2024 12:37:05 AM PDT, "Zhuo, Qiuxu" <qiuxu=2Ezhuo@intel=2Eco=
m> wrote:
>> From: Mehta, Sohil <sohil=2Emehta@intel=2Ecom>
>> [=2E=2E=2E]
>> > @@ -1284,8 +1282,6 @@ __mc_scan_banks(struct mce *m, struct pt_regs
>> *regs, struct mce *final,
>> >  		if (!mce_banks[i]=2Ectl)
>> >  			continue;
>> >
>> > -		m->misc =3D 0;
>> > -		m->addr =3D 0;
>> >  		m->bank =3D i;
>> >
>>=20
>> However, in this case, I am not fully convinced if the misc and addr wo=
uld
>> already be 0 when we reach here=2E
>>=20
>> There are potentially a lot of things that happen in do_machine_check()
>> between mce_gather_info() and __mc_scan_banks()=2E Especially,
>> mce_no_way_out() which could theoretically call mce_read_aux() in some
>> cases=2E
>>=20
>> Maybe it doesn't matter, misc and addr would be overwritten anyway=2E B=
ut I
>> feel some more details in the commit message would be useful=2E It does=
n't
>> seem as simple as the brief description makes it sound (at least to me)=
=2E
>>=20
>
>Your concern is reasonable=2E Thanks!
>
>For both diffs, mce->misc and mce->addr can be guaranteed to be zeroed th=
e first time
>they reach here=2E However, I didn't notice that both diffs were in a for=
() loop where=20
>mce->misc and mce->addr could retain the old values assigned by mce_read_=
aux() in=20
>the previous iteration=2E So need to zero mce-misc and mce->addr in each =
iteration to=20
>ensure they don't contain stale values=2E=20
>
> I'll drop this patch in the next version=2E
>
>-Qiuxu
>

Keep in mind that usually the compiler will remove redundant assignments, =
and if they are too obscure for the compiler to discover, they are probably=
 too subtle for programmers to not introduce bugs in the future =2E=2E=2E

