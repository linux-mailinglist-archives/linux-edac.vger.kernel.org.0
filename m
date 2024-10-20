Return-Path: <linux-edac+bounces-2158-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EFC9A51C6
	for <lists+linux-edac@lfdr.de>; Sun, 20 Oct 2024 02:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8255B1C20DE3
	for <lists+linux-edac@lfdr.de>; Sun, 20 Oct 2024 00:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF5EBE;
	Sun, 20 Oct 2024 00:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gLy8RHAM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C517E1;
	Sun, 20 Oct 2024 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729383941; cv=none; b=uytO6mkXzLrw8FX5ppU76BdparhqvEt0HzfOlkFoMyra0Ennod+i7xIFChysYQoRfGiN2jjDKuHQMvTU822fALP8SHuEmNUUA+RKkQ1PDvbN0XwLOWideSHGAeVQUPe8/f13oP7AHo2mBMHUvmgyltFOD2lqFVv4vmUPa2Y2U7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729383941; c=relaxed/simple;
	bh=MNshfbPvWfiA+uzt1SanT9VGg8mSTiW+KVEqWw0LFrc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Bz+jdZzgvUxZA4tacuT9YUhr4BE1mlFlmQ5SvPdkJOdDITHvxqMomHn3dBj3c07mN8kApZU1/6ekayxxPOFCuxEZbi9GyNEBFsFTBHOmhUBdhrEQho8kS0eD8pSE5E0ncLfYaQkRysugWVg0Hm2qq0wZyLAKzEOP2ANHI/NvMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gLy8RHAM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49K0P4Oo3759355
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 19 Oct 2024 17:25:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49K0P4Oo3759355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1729383906;
	bh=MNshfbPvWfiA+uzt1SanT9VGg8mSTiW+KVEqWw0LFrc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gLy8RHAM9G0kfZxjcctOh/+pO2RK1Jpc5qa1cHc99fagEJ0Y7l4Rvht67zHMSEZ75
	 Dd0EGyHJh7LKlBSsXgnEOshD4/jAvAN/bijsxatUq0Upoq4hYlGWweZ2amcZlz2y9D
	 bXfhf07+b7vMEOgc59DvNKOV+lywqlwiGPg6u0NhIeYVw6UvLYET8zy0TXpkKVh5SA
	 SZX7bDQfHrghTqLwf7SjQdYdZ94w4+wjlWSf3ojTsGQjwD5rnZ+8Du0vLdfs1apfRs
	 bdoSw+YmbESeKxNAfDIUGpEg8+W/BuLDHfpQKBMfeaU+AFPDVf7GdG6d6Loj6176DA
	 0UWlrA+J6yPJQ==
Date: Sat, 19 Oct 2024 17:25:03 -0700
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
In-Reply-To: <CY8PR11MB7134A69052C691C9B2812F2189412@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com> <20241016123036.21366-1-qiuxu.zhuo@intel.com> <20241016123036.21366-9-qiuxu.zhuo@intel.com> <f5d4d763-0fa2-4d84-8501-28d8cd8a1dde@intel.com> <CY8PR11MB71344BDC1A3AB4454FE9446A89412@CY8PR11MB7134.namprd11.prod.outlook.com> <36673130-7548-4BE5-8E70-ACC100A0BDBF@zytor.com> <CY8PR11MB7134A69052C691C9B2812F2189412@CY8PR11MB7134.namprd11.prod.outlook.com>
Message-ID: <E0031941-4ADB-4BEC-A913-4E74B88A60CA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 19, 2024 1:30:04 AM PDT, "Zhuo, Qiuxu" <qiuxu=2Ezhuo@intel=2Ecom=
> wrote:
>> From: H=2E Peter Anvin <hpa@zytor=2Ecom>
>> [=2E=2E=2E]
>>=20
>> Keep in mind that usually the compiler will remove redundant assignment=
s,
>> and if they are too obscure for the compiler to discover, they are prob=
ably too
>> subtle for programmers to not introduce bugs in the future =2E=2E=2E
>
>Thanks, H=2EPeter=2E
>
>This is a good tip to quickly check whether a cleanup of removing unneces=
sary
>assignments changes the function=2E If there is no difference in the text=
 before and
>after the cleanup, then it's OK=2E Otherwise, the cleanup probably change=
s the=20
>function in an unintended way=2E
>
>-Qiuxu
>

Yes and no=2E Deleting things like redundant reinitialization should only =
be done if it makes the code clearer=2E You can think of the redundant stat=
ements as comments/asserts=2E

