Return-Path: <linux-edac+bounces-3150-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0EAA3B357
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 09:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B265E16E6A9
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94551C54B2;
	Wed, 19 Feb 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Py8UWr1E"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532B192B66;
	Wed, 19 Feb 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952679; cv=none; b=m5n7SrR0z7bEWgAa31RINHZqxY4VcziPi8P8/grO7Cbtxe2Dv2M0umaqUxuAQemOvJdcI8/uylx6iuwskt5AbZXJzH5NrYdXg9nDPylgY1b87AlicQglb8+38z4iUpMlr/HEZ2F5MwqhMvOlAxPLdnRUIdmQjOlC1QZMCd5Wxxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952679; c=relaxed/simple;
	bh=IPe8Mxi647OUSrYabRzCQyT6Z0JhgCU5DJgBF03pA2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVoKBik1D5IJbp25bM3NMWAhg1GVgt67eWD9I8ODkfrMTj3gn1GYvacSx7r1Aj96XXIpHUjMw0ZBkaRAutIpCaz+psUL+cPhcYX5/v4egdMFznRmE9nyCU2wtpIW0Zo+bzMEfEc/xFjQk2dTNvfRI6cPCzY8F4gW8fruPcAB+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Py8UWr1E; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F33AA40E01B2;
	Wed, 19 Feb 2025 08:11:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Yx0b9ewn8JZF; Wed, 19 Feb 2025 08:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739952662; bh=ZxQ67/I/xzQUJoLjt+WwJVnLywiFGJ9l3cBldN2lLJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Py8UWr1Eb6EHHSx3RoMXjTfvLHvkvDTfvb8p0GcXlWgPHG91sJE/iBAnynl+p0hHF
	 wW7ISwgyJh8TQHaFfruoOqqDZVdDGKq4E7hdMKzKmDT6xkzYiebfKFt2WH/+1gtV8I
	 0Omb2B3LxXpbToMVtkjPwNRC2xLfzBER5LxdpGlewrdOD63wrz6rJQQPbWbEPYgf/N
	 cmNirB0fA3yVLL41CuK8AACePAvELHEOBYF85EorLhlK5iITO68SqbZL9MtXLQ5C5v
	 13b3RJMBrgOVZ6aTjxZ/Xd6ygp3KSGujA8qW8uCJt8nI+WQDQiN1B1HxZ/ZynhbjBl
	 Lb/uY7zaSVQ3i9Oke8+LQkaypA/xcZgiLK86ua8Sq7QFQnXk0/kQrveQtWbslYhIMq
	 GHobiU8DVOgKjJxYsb1qSesw/qqNOa1r9XRxJCuvVLJJ7tkFq+78n972yjXLML4KaK
	 zAARqZl7NfKVPlmaEd7IhaBXSKPDeIOljMQ078aux8/EMVx3duclNqp+4qbvhnFUU5
	 Ijb20n0NjbA5hZMtwWlSOJAB/lDTZr7y5CMJOJ+f7btjVVjMvSg8WcS+VxNedUcMhF
	 4CKnTKRmY+og36kfc1wIWRHaHOUgOy2lCt0aSn36wLY/v9GxLotOTty/gjKU070lpS
	 1jFpP5V551fnLIB7/bvB0f5Y=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF11440E0221;
	Wed, 19 Feb 2025 08:10:44 +0000 (UTC)
Date: Wed, 19 Feb 2025 09:10:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Message-ID: <20250219081037.GAZ7WR_YmRtRvN_LKA@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Feb 18, 2025 at 05:30:19PM +0000, Luck, Tony wrote:
First of all, thanks for explaining - that helps a lot!

> That's how we ended up with *UN*corrected errors tied to *C*MCI.
> 
> Just to add to the confusion, Linux does take an action (in uc_decode_notifier())
> to try to offline the page despite the UC*NA* signature name.

So, AFAIU, hw folks are basically trying to tell us: well, this is
*technically* an uncorrectable error but meh, not really important. We just
met it while fetching some data while scrubbing so who knows whether you'll
consume it or not. Meh...

So why don't we simply do that?

We report the signature but we do not try to offline anything. When we get to
*actually* consume it non-speculatively, *then* we run memory failure and then
we offline the page.

Hmmm?

Would that solve that particular debacle?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

