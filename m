Return-Path: <linux-edac+bounces-1868-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCC4978516
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E146287221
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931643ADF;
	Fri, 13 Sep 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/jkJo/3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53695433BC;
	Fri, 13 Sep 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242497; cv=none; b=j41ucdT5mS9jZNpKw/e4aLh5aGM9fnhYDaHvDfzfWoSMAeFhXtQEHPl4FMU2z0o0n6ocHLTAZ/ALbrIG6yf4OsIOylqxq6uOhhijGDofyV22+dQblHWII13WmW+1PKGRW41DTvsEB6raFW5zkXuMwMzskR8h3KuID1pPxr0PGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242497; c=relaxed/simple;
	bh=vRauBE7G8wjVVj5B3tWCvDpoYN2r+D1qZVdsHIJfOgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYTuGaP1YRb5KgXZum++whps4cfr5r7pTyCfk0zV41K++D2juqZmBfM/I9Q2AQjQbEDF6mU6MW+wA6wlulz+cJC1xfHBMGjD8f9+Aonbdr59BXXXBcH7u9jHjK3jgDv/WrJnLZ/wuz3VZ/iK8JvzFauZ4o/HHGC8QGtnibTv4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/jkJo/3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726242495; x=1757778495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vRauBE7G8wjVVj5B3tWCvDpoYN2r+D1qZVdsHIJfOgs=;
  b=V/jkJo/349Ud8uEpeRAQ/+1ywcep3Smw4f5kUNHt0n4qWVVvAQpqc+h3
   OOmmh0HXLThHN+FpwNhnNjX+oYJdKCRl2fVP3O3SfnTcbtwN7sQziRdRS
   gE0+jURzQzE54dwhNjNQuUkvaEN+yzmARY0uhuskA9N6vYEMQE8kG7dd5
   PJdAcSmKrNNyKSSXvJyWAKQJgWV2Hxy9ZtzoWL7pCv2cYY59IfpEKJNZt
   F6XVOKmPszkitLpMi0QP2ACS0Mhy6CNh4A6Mnm05oQUb7MI1FSlg2JNBa
   z7cSf5E9Y6c8SnL5IKnSfjXvsqYGnZVYZ6ECJkCBhNPxeEDb+YxAYTAUZ
   w==;
X-CSE-ConnectionGUID: DuLoa1qQSNKNagNWlYJ7zQ==
X-CSE-MsgGUID: ptRuk7xIRW2ifcQ3KSKmpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25083272"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25083272"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 08:48:15 -0700
X-CSE-ConnectionGUID: eiGy0ZChSOCXtrT2dhkcwQ==
X-CSE-MsgGUID: bMIICokGR724V/JGay18mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68082867"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO [10.124.220.219]) ([10.124.220.219])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 08:48:13 -0700
Message-ID: <a25f878e-83d9-440a-9741-4cf86db4a716@intel.com>
Date: Fri, 13 Sep 2024 08:47:52 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
To: Borislav Petkov <bp@alien8.de>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com,
 Lyle Li <LyleLi@zhaoxin.com>
References: <20240909104349.3349-1-TonyWWang-oc@zhaoxin.com>
 <20240909104349.3349-2-TonyWWang-oc@zhaoxin.com>
 <20240913142703.GIZuRLt1-nDZrOsIlE@fat_crate.local>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240913142703.GIZuRLt1-nDZrOsIlE@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/24 07:27, Borislav Petkov wrote:
>> +	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
>> +		/*
>> +		 * All newer Centaur CPUs support MCE broadcasting. Enable
>> +		 * synchronization with a one second timeout.
>> +		 */
>> +		if ((c->x86 == 6 && c->x86_model == 0xf && c->x86_stepping >= 0xe) ||
>> +		     c->x86 > 6) {
>> +			if (cfg->monarch_timeout < 0)
>> +				cfg->monarch_timeout = USEC_PER_SEC;
>> +		}
>> +	}
> So if centaur == zhaoxin, why aren't you moving this hunk to
> mce_zhaoxin_feature_init() instead?

The centaur and zhaoxin logic is also _really_ close here:

>                 if (c->x86 > 6 || (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
>                         if (cfg->monarch_timeout < 0)
>                                 cfg->monarch_timeout = USEC_PER_SEC;
>                 }

vs

>         if ((c->x86 == 6 && c->x86_model == 0xf && c->x86_stepping >= 0xe) ||
>              c->x86 > 6) {
>                 if (cfg->monarch_timeout < 0)
>                         cfg->monarch_timeout = USEC_PER_SEC;
>         }

I'd just randomly guess that the zhaoxin version is buggy because it
doesn't do a c->x86 check before the "(c->x86_model == 0x19 ||
c->x86_model == 0x1f)".

So instead of copying and pasting the same block over and over, can we
consolidate it a bit?

foo()
{
	/* Older CPUs do not do MCE broadcast: */
	if (c->x86 < 6)
		return;
	/* All newer ones do: */
	if (c->x86 > 6)
		goto mce_broadcast;

	/* Family 6 is mixed: */
	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
		if (c->x86_model == 0xf &&
		    c->x86_stepping >= 0xe)
			goto mce_broadcast;
	} else if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
		if (c->x86_model == 0x19 ||
		    c->x86_model == 0x1f))
			goto mce_broadcast;
	}

	return;

mce_broadcast:
	if (cfg->monarch_timeout < 0)
		cfg->monarch_timeout = USEC_PER_SEC;
}


Heck, the Intel code can even go in there I think.  Wouldn't that tell
the story a bit better?


