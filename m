Return-Path: <linux-edac+bounces-5638-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45374D1B66B
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 22:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E33930119AB
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384882DA755;
	Tue, 13 Jan 2026 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hq93OiKC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48CA72621;
	Tue, 13 Jan 2026 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339946; cv=none; b=mvb88eqx8LUzNYvZ0AWil2K4ATom/FRtS3PD05M4Ze0E2yqa5niT1MxbR4G6yEsWKGegJJQtTALRRS383X/yTSUHNp10dSxd3qGYPpv16qh+22JBVcXCZCTUjfkJGvNQdXIs88oN2n089nTwlqU0ORcyiuKwQce4Sf4cpkWpXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339946; c=relaxed/simple;
	bh=KWpkaRMQAjG6cDWvy2IAqPkMIG7tJStzfPNpzLGAOK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXn9R3aU0GRxCrKcMEbL6Sw4FBeT/fBfOHRUXsoYzOWERMthhPDmEqrtDT55bs+38KWgbO5qeP8vqthQN/4yabkOq4zHNshG7e15iEudzx58yCMy0ha9LWNafboU3Z4Hnn+cpGtlQJ2aib2DfXDaCO12IaMQaLYuSGXrf3Vk8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hq93OiKC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A582440E01A9;
	Tue, 13 Jan 2026 21:32:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jk6pD49g41oM; Tue, 13 Jan 2026 21:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768339938; bh=3W9I5TZw4wJ3NjeGM7mSEAaZSO251ohajC3WqrQgaak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hq93OiKCJSXxhbvPlebope6f/i3iSe+5WmA0RWSVMz3m+OAOKZVqvQqjjmDTaPz2r
	 cTIfOWkqSJSW9KCPBXQQLV5JmHJqJKamUnaZaqnGs5CM9CWVVkNadKZXk1jjmyQPfu
	 eMGYV6pStnYitsduW6F+Lobe+OpfCbuVizkIOHZDGwRPD7zfhB8CeKqAVTHHpCLdwi
	 +wO+lIgoekaqbm0S8/MlbA7e4L5sXPdWZIGGgvVxeAEpQ6eBddIUCYiMdNY7+qFEkV
	 fmj/4zl9FzIcxG/9M8zr3iBkCnOe+spm9hMIOCZLn2mKss4zplmrnVae/YLW5rtlc3
	 icsa2sJwPDDoXiGYfemENsjzyUaEQaZRN7/Rs4p+ACzRgH9gsDa1zKqt/pSJXfykvo
	 8d6Gzolynlnj90XNLj9yFOALwU+wznkrLqIqCp6/AuQwTZIi4qkEFByorLDczHjA+F
	 0Z13NtU4rMzVnKxFscix+I5MKhX9b8D9MB4suD4Ub5VSQnNTAn69sdybTBfkWzLBKI
	 VDt2Kgx0BcoxIDtTPbG+S8Yns/21vGXQxaG8/vkfLYE6KFMQPZiWFDSjbRCwGjgwE0
	 DgUaVyicT3tltLinhoTMuua06KFonVJwfL4ldc6C7Jfd9uD2Enjs6bv8+MLBTDloox
	 Rfd7lhOjznPxXDSfVLSaMFhs=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C428240E0028;
	Tue, 13 Jan 2026 21:32:04 +0000 (UTC)
Date: Tue, 13 Jan 2026 22:31:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Li, Rongqing" <lirongqing@baidu.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSB4ODYvbWNl?=
 =?utf-8?Q?=3A?= Fix timer interval adjustment after logging a MCE event
Message-ID: <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
References: <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Jan 13, 2026 at 09:05:01PM +0000, Luck, Tony wrote:
> >> $ dmesg | grep 'Machine Check Event:'
> >
> > Did you see the "Machine check events logged\n" print from mce_notify_irq() in
> > dmesg too?
> 
> Yes.  I used the other grep pattern to see detail of which CPU/bank logged the error.
> Same pattern of timestamps shows up with this grep too.

Yah, this confirms the flow:

mce_timer_fn()-> ... -> machine_check_poll -> mce_log which will queue the
work and return.

Now, back in mce_timer_fn:

        /*
         * Alert userspace if needed. If we logged an MCE, reduce the polling
         * interval, otherwise increase the polling interval.
         */
        if (mce_notify_irq())


<--- we haven't ran the notifier chain yet so mce_need_notify is not set yet
so this won't hit and we won't halve the interval. I need to verify that
empirically.

                iv = max(iv / 2, (unsigned long) HZ/100);
        else
                iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));

And now the notifier chain runs. mce_early_notifier() sets the bit, does
mce_notify_irq(), that clears the bit and then the notifier chain a little
later (skx_edac) logs the error.

So this looks like a silly timing issue...

We could set mce_need_notify in mce_log(), zap this thing:

                if (__ratelimit(&ratelimit))
                        pr_info(HW_ERR "Machine check events logged\n");

in mce_notify_irq() or at least predicate it on the CEC being enabled and then
not call mce_notify_irq() in the notifier but leave it be called in the timer
function...

Ufff, how silly and overengineered we've made it. I need to think about
a cleaner solution tomorrow...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

