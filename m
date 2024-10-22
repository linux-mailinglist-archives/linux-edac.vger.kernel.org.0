Return-Path: <linux-edac+bounces-2175-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E35B9A949C
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 02:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6100D1C21BC0
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 00:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC64A35;
	Tue, 22 Oct 2024 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlZ18t27"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0D81E;
	Tue, 22 Oct 2024 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556257; cv=none; b=Kyx/dxR5JxGvhZzcjl7sSHYqCZRXwL25hY0bS499ZXzKvMxaOy73LUO4fiHhR37Jx0YRILGmzS105hZCZm1OiXAJIRVkt+FaipgBynnVjsdcPkMhqq0GEQsvxDalM9hpeH6x9dq/r1nzdo+FWmngatRAhDxeDD4yIVomwx3RE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556257; c=relaxed/simple;
	bh=wqfHdyxb/kjiHcZmQPqoNSZPVIR84oe8ss6HVFUOwzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvYwr7gU9eN+4tQHJy1OffX5N6a3fSRLyFAmFzPeG1G9ACvxL8bxoYjlQyFNcfN4sq8dxm3Ws8a9vDJONn4LaksGD9pEsX2nGCv76xcIHRyRaYBtpCZ+QIKY73l+KRpPUFolsjcGYOM0hSDw03NrV4yU/kfWwKguqWfMVf5gwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlZ18t27; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729556256; x=1761092256;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wqfHdyxb/kjiHcZmQPqoNSZPVIR84oe8ss6HVFUOwzg=;
  b=GlZ18t27pZvRrpXRBfy44tIm9JBL6c8FTQvevuifjU5seeNfPn44LQba
   a9pzg+Gamz+yGWKpEXF0pXcXd0a6F5A0STmYRrVcRvPDk+6hAx+npTv3U
   JgpbqXQiD5L8+4BYjLRUsoukaUfM3xmAwBjx6A7djYvncaC3QT4zWIUUd
   Ng61FKp0/Y+r6ZqSEa/KIwntlXQDv42i3q/UC2D9uPa99W8xii4Rvjlz8
   guUkWvq2i2m2Bt03fW/3bcZLiGtVaTShY71fQhbcmjsuZVPcWoKu6yQZ8
   koxfHAr37U7vTrQ57mXWQpxvO34WcZ2ItmBs5w4Bjve1u0NwhYUqduY48
   w==;
X-CSE-ConnectionGUID: Aep2jQ6bSjOr3q5HiB6gMA==
X-CSE-MsgGUID: azezhFMWQau628RE5Zx11A==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="54472250"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="54472250"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 17:17:35 -0700
X-CSE-ConnectionGUID: MnR38BX4RmCrpfgk41urDg==
X-CSE-MsgGUID: K1ZSWeElSoKympaffv36Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79621338"
Received: from gargmani-mobl1.amr.corp.intel.com (HELO [10.124.223.237]) ([10.124.223.237])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 17:17:34 -0700
Message-ID: <8489127b-1292-475d-b67a-b0fc868d8a4b@intel.com>
Date: Mon, 21 Oct 2024 17:17:33 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
To: Sohil Mehta <sohil.mehta@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
 <SJ1PR11MB60832636201CA40AD13C02C1FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7a902c13-bfdf-4319-9e31-81c199ecf65c@intel.com>
 <SJ1PR11MB6083E463572AC9E110A7199FFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <42d59ea5-5b36-49cd-b04a-4480064fff02@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <42d59ea5-5b36-49cd-b04a-4480064fff02@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/21/24 15:57, Sohil Mehta wrote:
> On 10/21/2024 11:40 AM, Luck, Tony wrote:
>>>> Intel model number allocation policies aren't necessarily sequential.
>>> Model numbers are assumed to be sequential at least within family 6.
>> Assumption can only be applied retroactively to simpler times.  Looking
>> at the timelines and model numbers for pure-Atom, pure-Core, Hybrid,
>> and Xeon, they are somewhat jumbled.
>>
> Agreed. Using range checks within a family with extreme care and
> avoiding cross-family ones seems like the saner thing to do.
> 
> Maybe everything in the future is enumerated and VFM checks would not be
> needed 🙂
> 
> Trying to understand more, I have more questions than answers. With the
> introduction of Family 0x19, do we need to reevaluate some of the
> existing model checks?
> 
> early_init_intel():
> if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
>     (c->x86 == 0x6 && c->x86_model >= 0x0e))
> 	set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> 
> It seems "constant_tsc" wouldn't show on Diamond rapids. Do we need it to?

We only have a handful of these and they're mostly for early family 6
things.  I bet there's less than half a dozen.

Let's just list them in one of our match structures:

const u32 NOT_SUPPORTED = UINT_MAX; // or another special, invalid VFM
const u32 ALL_SUPPORTED = 0;

static const struct x86_cpu_id table[] __initconst = {
	X86_MATCH_FAM(INTEL,   3, NOT_SUPPORTED),
	X86_MATCH_FAM(INTEL,   4, NOT_SUPPORTED),
	X86_MATCH_FAM(INTEL,   5, NOT_SUPPORTED),
	X86_MATCH_FAM(INTEL,   6, INTEL_CORE_YONAH),
	X86_MATCH_FAM(INTEL, 0xf, INTEL_P4_WHATEVER),
	X86_MATCH_VEN(INTEL,      ALL_SUPPORTED),
};

... and then use it like this:

	m = x86_match_cpu(table);
	// Non-Intel lands here:
	if (!m)
		return false;

	if (VFM_MODEL(c->x86_vfm) >= m->driver_data)
		return true;

	return false;

